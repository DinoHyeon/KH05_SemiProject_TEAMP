package semi.teamP.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import semi.teamP.dto.AdminDTO;
import semi.teamP.dto.MemberDTO;

public class AdminDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	ResultSet rsT = null;
	
	public AdminDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	private void resClose() {
		try {
			if(rs != null) {
				rs.close();
			}
			if(rsT != null) {
				rsT.close();
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	public ArrayList<AdminDTO> MemberList() {
		ArrayList<AdminDTO>list = new ArrayList<>();
		String sql = "SELECT * FROM member WHERE member_lv='member' OR member_lv='master'";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setMember_Id(rs.getString("member_id"));
				dto.setMember_name(rs.getString("member_name"));
				dto.setMember_lv(rs.getString("member_lv"));
				int groupNum = getGroupIdx(rs.getString("member_id"));
				if(groupNum != 0){
					dto.setGroup_idx(groupNum);
					dto.setGroup_name(getGroupName(groupNum));
				}
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}
	
	private int getGroupIdx(String id) {
		int groupIdx = 0;
		String sql = "SELECT group_idx FROM member_group WHERE member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rsT=ps.executeQuery();
			if(rsT.next()) {
				groupIdx = rsT.getInt("group_idx");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupIdx;
	}
	
	private String getGroupName(int groupIdx) {
		String groupName = "";
		String sql = "SELECT group_name FROM group_project WHERE group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupIdx);
			rsT=ps.executeQuery();
			if(rsT.next()) {
				groupName = rsT.getString("group_name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupName;
	}


	public Boolean MemberDel(String memberId) {
		boolean success = false;
		String sql = "DELETE FROM member WHERE member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			if(ps.executeUpdate()>0) {
				success=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}


	public ArrayList<AdminDTO> groupList() {
		ArrayList<AdminDTO>list = new ArrayList<>();
		String sql = "SELECT * FROM group_project";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				AdminDTO dto = new AdminDTO();
				dto.setGroup_idx(rs.getInt("group_idx"));
				dto.setGroup_masterId(rs.getString("member_id"));
				dto.setGroup_name(rs.getString("group_name"));
				dto.setGroup_StrartDay(castingString(rs.getDate("group_startDay")));
				dto.setGroup_EndDay(castingString(rs.getDate("group_endDay")));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}
	
	public Boolean groupDel(int groupIdx) {
		boolean success = false;
		String sql = "DELETE FROM group_project WHERE group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupIdx);
			if(ps.executeUpdate()>0) {
				success=true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}
	
	public String castingString(Date date) {
		String dateString = "20";
		SimpleDateFormat sdfr = new SimpleDateFormat("yy-MM-dd");
		dateString += sdfr.format(date);
		return dateString;
	}
	
	//string -> date
	public Date castingDate(String group_Day) {
		//년
		int year = Integer.parseInt(group_Day.substring(0,4))-1900;
		//월
	    int month = Integer.parseInt(group_Day.substring(5,7))-1;
	    //일
	    int day = Integer.parseInt(group_Day.substring(8,10));
	    
	    java.sql.Date date = new java.sql.Date(year, month, day);
	    
		return date;
	}
}

package semi.teamP.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import semi.teamP.dto.MemberDTO;

public class AdminDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
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
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}


	public ArrayList<MemberDTO> MemberList() {
		ArrayList<MemberDTO>list = new ArrayList<>();
		String sql = "SELECT * FROM member";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setMember_Id(rs.getString("member_id"));
				dto.setMember_name(rs.getString("member_name"));
				dto.setMember_lv(rs.getString("member_lv"));
				int groupNum = getGroupNum(rs.getString("member_id"));
				if(groupNum != 0){
					dto.setMember_groupNum(groupNum);
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
	
	private int getGroupNum(String id) {
		int groupNum = 0;
		String sql = "SELECT group_idx FROM member_group WHERE member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				groupNum = rs.getInt("group_idx");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupNum;
	}
}

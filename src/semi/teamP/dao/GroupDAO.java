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

import oracle.net.aso.i;
import semi.teamP.dto.GroupInfoDTO;
import semi.teamP.dto.GroupInviteDTO;

public class GroupDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public GroupDAO() {
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


	public int createGroup(GroupInfoDTO infoDto) {
		int groupIdx = 0;
		int success = 0;
		String sql = "INSERT INTO Group_project(group_idx,group_name,group_startDay,group_endDay,member_id)"
				+ " VALUES(group_idx_seq.NEXTVAL,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql, new String[] {"group_idx"});
			ps.setString(1, infoDto.getGroup_name());
			ps.setDate(2, castingDate(infoDto.getGroup_StrartDay()));
			ps.setDate(3, castingDate(infoDto.getGroup_EndDay()));
			ps.setString(4, infoDto.getMember_id());
			
			success = ps.executeUpdate();
			
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
				groupIdx = (int) rs.getLong(1);
			}

			if(success>0) {
				sql = "UPDATE member SET member_lv=? WHERE member_id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "master");
				ps.setString(2, infoDto.getMember_id());
				success = ps.executeUpdate();
			}
			
			if(groupIdx>0&&success>0) {
				sql = "INSERT INTO member_group(member_idx,group_idx,member_id) VALUES(SEQ_member_group.NEXTVAL,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setInt(1,groupIdx);
				ps.setString(2, infoDto.getMember_id());
				ps.executeUpdate();
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return groupIdx;
	}

	public GroupInfoDTO getGroupInfo(String memberId, int groupIdx) {
		GroupInfoDTO dto = new GroupInfoDTO();
		String sql = "SELECT * FROM Group_project WHERE member_id=? AND group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			ps.setInt(2, groupIdx);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dto.setGroup_idx(rs.getInt("group_idx"));
				dto.setMember_id(rs.getString("member_id"));
				dto.setGroup_name(rs.getString("group_name"));
				dto.setGroup_StrartDay(castingString(rs.getDate("group_startDay")));
				dto.setGroup_EndDay(castingString(rs.getDate("group_endDay")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return dto;
	}
	
	public ArrayList<String> groupMemberList(String memberId, int groupIdx) {
		ArrayList<String> groupMemberList = new ArrayList<>();
		String sql = "SELECT member_id FROM member_group WHERE member_id!=? AND group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			ps.setInt(2, groupIdx);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				groupMemberList.add(rs.getString("member_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return groupMemberList;
		
	}

	
	public boolean inviteMemberIdChk(String memberId) {
		boolean result = true;
		String sql = "";
		try {
			//회원가입이 되어있는 아이디인지 체크
			sql = "SELECT member_id FROM member WHERE member_id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			rs = ps.executeQuery();
			if(!rs.next()) {
				result = false;
			}else {
				//회원 가입이 되어 있지만 이미 그룹이 있는 회원인지 체크
				sql = "SELECT member_id FROM member_group WHERE member_id = (SELECT member_id FROM member WHERE member_id=?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, memberId);
				rs = ps.executeQuery();
				if(rs.next()) {
					result = false;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	
	public boolean inviteMember(GroupInviteDTO dto) {
		boolean success = false;
		String sql = "INSERT INTO Invite (in_idx, from_member_id, to_member_id, group_idx, in_content) "
				+"VALUES(in_idx_seq.NEXTVAL,?,?,?,?) ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getFrom_memberId());
			ps.setString(2, dto.getTo_memberId());
			ps.setInt(3, dto.getGroup_idx());
			ps.setString(4, dto.getInvite_content());
			
			int successCnt = ps.executeUpdate();
			
			if(successCnt>0){
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}
	
	//date -> string
	private String castingString(Date date) {
		String dateString = "20";
		SimpleDateFormat sdfr = new SimpleDateFormat("yy-MM-dd");
		dateString += sdfr.format(date);
		return dateString;
	}
	
	//string -> date
	private Date castingDate(String group_Day) {
		//년
		int year = Integer.parseInt(group_Day.substring(0,4));
		//월
	    int month = Integer.parseInt(group_Day.substring(5,7));
	    //일
	    int day = Integer.parseInt(group_Day.substring(8,10));
	    java.sql.Date date = new java.sql.Date(year, month, day);

		return date;
	}








}

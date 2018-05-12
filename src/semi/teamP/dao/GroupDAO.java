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
import javax.sql.DataSource;import org.apache.coyote.RequestGroupInfo;

import oracle.net.aso.i;
import semi.teamP.dto.GroupInfoDTO;
import semi.teamP.dto.GroupInviteDTO;
import semi.teamP.dto.GroupMemberDTO;

public class GroupDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	ResultSet rsT = null;
	
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
			if(rsT != null) {
				rsT.close();
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
	
	public ArrayList<GroupMemberDTO> groupMemberList(String memberId, int groupIdx) {
		ArrayList<GroupMemberDTO> groupMemberList = new ArrayList<>();
		String sql = "SELECT member_id FROM member_group WHERE member_id!=? AND group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			ps.setInt(2, groupIdx);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				GroupMemberDTO dto = new GroupMemberDTO();
				dto.setGroup_idx(groupIdx);
				dto.setGroupMember_id(rs.getString("member_id"));
				groupMemberList.add(dto);
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
	
	public ArrayList<GroupInviteDTO> groupInviteList(String memberId) {
		ArrayList<GroupInviteDTO>list = new ArrayList<>();
		GroupInviteDTO dto = null;
		String sql = "SELECT * FROM Invite WHERE to_member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				dto = new GroupInviteDTO();
				dto.setInvite_idx(rs.getInt("in_idx"));
				dto.setGroup_idx(rs.getInt("group_idx"));
				dto.setFrom_memberId(rs.getString("from_member_id"));
				dto.setInvite_content(rs.getString("in_content"));
				dto.setInvite_date(castingString(rs.getDate("invite_date")));
				dto.setGroup_name(groupNameFind(rs.getInt("group_idx")));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}

	//초대 거절
	public boolean refuseInvite(int inviteIdx) {
		int success = 0;
		boolean result = false;
		String sql = "DELETE FROM Invite WHERE in_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, inviteIdx);
			success = ps.executeUpdate();
			
			if(success>0) {
				result=true;
			}else {
				result=false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		
		return result;
	}

	
	//초대 수락
	public boolean acceptInvite(int groupIdx, String memberId) {
		boolean result = false;
		int success = 0;
		String sql = ""; 
		//쿼리 두개 돌려야한다. (프로젝트 멤버 테이블 추가/삭제)
		try {
			sql = "INSERT INTO member_group(member_idx,group_idx,member_id) VALUES(SEQ_member_group.NEXTVAL,?,?)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupIdx);
			ps.setString(2, memberId);
			success = ps.executeUpdate();
			
			if(success>0) {
				sql = "DELETE FROM Invite WHERE group_idx=?";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, groupIdx);
				success = ps.executeUpdate();
				
				if(success>0) {
					result = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;
	}

	
	//멤버 그룹 추방
	public boolean groupMemberOut(String memberId, int groupIdx) {
		boolean success = false;

		String sql = "DELETE FROM member_group WHERE member_id=? AND group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
			ps.setInt(2, groupIdx);
			
			if(ps.executeUpdate()>0) {
				success = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	
	//그룹 정보 수정
	public boolean groupInfoUpdate(GroupInfoDTO dto) {
		boolean success = false;
		String sql = "UPDATE Group_project SET group_name=?, group_startDay=?, group_endDay=? WHERE group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getGroup_name());
			ps.setDate(2, castingDate(dto.getGroup_StrartDay()));
			ps.setDate(3, castingDate(dto.getGroup_EndDay()));
			ps.setInt(4, dto.getGroup_idx());
			
			if(ps.executeUpdate()>0) {
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		
		return success;
	}

	
	public boolean groupDelete(int groupIdx, String groupMasterId) {
		boolean success = false;
		String sql ="";
		
		sql = "DELETE FROM Group_project WHERE group_idx=? AND member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupIdx);
			ps.setString(2, groupMasterId);
			
			if(ps.executeUpdate()>0) {
				sql = "UPDATE member SET member_lv=? WHERE member_id=?";
				ps = conn.prepareStatement(sql);
				ps.setString(1, "member");
				ps.setString(2, groupMasterId);
				if(ps.executeUpdate()>0){
					success = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}


	//인덱스 번호로 그룹 이름 찾기
	private String groupNameFind(int groupIdx) {
		String groupName="";
		String sql = "SELECT group_name FROM Group_project WHERE group_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupIdx);
			rsT = ps.executeQuery();
			
			if(rsT.next()) {
				groupName = rsT.getString("group_name");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupName;
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
		int year = Integer.parseInt(group_Day.substring(0,4))-1900;
		//월
	    int month = Integer.parseInt(group_Day.substring(5,7))-1;
	    //일
	    int day = Integer.parseInt(group_Day.substring(8,10));
	    
	    java.sql.Date date = new java.sql.Date(year, month, day);
	    
		return date;
	}


}

package semi.teamP.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.net.aso.i;
import semi.teamP.dto.GroupInfoDTO;

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

	
	//String으로 들어온 날짜를 date형식으로 ...
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

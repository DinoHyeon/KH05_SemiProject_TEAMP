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

import semi.teamP.dto.PlanReplyDTO;

public class PlanReplyDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	public PlanReplyDAO() {
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
			if (rs != null) {
				rs.close();
			}
			ps.close();
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int planreplyWrite(String loginId, int planidx, String ccontent) {
		int success = 0;
		String sql = "INSERT INTO Plan_comment (pc_num, member_id,pc_content, plan_idx) VALUES(pc_idx_seq.NEXTVAL,?,?,?)";
		try {
			ps = conn.prepareStatement(sql, new String[] {"pc_num"});
			ps.setString(1, loginId);
			ps.setString(2,ccontent);
			ps.setInt(3, planidx);
		
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();

				if (rs.next()) {
				success = (int) rs.getLong(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
			System.out.println("여기서 success"+success);
			System.out.println("dao내용"+ccontent);
			System.out.println("dao인덱스"+planidx);
			return success;
		
		
	}

	public ArrayList<PlanReplyDTO> planreplylist(int planidx) {
		ArrayList<PlanReplyDTO> list = new ArrayList<PlanReplyDTO>();
		String sql="SELECT  pc_num, pc_content, member_id, pc_date, plan_idx FROM Plan_comment Where plan_idx=? ORDER BY pc_num";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, planidx);
			rs = ps.executeQuery();
			while (rs.next()) {
		    	PlanReplyDTO dto = new PlanReplyDTO();
		    	dto.setPc_num(rs.getInt("pc_num"));
		    	dto.setPc_content(rs.getString("pc_content"));
		    	dto.setMember_id(rs.getString("member_id"));
//				dto.setComment_date(castingString(rs.getDate("comment_date")));
		    dto.setPc_date(castingString(rs.getDate("pc_date")));
		    //	dto.setPc_date(rs.getString("pc_date"));
		    	dto.setPlan_idx(rs.getInt("plan_idx"));
		    	list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return list;
	}

	public int planreplyDelete(String delcomment, String loginId) {
		int success =0;
		String sql ="DELETE FROM Plan_comment Where pc_num=? AND member_id=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(delcomment));
			ps.setString(2, loginId);
			success = ps.executeUpdate();
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			resClose();

		}
		System.out.println("삭제 성공여부" + success);
		return success;
	}

	public int planupdatecomment(String content, String upcomment, String loginId) {
		int success =0;
		String sql ="UPDATE Plan_Comment SET pc_content=? WHERE pc_num=? AND member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, content);
		   
			ps.setInt(2, Integer.parseInt(upcomment));
			ps.setString(3, loginId);

			success = ps.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();
			return 0;
		} finally {
			try {
				ps.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.out.println("코멘트 수정 성공여부:" + success);
		return success;

	}
	
	
	//date -> string
	public String castingString(Date date) {
		String dateString = "";
		SimpleDateFormat sdfr = new SimpleDateFormat("[HH:mm]");
		
		dateString = sdfr.format(date);
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
	



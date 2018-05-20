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
import semi.teamP.dto.ReplyDTO;

public class ReplyDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public ReplyDAO() {
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

	public ArrayList<ReplyDTO> replylist(int bbsidx) {
		ArrayList<ReplyDTO> list = new ArrayList<ReplyDTO>();
		String sql = "SELECT comment_date, comment_idx, member_id, comment_content, bbs_idx FROM Bbs_comment WHERE  bbs_idx=?  ORDER BY comment_idx";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, bbsidx);
			rs = ps.executeQuery();
			while (rs.next()) {
		    	ReplyDTO dto = new ReplyDTO();
	    	
				dto.setComment_date(castingString(rs.getDate("comment_date")));
				dto.setComment_idx(rs.getInt("comment_idx"));
				dto.setMember_id(rs.getString("member_id"));
				dto.setComment_content(rs.getString("comment_content"));
				dto.setBbs_idx(rs.getInt("bbs_idx"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}

		return list;

	}

	public int replyWrite(String loginId, String ccontent, int bbsidx) {
		int success = 0;
		 replycnt(bbsidx);
		String sql = "INSERT INTO Bbs_comment(comment_idx, member_id, comment_content, bbs_idx)"
				+ "VALUES(comment_idx_seq.NEXTVAL,?,?,?)";
		
		try {
			ps = conn.prepareStatement(sql, new String[] { "comment_idx" });
		   
			ps.setString(1, loginId);
			ps.setString(2, ccontent);
			ps.setInt(3, bbsidx);
		
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();

			if (rs.next()) {
				success = (int) rs.getLong(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();

		}
		
			
		return success;

	}

	public int replyDelete(String delcomment, String loginId) {
		int success = 0;
		String sql = "DELETE FROM Bbs_comment where comment_idx=? AND member_id=?";

		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(delcomment));
			ps.setString(2, loginId);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();

		} finally {
			resClose();

		}
		System.out.println("삭제 성공여부" + success);
		return success;

	}

	private void replycnt(int idx) {  //게시글 조회수 
		String sql = "update bbs set reply_cnt=reply_cnt+1 where bbs_idx=?";
		try {
		ps= conn.prepareStatement(sql);
		ps.setInt(1, idx);
		ps.executeUpdate();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
}




	public int updatecomment(String content, String upcomment, String loginId) {
		int success = 0;
		String sql = "UPDATE Bbs_comment SET comment_content=? WHERE comment_idx=? AND member_id=?";
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
	private String castingString(Date date) {
		String dateString = "";
		SimpleDateFormat sdfr = new SimpleDateFormat("[HH:mm] [yyyy-MM-dd]");
		
		dateString = sdfr.format(date);
	
		return dateString;
	}
	

}


package semi.teamP.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import semi.teamP.dto.BoardDTO;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public BoardDAO() {
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

	//리스트 불러오기
	public ArrayList<BoardDTO> list() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "SELECT * FROM Bbs WHERE bbs_name='freeBbs' ORDER BY bbs_idx DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setBbs_idx(rs.getInt("bbs_idx"));
				dto.setBbs_name(rs.getString("bbs_name"));
				dto.setBbs_subject(rs.getString("bbs_subject"));
				dto.setBbs_date(rs.getDate("bbs_date"));
				dto.setBbs_bHit(rs.getInt("bbs_bHit"));
				dto.setMember_id(rs.getString("member_id"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}

	//글쓰기
	public int write(BoardDTO dto) {
		long idx = 0;
		String sql = "INSERT INTO Bbs(bbs_idx, bbs_name, bbs_subject, bbs_content, member_id) "
				+ "VALUES(BBS_IDX_SEQ.NEXTVAL,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql, new String[] {"bbs_idx"});
			ps.setString(1, dto.getBbs_name());
			ps.setString(2, dto.getBbs_subject());
			ps.setString(3, dto.getBbs_content());
			ps.setString(4, dto.getMember_id());
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
				idx = rs.getLong(1);
				dto.setBbs_idx((int) idx);
			}
			System.out.println(dto.getBbs_idx());
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
			
		}
		return (int) idx;
	}


	//상세보기 및 수정폼
	   public BoardDTO detail(String idx) {
	      BoardDTO dto = null;
	      String sql = "SELECT * FROM Bbs WHERE bbs_idx=?";
	      try {
	         ps = conn.prepareStatement(sql);
	         ps.setString(1, idx);
	         rs = ps.executeQuery();         
	         if(rs.next()) {
	            upHit(idx);
	            dto = new BoardDTO();
	            dto.setBbs_idx(rs.getInt("bbs_idx"));
	            dto.setMember_id(rs.getString("member_id"));
	            dto.setBbs_content(rs.getString("bbs_content"));
	            dto.setBbs_subject(rs.getString("bbs_subject"));
	            dto.setBbs_date(rs.getDate("bbs_date"));
	            dto.setBbs_bHit(rs.getInt("bbs_bHit"));            
	         }               
	      } catch (SQLException e) {         
	         e.printStackTrace();
	      }finally {
	         resClose();
	      }
	      return dto;
	   }

	//수정
	public int update(BoardDTO dto) {
		int success = 0 ;
		String sql = "UPDATE Bbs SET bbs_subject = ?, bbs_content = ? WHERE bbs_idx = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getBbs_subject());
			ps.setString(2, dto.getBbs_content());
			ps.setInt(3, dto.getBbs_idx());
			success = ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}
	
	//조회수 올리기
	private void upHit(String idx) {
		String sql = "UPDATE Bbs SET bbs_bHit = bbs_bHit+1 WHERE bbs_idx = ?";
		try {
			ps= conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(idx));
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	//삭제
	public int del(String idx) {
		 int success = 0;
	      String sql = "DELETE FROM Bbs WHERE bbs_idx=?";
	      try {
	         ps = conn.prepareStatement(sql);
	         ps.setInt(1, Integer.parseInt(idx));
	         success = ps.executeUpdate();         
	      } catch (SQLException e) {      
	         e.printStackTrace();         
	      }finally {
	         resClose();
	      }
	      return success;		
	}

	//관리자게시판 리스트
	public ArrayList<BoardDTO> adminList() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		String sql = "SELECT * FROM Bbs WHERE member_id = 'admin' ORDER BY bbs_idx DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setBbs_idx(rs.getInt("bbs_idx"));
				dto.setBbs_name(rs.getString("bbs_name"));
				dto.setBbs_subject(rs.getString("bbs_subject"));
				dto.setBbs_date(rs.getDate("bbs_date"));
				dto.setBbs_bHit(rs.getInt("bbs_bHit"));
				dto.setMember_id(rs.getString("member_id"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}
	

}

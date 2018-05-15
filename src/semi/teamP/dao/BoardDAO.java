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
	
	//DB접속 생성자
	public BoardDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//자원반납
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

	//글쓰기(그룹이 있는사람)
	public int groupWrite(BoardDTO dto) {
		long idx = 0;
		String sql = "INSERT INTO Bbs(bbs_idx, bbs_name, bbs_subject, bbs_content, group_idx, member_id) "
				+ "VALUES(BBS_IDX_SEQ.NEXTVAL,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql, new String[] {"bbs_idx"}); 			
			ps.setString(1, dto.getBbs_name());
			ps.setString(2, dto.getBbs_subject());
			ps.setString(3, dto.getBbs_content());
			//그룹이 있는 회원은 group_idx 가 있기때문에 값셋팅이 필요하다
			ps.setInt(4,dto.getGroup_idx());
			ps.setString(5, dto.getMember_id());		
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();				
			if(rs.next()) {
				//글작성 후 detail폼으로 넘기기위한 idx 추출
				idx = rs.getLong(1);
				dto.setBbs_idx((int) idx);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return (int) idx;
	}
	
	//글쓰기(그룹이 없는사람)
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
			//그룹이 없는 회원은 group_idx 가 기본으로 null 이 들어가기 때문에 값셋팅이 필요없다
			ps.executeUpdate();
			rs = ps.getGeneratedKeys();
			if(rs.next()) {
				//글작성 후 detail폼으로 넘기기위한 idx 추출
				idx = rs.getLong(1);
				dto.setBbs_idx((int) idx);
			}
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
	            dto.setBbs_name(rs.getString("bbs_name"));
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

	
	//리스트 불러오기
		public ArrayList<BoardDTO> list() {
			ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
			//bbs_name 이 freeBbs 인 것만 select 해서 뿌림
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
	
	//관리자게시판 리스트 불러오기
	public ArrayList<BoardDTO> adminList() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		//bbs_name 이 adminBbs 인 것만 select 해서 뿌림
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
	
	//그룹 리스트 불러오기(그룹장 및 그룹원)
	public ArrayList<BoardDTO> groupList(int group_idx) {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		//bbs_name 이 groupBbs 인 것만 select 해서 뿌리고 group_idx = ? 세팅
		String sql = "SELECT * FROM Bbs WHERE bbs_name = 'groupBbs' AND group_idx = ? ORDER BY bbs_idx DESC";
		try {
			ps = conn.prepareStatement(sql);
			//가져온 그룹번호 세션값  group_idx 값 셋팅 -> 자신이 해당되어있는 그룹의 게시글만 볼수 있도록 하기위함
			ps.setInt(1, group_idx);
			ps.executeUpdate();
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
	
	//그룹 리스트 불러오기(관리자)
	public ArrayList<BoardDTO> adminGroupBbsList() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		//bbs_name 이 groupBbs 인 게시글 전부 불러오기 (관리자모드를 위함)
		String sql = "SELECT * FROM Bbs WHERE bbs_name = 'groupBbs' ORDER BY bbs_idx DESC";
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

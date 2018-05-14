package semi.teamP.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import semi.teamP.dto.TodoDTO;

public class TodoDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public TodoDAO() {
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


	public int write(TodoDTO dto) {
		int success=0;
		
		String sql = "INSERT INTO Todo(todo_idx,todo_content,member_id)"
				+"VALUES(todo_idx_seq.NEXTVAL,?,?)";
			try {
				ps=conn.prepareStatement(sql);
				ps.setString(1, dto.getTodo_content());
				ps.setString(2, dto.getMember_id());
				success=ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				resClose();
			}
		
		return success;
	}


	public ArrayList<TodoDTO> list(String loginId) {
		ArrayList<TodoDTO> list = new ArrayList<TodoDTO>(); //list변수만들어주고
		String sql="SELECT todo_idx,todo_content,member_id FROM Todo WHERE member_id=? ORDER BY todo_idx DESC";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, loginId);
			rs=ps.executeQuery();
			while(rs.next()){ 
				TodoDTO dto = new TodoDTO();	
				dto.setTo_do_idx(rs.getInt("todo_idx"));
				dto.setTodo_content(rs.getString("todo_content"));
				dto.setMember_id(rs.getString("member_id"));
				list.add(dto);//dto 를 list 에 담기
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}


	public int delete(String delcontent) {
		String sql="DELETE FROM Todo WHERE todo_idx=?";
		int delCnt=0;
		try {
				ps=conn.prepareStatement(sql);
				ps.setInt(1,Integer.parseInt(delcontent));
				delCnt=ps.executeUpdate();
				ps.close();	
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}

		return delCnt;
	}
}
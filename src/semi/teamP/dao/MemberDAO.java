package semi.teamP.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import semi.teamP.dto.MemberDTO;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public MemberDAO() {
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

	public MemberDTO login(String id, String pw) {
		MemberDTO dto = new MemberDTO();
		int groupNum = 0;
		String sql = "SELECT mem_id, mem_lv,mem_name FROM member WHERE mem_id=? AND mem_pw=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto.setMember_Id(id);
				dto.setMember_lv(rs.getString("mem_lv"));
				dto.setMember_name(rs.getString("mem_name"));
				groupNum = getGroupNum(id);
				if(groupNum != 0){
					dto.setMember_groupNum(groupNum);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return dto;
	}

	private int getGroupNum(String id) {
		int groupNum = 0;
		String sql = "SELECT gp_num FROM Member_group WHERE mem_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.executeQuery();
			if(rs.next()) {
				groupNum = rs.getInt("gp_num");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupNum;
	}

	public Boolean idOverlay(String id) {
		Boolean result = false;
		String sql = "SELECT mem_id FROM member WHERE mem_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;
	}

	public int join(MemberDTO dto) {
		int success = 0;
		String sql = "INSERT INTO Member (mem_id,mem_pw,mem_name,mem_birth,mem_email,mem_phone) VALUES(?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMember_Id());
			ps.setString(2, dto.getMember_Pw());
			ps.setString(3, dto.getMember_name());
			ps.setString(4, dto.getMember_birth());
			ps.setString(5, dto.getMember_email());
			ps.setString(6, dto.getMember_phone());
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	public String findId(String name, String birth, String email) {
		String findId = "";
		String sql = "SELECT mem_id FROM member WHERE mem_name=? AND mem_birth=? AND mem_email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, birth);
			ps.setString(3, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				findId = rs.getString("mem_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return findId;
	}

	public int changePw(String id, String pw) {
		int success = 0;
		String sql = "UPDATE member SET mem_pw=? WHERE mem_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, pw);
			ps.setString(2, id);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	public String findPw(MemberDTO dto) {
		String result = "";
		String sql = "SELECT mem_id FROM member WHERE mem_id=? AND mem_name=? AND mem_birth=? AND mem_email=? AND mem_phone=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMember_Id());
			ps.setString(2, dto.getMember_name());
			ps.setString(3, dto.getMember_birth());
			ps.setString(4, dto.getMember_email());
			ps.setString(5, dto.getMember_phone());
			
			rs = ps.executeQuery();
			if(rs.next()) {
				result = rs.getString("mem_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;
	}

	public Boolean emailOverlay(String email) {
		Boolean result = false;
		String sql = "SELECT mem_email FROM member WHERE mem_email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				result = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return result;
	}
}

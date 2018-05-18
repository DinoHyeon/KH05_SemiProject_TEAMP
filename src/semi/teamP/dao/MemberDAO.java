package semi.teamP.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import oracle.net.aso.a;
import oracle.net.aso.s;
import semi.teamP.dto.MemberDTO;

/*CREATE TABLE member(
		   member_id NVARCHAR2(50) PRIMARY KEY,
		   member_pw NVARCHAR2(100) NOT NULL,
		   member_name NVARCHAR2(50) NOT NULL,
		   member_birth NVARCHAR2(50) NOT NULL,
		   member_email NVARCHAR2(100) NOT NULL,
		   member_phone NVARCHAR2(50) NOT NULL,
		   member_lv NVARCHAR2(50) default 'member'
		);*/

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
		String sql = "SELECT member_id, member_lv, member_name FROM member WHERE member_id=? AND member_pw=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto.setMember_Id(id);
				dto.setMember_lv(rs.getString("member_lv"));
				dto.setMember_name(rs.getString("member_name"));
				groupNum = getGroupNum(id);
				if(groupNum != 0){
					dto.setMember_groupNum(groupNum);
				}else {
					dto.setMember_groupNum(0);
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
		String sql = "SELECT group_idx FROM member_group WHERE member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs=ps.executeQuery();
			if(rs.next()) {
				System.out.println("그룹번호 있음");
				groupNum = rs.getInt("group_idx");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return groupNum;
	}

	public Boolean idOverlay(String id) {
		Boolean result = false;
		String sql = "SELECT member_id FROM member WHERE member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			if(!rs.next()) {
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
		String sql = "INSERT INTO Member (member_id,member_pw,member_name,member_birth,member_email,member_phone) VALUES(?,?,?,?,?,?)";
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
		String sql = "SELECT member_id FROM member WHERE member_name=? AND member_birth=? AND member_email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, birth);
			ps.setString(3, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				findId = rs.getString("member_id");
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
		String sql = "UPDATE member SET member_pw=? WHERE member_id=?";
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
		String sql = "SELECT member_id FROM member WHERE member_id=? AND member_name=? AND member_birth=? AND member_email=? AND member_phone=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getMember_Id());
			ps.setString(2, dto.getMember_name());
			ps.setString(3, dto.getMember_birth());
			ps.setString(4, dto.getMember_email());
			ps.setString(5, dto.getMember_phone());
			
			rs = ps.executeQuery();
			if(rs.next()) {
				result = rs.getString("member_id");
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
		String sql = "SELECT member_email FROM member WHERE member_email=?";
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

	public MemberDTO infoUpdateForm(String id) {
		MemberDTO dto = new MemberDTO();
		String sql = "SELECT * FROM member WHERE member_id=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dto.setMember_Id(rs.getString("member_id"));
				dto.setMember_name(rs.getString("member_name"));
				dto.setMember_birth(rs.getString("member_birth"));
				dto.setMember_email(rs.getString("member_email"));
				dto.setMember_phone(rs.getString("member_phone"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return dto;
	}

	public boolean memberPasswordCheck(String id, String pw) {
		boolean success = false;
		String sql = "SELECT * FROM member WHERE member_id=? AND member_pw=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				success = true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}

	public int infoUpdate(String id, String pw, String email, String phone) {
		int success = 0;
		String sql ="";
		if(pw.equals("")) {
			System.out.println("비밀번호 수정X");
			sql="UPDATE member SET member_email=?, member_phone=? WHERE member_id=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, email);
				ps.setString(2, phone);
				ps.setString(3, id);
				success = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}else {
			System.out.println("비밀번호 수정O");
			sql="UPDATE member SET member_email=?, member_phone=?, member_pw=? WHERE member_id=?";
			try {
				ps = conn.prepareStatement(sql);
				ps.setString(1, email);
				ps.setString(2, phone);
				ps.setString(3, pw);
				ps.setString(4, id);
				success = ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
		}
		resClose();
		return success;
	}
	

	public boolean withdrawal(String memberId) {
		boolean success = false;
		String sql = "DELETE FROM member WHERE member_id = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, memberId);
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

}

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
import semi.teamP.dto.PlanDTO;
import semi.teamP.dto.TodoDTO;

public class PlanDAO {
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	public PlanDAO() {
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




	public int write(PlanDTO dto,int groupIdx) {
		int success = 0;
		
		String sql = "INSERT INTO plan (plan_idx,plan_startDay,plan_content,plan_endDay,member_id,plan_title,group_idx) "
				+ "VALUES(plan_idx_seq.NEXTVAL,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getPlan_startDay());
			ps.setString(2, dto.getPlan_content());
			ps.setString(3, dto.getPlan_endDay());
			ps.setString(4, dto.getMember_id());
			ps.setString(5, dto.getPlan_title());
			ps.setInt(6, groupIdx);
			
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return success;
	}



	public ArrayList<PlanDTO> list() {
		ArrayList<PlanDTO> list = new ArrayList<PlanDTO>();
		String sql="SELECT * FROM bbs_pho ORDER BY idx DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				PlanDTO dto = new PlanDTO();
				dto.setPlan_idx(rs.getInt("plan_idx"));
				dto.setMember_id(rs.getString("member_id"));
				dto.setPlan_content(rs.getString("plan_content"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
		
	}



	public ArrayList<PlanDTO> list(String date,int groupIdx) {
		ArrayList<PlanDTO> list = new ArrayList<PlanDTO>(); //list변수만들어주고
		String sql="SELECT * FROM Plan WHERE plan_startDay<=? AND plan_endDay>=? AND group_idx =? ORDER BY plan_idx DESC";
		try {
			ps=conn.prepareStatement(sql);
			ps.setString(1, date);
			ps.setString(2, date);
			ps.setInt(3, groupIdx);
			rs=ps.executeQuery();
			while(rs.next()){ 
				PlanDTO dto = new PlanDTO();	
				dto.setMember_id(rs.getString("member_id"));
				dto.setPlan_title(rs.getString("plan_title"));
				dto.setPlan_state(rs.getString("plan_state"));
				list.add(dto);//dto 를 list 에 담기
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}
}


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

import semi.teamP.dto.BoardDTO;
import semi.teamP.dto.MemberDTO;
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


	 public int planWrite(PlanDTO plandto) {
	      int success = 0;
	      String sql = "INSERT INTO Plan(plan_idx, member_id,plan_startDay,plan_endDay,plan_content,plan_title,group_idx)"
	            + " VALUES(plan_idx_seq.NEXTVAL,?,?,?,?,?,?)";
	      //
	      try {
	         ps = conn.prepareStatement(sql, new String[] {"plan_idx"});
	         ps.setString(1, plandto.getMember_id());
	         //   ps.setString(1, infoDto.getGroup_name());
	         ps.setDate(2, castingDate(plandto.getPlan_startDay()));
	         ps.setDate(3, castingDate(plandto.getPlan_endDay()));
	         ps.setString(4,plandto.getPlan_content());
	         ps.setString(5,plandto.getPlan_title());
	         ps.setInt(6, plandto.getGroup_idx());
	         success = ps.executeUpdate();
	         
	      }catch (SQLException e) {
	         e.printStackTrace();
	      }finally {
	         resClose();
	      }
	      return success;
	      
	   
	   }



	public ArrayList<PlanDTO> list(int groupIdx) {
		GroupDAO Gdao = new GroupDAO();
		ArrayList<PlanDTO> list = new ArrayList<PlanDTO>();
		String sql="SELECT * FROM plan WHERE group_idx=? ORDER BY plan_startDay DESC";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, groupIdx);
			rs = ps.executeQuery();
			while(rs.next()) {
				PlanDTO dto = new PlanDTO();
				dto.setPlan_idx(rs.getInt("plan_idx"));
				dto.setMember_id(rs.getString("member_id"));
				dto.setPlan_state(rs.getString("plan_state"));
				dto.setPlan_startDay(Gdao.castingString(rs.getDate("plan_startDay")));
				dto.setPlan_endDay(Gdao.castingString(rs.getDate("plan_endDay")));
				dto.setPlan_title(rs.getString("plan_title"));
				dto.setPlan_content(rs.getString("plan_content"));
				dto.setPlan_plan_finishDate(Gdao.castingString(rs.getDate("plan_finishDate")));
				
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
				dto.setPlan_idx(rs.getInt("plan_idx"));
				list.add(dto);//dto 를 list 에 담기
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return list;
	}



	public PlanDTO plandetail(String detail) {
		GroupDAO Gdao = new GroupDAO();
		PlanDTO dto = new PlanDTO();
		String sql = "SELECT * FROM Plan WHERE plan_idx=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, detail);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dto.setPlan_idx(rs.getInt("plan_idx"));
				dto.setPlan_content(rs.getString("plan_content"));
				dto.setPlan_startDay(Gdao.castingString(rs.getDate("plan_startDay")));
				dto.setPlan_endDay(Gdao.castingString(rs.getDate("plan_endDay")));
				dto.setPlan_title(rs.getString("plan_title"));
				dto.setPlan_state(rs.getString("plan_state"));
				dto.setGroup_idx(rs.getInt("group_idx"));
				dto.setMember_id(rs.getString("member_id"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			resClose();
		}
		return dto;
	}

//date -> string
	public String castingString(Date date) {
		String dateString = "20";
		SimpleDateFormat sdfr = new SimpleDateFormat("yy-MM-dd");
		dateString += sdfr.format(date);
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



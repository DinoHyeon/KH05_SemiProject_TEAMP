package semi.teamP.service;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.PlanDAO;
import semi.teamP.dto.PlanDTO;

public class PlanService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public PlanService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void planWrite() throws IOException {
		request.setCharacterEncoding("UTF-8");
		//글쓰기 서비스
		//1.파라메터 추출
		request.setCharacterEncoding("UTF-8");
		String userName =request.getParameter("member_id");
		String sDate=request.getParameter("syear")+request.getParameter("smonth")
		+request.getParameter("sday");
		String eDate =request.getParameter("eyear")+request.getParameter("emonth")
		+request.getParameter("eday");
		String memo = request.getParameter("memo");
		PlanDTO dto = new PlanDTO();
		dto.setMember_id(userName);
		dto.setPlan_startDay(sDate);
		dto.setPlan_endDay(eDate);
		dto.setPlan_content(memo);
		
		
		//2.DAO 요청
		PlanDAO dao = new PlanDAO();
		int success = dao.write(dto);
		//3.결과값 json변환
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
		
		
	}

	public void planWokerPick() {
		// TODO Auto-generated method stub
		
	}

	public void planChange() {
		// TODO Auto-generated method stub
		
	}

	public void planDetail() {
		// TODO Auto-generated method stub
		
	}

	public void planDelete() {
		// TODO Auto-generated method stub
		
	}
}

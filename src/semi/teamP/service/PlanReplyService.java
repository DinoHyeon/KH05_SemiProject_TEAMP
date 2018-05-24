package semi.teamP.service;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.PlanReplyDAO;
import semi.teamP.dao.ReplyDAO;
import semi.teamP.dto.PlanReplyDTO;



public class PlanReplyService{
	
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public PlanReplyService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void planreplyWrite() throws IOException {
		String loginId = (String) request.getSession().getAttribute("loginId"); //로그인 아이디
		String ccontent = request.getParameter("ccontent"); //플랜 코멘트 내용
		int planidx = Integer.parseInt(request.getParameter("planidx")); //플랜 idx 
	 
		PlanReplyDAO dao= new PlanReplyDAO();
    	int idx = dao.planreplyWrite(loginId,planidx,ccontent);
		
    	

		ArrayList<PlanReplyDTO> list =dao.planreplylist(planidx);
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
			
		//세션에서 idx를 String 으로 불러 내기 때문에 넣을때 문자열로 형변환 해야 한다.
		System.out.println("반환값"+idx);
	    request.getSession().setAttribute("idx",Integer.toString(idx));
	    map.put("success", idx);
		//map.put("list",list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
	}

	public void planreplyUpdate() throws IOException {
	      String content = request.getParameter("content"); //댓글 내용
			String upcomment = request.getParameter("upcomment"); //planidx 
			String loginId = (String) request.getSession().getAttribute("loginId"); //로그인 아이디
			//String time=request.getParameter("time");
			PlanReplyDAO dao = new PlanReplyDAO();
		     int success = dao.planupdatecomment(content,upcomment,loginId);
		     
		     HashMap<String, Object> map = new HashMap<String, Object>();
		     map.put("success", success);
		     
		     Gson json = new Gson();
		     String obj = json.toJson(map);
		     response.getWriter().println(obj);
		
	}

	public void planreplyDelete() throws IOException {
		int success=0;

		String  delcomment = request.getParameter("delcomment");
		String loginId = (String) request.getSession().getAttribute("loginId"); //로그인 아이디
//${sessionScope.groupNum}
		PlanReplyDAO dao = new PlanReplyDAO();


		success = dao.planreplyDelete(delcomment,loginId);
		 HashMap<String, Object> map= new HashMap<String, Object>();
	     map.put("success", success);
	             
	        Gson json = new Gson();
	        String obj = json.toJson(map);
	        //response.setContentType("text/html; charset=UTF-8");
	        response.getWriter().println(obj);
		
	}

	public void planreplyCheck() throws IOException {
		int planidx = Integer.parseInt(request.getParameter("planidx")); //플랜 idx 
		System.out.println("planidx값은?:"+planidx);
		PlanReplyDAO dao= new PlanReplyDAO();
		ArrayList<PlanReplyDTO> list =dao.planreplylist(planidx);
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list",list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
		
	}

	public String castingString(Date date) {
		String dateString = "20";
		SimpleDateFormat sdfr = new SimpleDateFormat("yy-MM-dd");
		dateString += sdfr.format(date);
		return dateString;
	}

}

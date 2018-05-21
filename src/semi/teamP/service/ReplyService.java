package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.ReplyDAO;
import semi.teamP.dto.ReplyDTO;

public class ReplyService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public ReplyService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

public void replyWrite() throws IOException {
	String loginId = (String) request.getSession().getAttribute("loginId"); //로그인 아이디
	String ccontent = request.getParameter("ccontent"); //내용
	
	System.out.println(loginId +":"+ ccontent);

	int bbsidx = Integer.parseInt(request.getParameter("cid")); // 게시글 번호 
	ReplyDAO dao= new ReplyDAO();
	int idx = dao.replyWrite(loginId, ccontent, bbsidx);
	System.out.println("댓글 작성 성공여부"+idx);
	
	ArrayList<ReplyDTO> list =dao.replylist(bbsidx);
	Gson json = new Gson();
	HashMap<String, Object> map = new HashMap<>();
	
	request.getSession().setAttribute("idx",Integer.toString(idx));
	map.put("success", idx);
	map.put("list",list);
	String obj = json.toJson(map);
	response.setContentType("text/html; charset=UTF-8");
	response.getWriter().println(obj);

	}

		
	public void replyCheck() throws IOException {
		System.out.println("댓글 불러오기");
		int bbsidx = Integer.parseInt(request.getParameter("cid")); // 게시글 번호 
		ReplyDAO dao= new ReplyDAO();
		ArrayList<ReplyDTO> list =dao.replylist(bbsidx);
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list",list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void replyUpdateForm() {
	
		
	}

	public void replyDelete() throws IOException {
		int success=0;

		String  delcomment = request.getParameter("delcomment");
		String loginId = (String) request.getSession().getAttribute("loginId"); //로그인 아이디
		ReplyDAO dao = new ReplyDAO();


		success = dao.replyDelete(delcomment,loginId);
		 HashMap<String, Object> map= new HashMap<String, Object>();
	     map.put("success", success);
	             
	        Gson json = new Gson();
	        String obj = json.toJson(map);
	        response.getWriter().println(obj);
		
	}

	public void replyUpdate() throws IOException {
		String content = request.getParameter("content");
		String upcomment = request.getParameter("upcomment");
		String loginId = (String) request.getSession().getAttribute("loginId"); 

	     ReplyDAO dao = new ReplyDAO();
	     int success = dao.updatecomment(content,upcomment,loginId);
	     
	     HashMap<String, Object> map = new HashMap<String, Object>();
	     map.put("success", success);
	     
	     Gson json = new Gson();
	     String obj = json.toJson(map);
	     response.getWriter().println(obj);


		
	}
		
	

	
}

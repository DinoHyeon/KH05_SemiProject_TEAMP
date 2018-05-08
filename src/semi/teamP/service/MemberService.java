package semi.teamP.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.MemberDAO;
import semi.teamP.dto.MemberDTO;

public class MemberService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;

	public MemberService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void join() throws IOException {
		request.setCharacterEncoding("UTF-8");
		String birth=request.getParameter("birth_year")+request.getParameter("birth_month")+request.getParameter("birth_day");
		MemberDTO dto = new MemberDTO();
		dto.setMember_Id(request.getParameter("id"));
		dto.setMember_Pw(request.getParameter("pw"));
		dto.setMember_name(request.getParameter("name"));
		dto.setMember_birth(birth);
		dto.setMember_phone(request.getParameter("phone"));
		dto.setMember_email(request.getParameter("email"));
		
		MemberDAO dao = new MemberDAO();
		int success = dao.join(dto);
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void findId() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("idUserName");
		String birth = request.getParameter("idYear")+request.getParameter("idMonth")+request.getParameter("idDay");
		String email = request.getParameter("idEmail");
		
		System.out.println(name+"/"+birth+"/"+email);
		
		String findId="";
		String msg = "일치하는 정보가 없습니다.";
		String page = "findInfo.jsp";
		
		MemberDAO dao = new MemberDAO();
		findId = dao.findId(name,birth,email);
		
		if(!findId.equals("")) {
			msg = findId;
			page = "findIdResult.jsp";
		}
		
		request.setAttribute("msg", msg);
		RequestDispatcher dis = request.getRequestDispatcher(page);
		dis.forward(request, response);
	}

	public void ChangePw() throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("userId");
		String pw = request.getParameter("changePw");
		
		MemberDAO dao = new MemberDAO();
		int success = dao.changePw(id, pw);
		
		if(success>0) {
			request.setAttribute("msg", "정상적으로 변경되었습니다.");
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
			dis.forward(request, response);
		}
	}

	public void infoUpdate() {
		// TODO Auto-generated method stub
		
	}

	public void logout() {
		request.getSession().removeAttribute("loginId");
		request.getSession().removeAttribute("memberLv");
		request.getSession().removeAttribute("groupNum");
	}

	public void withdrawal() {
		// TODO Auto-generated method stub
		
	}

	public void login() throws IOException{
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.login(id, pw);
		
		String loginId = dto.getMember_Id();
		String memberLv = dto.getMember_lv();
		String memberName = dto.getMember_name();
		int groupNum = dto.getMember_groupNum();
		
		boolean success = false;
		
		if(loginId!=null&&memberLv!=null&&memberName!=null) {
			success = true;
			request.getSession().setAttribute("loginId", id);
			request.getSession().setAttribute("memberLv", memberLv);
			request.getSession().setAttribute("memberName", memberName);
			if(groupNum!= 0) {
				request.getSession().setAttribute("groupNum", groupNum);
			}
		}
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("login", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void findPw() throws ServletException, IOException {
		MemberDTO dto = new MemberDTO();
		
		request.setCharacterEncoding("UTF-8");
		
		String birth = request.getParameter("pwYear")+request.getParameter("pwMonth")+request.getParameter("pwDay");
		dto.setMember_Id(request.getParameter("pwUserId"));
		dto.setMember_name(request.getParameter("pwUserName"));
		dto.setMember_birth(birth);
		dto.setMember_phone(request.getParameter("pwPhone"));
		dto.setMember_email(request.getParameter("pwEmail"));
		
		MemberDAO dao = new MemberDAO();
		String result = dao.findPw(dto);
		String msg = "일치하는 정보가 없습니다.";
		String page = "findInfo.jsp";
			
		if(!result.equals("")) {
			msg = result;
			page = "changPw.jsp";
		}
		
		request.setAttribute("msg", msg);
		RequestDispatcher dis = request.getRequestDispatcher(page);
		dis.forward(request, response);
	}

	public void idOverlay() throws IOException {
		String id = request.getParameter("id");
		System.out.println("중복확인 요청 아이디 : "+id);
		
		MemberDAO dao = new MemberDAO();
		Boolean idChk = dao.idOverlay(id);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("idChk", idChk);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void emailOverlay() throws IOException {
		String email = request.getParameter("email");
		System.out.println("중복확인 요청 이메일 : "+email);
		
		MemberDAO dao = new MemberDAO();
		Boolean emailChk = dao.emailOverlay(email);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("emailChk", emailChk);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void infoUpdateForm() {
		// TODO Auto-generated method stub
		
	}
	
	
	
}

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
		
		System.out.println(success);
		
		if(success>0) {
			request.setAttribute("msg", "비밀번호 변경이 완료되었습니다.");
			RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
			dis.forward(request, response);
		}
	}

	public void infoUpdate() throws IOException {
		String id = (String) request.getSession().getAttribute("loginId");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String pw = request.getParameter("pw");//pw변경x의 값 ""
		
		MemberDAO dao = new MemberDAO();
		int success = dao.infoUpdate(id,pw,email,phone);
		
		if(success>0) {
			Gson json = new Gson();
			HashMap<String, Integer> map = new HashMap<>();
			map.put("success", success);
			String obj = json.toJson(map);
			response.getWriter().println(obj);
		}
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
		
		String page = "";
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
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
		String msg = "로그인에 실패했습니다.";
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
		
		MemberDAO dao = new MemberDAO();
		Boolean emailChk = dao.emailOverlay(email);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("emailChk", emailChk);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void infoUpdateForm() throws IOException, ServletException {
		String id = (String) request.getSession().getAttribute("loginId");
		System.out.println("현재 접속한 회원의 아이디  : "+id);
		
		MemberDAO dao = new MemberDAO();
		//아이디 이름 생일 이메일 휴대폰번호
		MemberDTO dto = dao.infoUpdateForm(id);
		
		request.setAttribute("dto", dto);
		RequestDispatcher dis = request.getRequestDispatcher("memberInfoForm.jsp");
		dis.forward(request, response);
	}

	public void memberDataAccess() throws IOException, ServletException {
		String id = (String) request.getSession().getAttribute("loginId");
		String pw = request.getParameter("memberPass");
		
		System.out.println(id+" / "+pw);
		
		MemberDAO dao = new MemberDAO();
		boolean success = dao.memberDataAccess(id,pw);
		
		if(success) {
			response.sendRedirect("./infoUpdateForm");
		}else {
			request.setAttribute("msg", "비밀번호가 일치하지 않습니다.");
			RequestDispatcher dis = request.getRequestDispatcher("memberInfoAccess.jsp");
			dis.forward(request, response);
		}
		
	}


	
	
}

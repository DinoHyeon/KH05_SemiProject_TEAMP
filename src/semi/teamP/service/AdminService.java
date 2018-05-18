package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.AdminDAO;
import semi.teamP.dto.AdminDTO;
import semi.teamP.dto.MemberDTO;

public class AdminService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public AdminService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void adMemberList() throws IOException {
		AdminDAO dao = new AdminDAO();
		ArrayList<AdminDTO>memberlist = dao.MemberList();
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("memberList", memberlist);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void adGroupList() throws IOException {
		AdminDAO dao = new AdminDAO();
		ArrayList<AdminDTO>groupList = dao.groupList();
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("groupList", groupList);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);	
	}

	public void adMemberDel() throws IOException {
		String memberId = request.getParameter("member_Id");
		AdminDAO dao = new AdminDAO();
		
		Boolean success = dao.MemberDel(memberId);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void adGroupDel() throws IOException {
		int groupIdx = Integer.parseInt(request.getParameter("groupIdx"));
		AdminDAO dao = new AdminDAO();
		
		Boolean success = dao.groupDel(groupIdx);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void adGroupSession() throws IOException {
		int groupIdx = Integer.parseInt(request.getParameter("groupIdx"));
		boolean success = false;
		if(groupIdx>0) {
			success=true;
		}
		
		request.getSession().setAttribute("groupNum", groupIdx);
	
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}
}

package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.AdminDAO;
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
		ArrayList<MemberDTO>memberlist = dao.MemberList();
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("memberList", memberlist);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void adGroupList() {
		// TODO Auto-generated method stub
		
	}

	public void adMemberDel() {
		// TODO Auto-generated method stub
		
	}

	public void adGroupDel() {
		// TODO Auto-generated method stub
		
	}

	public void adGroupSession() {
		// TODO Auto-generated method stub
		
	}
}

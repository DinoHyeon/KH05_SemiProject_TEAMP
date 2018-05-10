package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import oracle.net.aso.i;
import semi.teamP.dao.GroupDAO;
import semi.teamP.dto.GroupInfoDTO;
import semi.teamP.dto.GroupInviteDTO;

public class GroupService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public GroupService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void groupDetail() throws IOException {
		int groupIdx = Integer.parseInt(request.getParameter("groupIdx"));
		String memberId = (String) request.getSession().getAttribute("loginId");
		System.out.println("그룹 정보 요청한 그룹번호 : "+groupIdx);
		
		GroupDAO dao = new GroupDAO();
		GroupInfoDTO dto = dao.getGroupInfo(memberId,groupIdx);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("groupInfo", dto);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void groupMemberList() throws IOException {
		int groupIdx = Integer.parseInt(request.getParameter("groupIdx"));
		String memberId = (String) request.getSession().getAttribute("loginId");
		
		GroupDAO dao = new GroupDAO();
		ArrayList<String> list = dao.groupMemberList(memberId,groupIdx);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}
	
	public void groupCreate() throws IOException {
		request.setCharacterEncoding("UTF-8");
		GroupInfoDTO infoDto = new GroupInfoDTO();
		infoDto.setMember_id(request.getParameter("groupHeadName"));
		System.out.println(infoDto.getMember_id());
		infoDto.setGroup_name(request.getParameter("groupName"));
		infoDto.setGroup_StrartDay(request.getParameter("startDate"));
		infoDto.setGroup_EndDay(request.getParameter("endDate"));
		
		GroupDAO dao = new GroupDAO();
		int success = dao.createGroup(infoDto);
		
		String page= "main_nonGroup.jsp";
		
		if(success != 0) {
			request.getSession().setAttribute("groupNum", success);
			request.getSession().setAttribute("memberLv", "master");
			page = "main_Group.jsp";
		}
		response.sendRedirect(page);
	}

	public void groupDelete() {
		// TODO Auto-generated method stub
		
	}

	public void groupInvite() throws IOException {
		GroupInviteDTO dto = new GroupInviteDTO();
		dto.setGroup_idx(Integer.parseInt(request.getParameter("inviteGroupIdx")));
		dto.setGroup_name(request.getParameter("inviteGroupName"));
		dto.setFrom_memberId((String)request.getSession().getAttribute("loginId"));
		dto.setTo_memberId(request.getParameter("inviteMemberId"));
		dto.setInvite_content(request.getParameter("inviteMsg"));
		
		System.out.println("초대받을 멤버: "+request.getParameter("inviteMemberId"));
		
		GroupDAO dao = new GroupDAO();
		
		boolean success = dao.inviteMember(dto);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
		
	}

	public void inviteRefuse() {
		// TODO Auto-generated method stub
		
	}

	public void inviteAccept() {
		// TODO Auto-generated method stub
		
	}

	public void groupInviteList() {
		// TODO Auto-generated method stub
		
	}

	public void inviteMemberIdChk() throws IOException {
		String memberId = request.getParameter("inviteMemberId");
		System.out.println(memberId);
		
		GroupDAO dao = new GroupDAO();
		//inviteMemberIdChk 값이 false면 이미 그룹이 있거나 없는 아이디
		boolean inviteMemberIdChk = dao.inviteMemberIdChk(memberId);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("result", inviteMemberIdChk);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}


	
	
}

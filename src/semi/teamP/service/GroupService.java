package semi.teamP.service;

import java.io.Console;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import oracle.net.aso.i;
import oracle.net.aso.j;
import semi.teamP.dao.GroupDAO;
import semi.teamP.dto.GroupInfoDTO;
import semi.teamP.dto.GroupInviteDTO;
import semi.teamP.dto.GroupMemberDTO;

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
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void groupMemberList() throws IOException {
		int groupIdx = Integer.parseInt(request.getParameter("groupIdx"));
		String memberId = (String) request.getSession().getAttribute("loginId");
		
		GroupDAO dao = new GroupDAO();
		ArrayList<GroupMemberDTO> list = dao.groupMemberList(memberId,groupIdx);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("groupMember", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}
	
	public void groupCreate() throws IOException, ServletException {
		request.setCharacterEncoding("UTF-8");
		GroupInfoDTO infoDto = new GroupInfoDTO();
		infoDto.setMember_id(request.getParameter("groupHeadName"));
		System.out.println(infoDto.getMember_id());
		infoDto.setGroup_name(request.getParameter("groupName"));
		infoDto.setGroup_StrartDay(request.getParameter("startDate"));
		infoDto.setGroup_EndDay(request.getParameter("endDate"));
		
		GroupDAO dao = new GroupDAO();
		int success = dao.createGroup(infoDto);
		
		String page = "main_nonGroup.jsp";
		String msg = "그룹 생성에 실패했습니다.";
		
		if(success != 0) {
			request.getSession().setAttribute("groupNum", success);
			request.getSession().setAttribute("memberLv", "master");
			msg = "그룹 생성에 성공했습니다.";
		}
		request.setAttribute("msg", msg);
		RequestDispatcher dis = request.getRequestDispatcher(page);
		dis.forward(request, response);
	}

	public void groupDelete() throws IOException {
		int groupIdx = Integer.parseInt(request.getParameter("groupInfoIdx"));
		String groupMasterId = (String) request.getSession().getAttribute("loginId");
		
		GroupDAO dao = new GroupDAO();
		boolean success = dao.groupDelete(groupIdx,groupMasterId);
		
		//그룹을 삭제하면 해당 아이디의 그룹세션 삭제, 등급세션 변경
		if(success) {
			request.getSession().setAttribute("groupNum",0);
			request.getSession().setAttribute("memberLv","member");
			groupIdx = (int) request.getSession().getAttribute("groupNum");
		}		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", success);
		map.put("groupIdx", groupIdx);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	
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

	public void inviteRefuse() throws IOException {
		int inviteIdx = Integer.parseInt(request.getParameter("inviteIdx"));
		System.out.println("거절할 초대 번호 : "+inviteIdx);
		
		GroupDAO dao = new GroupDAO();
		boolean result = dao.refuseInvite(inviteIdx);//result가 true면 거절성공
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("result", result);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void inviteAccept() throws IOException {
		int groupIdx = Integer.parseInt(request.getParameter("groupIdx"));
		String memberId = (String) request.getSession().getAttribute("loginId");
		System.out.println("수락할 초대 번호 : "+groupIdx);
		
		GroupDAO dao = new GroupDAO();
		boolean result = dao.acceptInvite(groupIdx,memberId);
		
		if(result) {
			request.getSession().setAttribute("groupNum", groupIdx);
		}
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("result", result);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void groupInviteList() throws IOException {
		String memberId = (String) request.getSession().getAttribute("loginId");
		System.out.println(memberId+"님의 그룹초대 리스트 출력");
		
		ArrayList<GroupInviteDTO>list = new ArrayList<GroupInviteDTO>();
		GroupDAO dao = new GroupDAO();
		list = dao.groupInviteList(memberId);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);	
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

	//그룹에서 멤버를 추방
	public void groupMemberOut() throws IOException {
		String memberId = request.getParameter("groupMemberId");
		int groupIdx = (int) request.getSession().getAttribute("groupNum");
		System.out.println("추방할 회원 아이디 : "+memberId);
		
		GroupDAO dao = new GroupDAO();
		boolean success = dao.groupMemberOut(memberId,groupIdx);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}

	public void groupInfoUpdate() throws IOException {
		GroupInfoDTO dto = new GroupInfoDTO();
		dto.setGroup_idx(Integer.parseInt(request.getParameter("groupInfoIdx")));
		dto.setGroup_name(request.getParameter("groupInfoName"));
		dto.setGroup_StrartDay(request.getParameter("groupInfoStartDate"));
		dto.setGroup_EndDay(request.getParameter("groupInfoEndDate"));
		
		GroupDAO dao = new GroupDAO();
		boolean success = dao.groupInfoUpdate(dto);
		
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}


	
	
}

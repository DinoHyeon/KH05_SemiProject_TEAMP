package semi.teamP.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import oracle.net.aso.i;
import semi.teamP.dao.GroupDAO;
import semi.teamP.dto.GroupInfoDTO;

public class GroupService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public GroupService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public void groupDetail() {
		// TODO Auto-generated method stub
		
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

	public void groupInvite() {
		// TODO Auto-generated method stub
		
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
	
	
}

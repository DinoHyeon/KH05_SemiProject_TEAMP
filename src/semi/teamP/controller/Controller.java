package semi.teamP.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.crypto.Data;

import semi.teamP.service.AdminService;
import semi.teamP.service.BoardService;
import semi.teamP.service.GroupService;
import semi.teamP.service.MemberService;
import semi.teamP.service.PlanService;
import semi.teamP.service.ReplyService;
import semi.teamP.service.TodoService;

@WebServlet({ "/login", "/findPw", "/findId", "/ChangePw", "/join", "/idOverlay", "/emailOverlay", "/infoUpdate", "/infoUpdateForm", "/logout", "/withdrawal"
		,"/write", "/detail", "/updateForm", "/update", "/delete"
		,"/groupJoin", "/groupDetail", "/groupCreate", "/groupDelete", "/groupInviteList", "/groupInvite", "/inviteRefuse", "/inviteAccept", "/memberOut", "/groupInfoUpdate", "/groupInfoUpdateForm", "/groupMemberList", "/memberChk" 
		,"/replyWrite", "/replyUpdate", "/replyDelete", "/replyCheck", "/replyUpdateForm"
		,"/planWrite", "/planWokerPick", "/planChange", "/planDelete", "/planDetail"
		,"/todoDetail", "/todoWrite", "/todoUpdate", "/todoDelete", "/todoChange"
		,"/adMemberList", "/adMemberDel", "/adGroupList", "/adGroupDel", "/adGroupSession" })
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		dual(request,response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		dual(request,response);
	}


	private void dual(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		String subAddr = uri.substring(ctx.length());
		
		MemberService member = null;
		BoardService board = null;
		GroupService group = null;
		ReplyService reply = null;
		PlanService plan = null;
		TodoService todo = null;
		AdminService admin = null;
		
		switch (subAddr) {
		case "/login":
			System.out.println("�α��� ��û");
			member = new MemberService(request, response);
			member.login();
			break;
			
		case "/findId":
			System.out.println("���̵� ã�� ��û");
			member = new MemberService(request, response);			
			member.findId();
			break;
			
		case "/findPw":
			System.out.println("��й�ȣ ã�� ��û");
			member = new MemberService(request, response);	
			member.findPw();
			break;
			
		case "/ChangePw":
			System.out.println("��й�ȣ ���� ��û");
			member = new MemberService(request, response);	
			member.ChangePw();
			break;
			
		case "/join":
			System.out.println("ȸ������ ��û");
			member = new MemberService(request, response);
			member.join();
			break;
			
		case "/idOverlay":
			System.out.println("���̵� �ߺ�Ȯ�� ��û");
			member = new MemberService(request, response);		
			member.idOverlay();
			break;
			
		case "/emailOverlay":
			System.out.println("�̸��� �ߺ�Ȯ�� ��û");
			member = new MemberService(request, response);	
			member.emailOverlay();
			break;
			
		case "/infoUpdate":
			System.out.println("ȸ������ ���� ��û");
			member = new MemberService(request, response);		
			member.infoUpdate();
			break;
			
		case "/infoUpdateForm":
			System.out.println("ȸ������ ���� ��� ��û");
			member = new MemberService(request, response);	
			member.infoUpdateForm();
			break;
			
		case "/logout":
			System.out.println("�α׾ƿ� ��û");
			member = new MemberService(request, response);		
			member.logout();
			break;
			
		case "/withdrawal":
			System.out.println("ȸ��Ż�� ��û");
			member = new MemberService(request, response);		
			member.withdrawal();
			break;
			
		case "/write":
			System.out.println("�� �ۼ� ��û");
			board = new BoardService(request, response);
			board.write();
			break;

		case "/detail":
			System.out.println("�� �󼼺��� ��û");
			board = new BoardService(request, response);
			board.detail();
			break;
			
		case "/updateForm":
			System.out.println("�� ���� ��� ��û");
			board = new BoardService(request, response);
			board.updateForm();
			break;
			
		case "/update":
			System.out.println("�� ���� ��û");
			board = new BoardService(request, response);
			board.update();
			break;
			
		case "/delete":
			System.out.println("�� ���� ��û");
			board = new BoardService(request, response);	
			board.delete();
			break;
			
		case "/groupDetail":
			System.out.println("�׷� ������ ��û");
			group = new GroupService(request, response);
			group.groupDetail();
			break;
		case "/groupCreate":
			System.out.println("�׷� ���� ��û");
			group = new GroupService(request, response);
			group.groupCreate();
			break;
			
		case "/groupDelete":
			System.out.println("�׷� ���� ��û");
			group = new GroupService(request, response);
			group.groupDelete();
			break;
			
		case "/groupInvite":
			System.out.println("�׷� �ʴ� ��û");
			group = new GroupService(request, response);
			group.groupInvite();
			break;
			
		case "/groupInviteList":
			System.out.println("�׷� �ʴ� ��� ��û");
			group = new GroupService(request, response);
			group.groupInviteList();
			break;			
			
		case "/inviteRefuse":
			System.out.println("�׷� �ʴ� ���� ��û");
			group = new GroupService(request, response);
			group.inviteRefuse();
			break;
			
		case "/inviteAccept":
			System.out.println("�׷� �ʴ� ���� ��û");
			group = new GroupService(request, response);
			group.inviteAccept();
			break;
			
		case "/replyWrite":
			System.out.println("��� �ۼ� ��û");
			reply = new ReplyService(request, response);
			reply.replyWrite();
			break;
			
		case "/replyUpdate":
			System.out.println("��� �ۼ� ��û");
			reply = new ReplyService(request, response);
			reply.replyUpdate();
			break;
			
		case "/replyDelete":
			System.out.println("��� �ۼ� ��û");
			reply = new ReplyService(request, response);
			reply.replyDelete();
			break;
			
		case "/replyCheck":
			System.out.println("��� �ۼ� ��û");
			reply = new ReplyService(request, response);
			reply.replyCheck();
			break;
			
		case "/replyUpdateForm":
			System.out.println("��� �ۼ� ��û");
			reply = new ReplyService(request, response);
			reply.replyUpdateForm();
			break;
			
		case "/planWrite":
			System.out.println("���� �ۼ� ��û");
			plan = new PlanService(request, response);
			plan.planWrite();
			break;
			
		case "/planWokerPick":
			System.out.println("���� ������ ���� ��û");
			plan = new PlanService(request, response);
			plan.planWokerPick();
			break;
			
		case "/planChange":
			System.out.println("���� ���� ���� ��û");
			plan = new PlanService(request, response);
			plan.planChange();
			break;
			
		case "/planDelete":
			System.out.println("���� ���� ��û");
			plan = new PlanService(request, response);
			plan.planDelete();
			break;
			
		case "/planDetail":
			System.out.println("���� �󼼺��� ��û");
			plan = new PlanService(request, response);
			plan.planDetail();
			break;
			
		case "/todoDetail":
			System.out.println("todo �󼼺��� ��û");
			todo = new TodoService(request, response);
			todo.todoDetail();
			break;
			
		case "/todoWrite":
			System.out.println("todo �󼼺��� ��û");
			todo = new TodoService(request, response);
			todo.todoWrite();
			break;
			
		case "/todoUpdate":
			System.out.println("todo �󼼺��� ��û");
			todo = new TodoService(request, response);
			todo.todoUpdate();
			break;
			
		case "/todoDelete":
			System.out.println("todo �󼼺��� ��û");
			todo = new TodoService(request, response);
			todo.todoDelete();
			break;
			
		case "/todoChange":
			System.out.println("todo �󼼺��� ��û");
			todo = new TodoService(request, response);
			todo.todoChange();
			break;
			
		case "/adMemberList":
			System.out.println("������) ȸ�� ����Ʈ ��û");
			admin = new AdminService(request, response);
			admin.adMemberList();
			break;
			
		case "/adMemberDel":
			System.out.println("������) ȸ�� ���� ��û");
			admin = new AdminService(request, response);
			admin.adMemberDel();
			break;
			
		case "/adGroupList":
			System.out.println("������) �׷� ����Ʈ ��û");
			admin = new AdminService(request, response);
			admin.adGroupList();
			break;
			
		case "/adGroupDel":
			System.out.println("������) �׷� ���� ��û");
			admin = new AdminService(request, response);
			admin.adGroupDel();
			break;
			
		case "/adGroupSession":	
			System.out.println("������) ���� �׷� ���� ��û");
			admin = new AdminService(request, response);
			admin.adGroupSession();
			break;
		}
	}

}

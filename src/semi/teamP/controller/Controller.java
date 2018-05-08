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
			System.out.println("로그인 요청");
			member = new MemberService(request, response);
			member.login();
			break;
			
		case "/findId":
			System.out.println("아이디 찾기 요청");
			member = new MemberService(request, response);			
			member.findId();
			break;
			
		case "/findPw":
			System.out.println("비밀번호 찾기 요청");
			member = new MemberService(request, response);	
			member.findPw();
			break;
			
		case "/ChangePw":
			System.out.println("비밀번호 변경 요청");
			member = new MemberService(request, response);	
			member.ChangePw();
			break;
			
		case "/join":
			System.out.println("회원가입 요청");
			member = new MemberService(request, response);
			member.join();
			break;
			
		case "/idOverlay":
			System.out.println("아이디 중복확인 요청");
			member = new MemberService(request, response);		
			member.idOverlay();
			break;
			
		case "/emailOverlay":
			System.out.println("이메일 중복확인 요청");
			member = new MemberService(request, response);	
			member.emailOverlay();
			break;
			
		case "/infoUpdate":
			System.out.println("회원정보 수정 요청");
			member = new MemberService(request, response);		
			member.infoUpdate();
			break;
			
		case "/infoUpdateForm":
			System.out.println("회원정보 수정 양식 요청");
			member = new MemberService(request, response);	
			member.infoUpdateForm();
			break;
			
		case "/logout":
			System.out.println("로그아웃 요청");
			member = new MemberService(request, response);		
			member.logout();
			break;
			
		case "/withdrawal":
			System.out.println("회원탈퇴 요청");
			member = new MemberService(request, response);		
			member.withdrawal();
			break;
			
		case "/write":
			System.out.println("글 작성 요청");
			board = new BoardService(request, response);
			board.write();
			break;

		case "/detail":
			System.out.println("글 상세보기 요청");
			board = new BoardService(request, response);
			board.detail();
			break;
			
		case "/updateForm":
			System.out.println("글 수정 양식 요청");
			board = new BoardService(request, response);
			board.updateForm();
			break;
			
		case "/update":
			System.out.println("글 수정 요청");
			board = new BoardService(request, response);
			board.update();
			break;
			
		case "/delete":
			System.out.println("글 삭제 요청");
			board = new BoardService(request, response);	
			board.delete();
			break;
			
		case "/groupDetail":
			System.out.println("그룹 상세정보 요청");
			group = new GroupService(request, response);
			group.groupDetail();
			break;
		case "/groupCreate":
			System.out.println("그룹 생성 요청");
			group = new GroupService(request, response);
			group.groupCreate();
			break;
			
		case "/groupDelete":
			System.out.println("그룹 삭제 요청");
			group = new GroupService(request, response);
			group.groupDelete();
			break;
			
		case "/groupInvite":
			System.out.println("그룹 초대 요청");
			group = new GroupService(request, response);
			group.groupInvite();
			break;
			
		case "/groupInviteList":
			System.out.println("그룹 초대 목록 요청");
			group = new GroupService(request, response);
			group.groupInviteList();
			break;			
			
		case "/inviteRefuse":
			System.out.println("그룹 초대 거절 요청");
			group = new GroupService(request, response);
			group.inviteRefuse();
			break;
			
		case "/inviteAccept":
			System.out.println("그룹 초대 수락 요청");
			group = new GroupService(request, response);
			group.inviteAccept();
			break;
			
		case "/replyWrite":
			System.out.println("댓글 작성 요청");
			reply = new ReplyService(request, response);
			reply.replyWrite();
			break;
			
		case "/replyUpdate":
			System.out.println("댓글 작성 요청");
			reply = new ReplyService(request, response);
			reply.replyUpdate();
			break;
			
		case "/replyDelete":
			System.out.println("댓글 작성 요청");
			reply = new ReplyService(request, response);
			reply.replyDelete();
			break;
			
		case "/replyCheck":
			System.out.println("댓글 작성 요청");
			reply = new ReplyService(request, response);
			reply.replyCheck();
			break;
			
		case "/replyUpdateForm":
			System.out.println("댓글 작성 요청");
			reply = new ReplyService(request, response);
			reply.replyUpdateForm();
			break;
			
		case "/planWrite":
			System.out.println("일정 작성 요청");
			plan = new PlanService(request, response);
			plan.planWrite();
			break;
			
		case "/planWokerPick":
			System.out.println("일정 진행자 지정 요청");
			plan = new PlanService(request, response);
			plan.planWokerPick();
			break;
			
		case "/planChange":
			System.out.println("일정 상태 변경 요청");
			plan = new PlanService(request, response);
			plan.planChange();
			break;
			
		case "/planDelete":
			System.out.println("일정 삭제 요청");
			plan = new PlanService(request, response);
			plan.planDelete();
			break;
			
		case "/planDetail":
			System.out.println("일정 상세보기 요청");
			plan = new PlanService(request, response);
			plan.planDetail();
			break;
			
		case "/todoDetail":
			System.out.println("todo 상세보기 요청");
			todo = new TodoService(request, response);
			todo.todoDetail();
			break;
			
		case "/todoWrite":
			System.out.println("todo 상세보기 요청");
			todo = new TodoService(request, response);
			todo.todoWrite();
			break;
			
		case "/todoUpdate":
			System.out.println("todo 상세보기 요청");
			todo = new TodoService(request, response);
			todo.todoUpdate();
			break;
			
		case "/todoDelete":
			System.out.println("todo 상세보기 요청");
			todo = new TodoService(request, response);
			todo.todoDelete();
			break;
			
		case "/todoChange":
			System.out.println("todo 상세보기 요청");
			todo = new TodoService(request, response);
			todo.todoChange();
			break;
			
		case "/adMemberList":
			System.out.println("관리자) 회원 리스트 요청");
			admin = new AdminService(request, response);
			admin.adMemberList();
			break;
			
		case "/adMemberDel":
			System.out.println("관리자) 회원 삭제 요청");
			admin = new AdminService(request, response);
			admin.adMemberDel();
			break;
			
		case "/adGroupList":
			System.out.println("관리자) 그룹 리스트 요청");
			admin = new AdminService(request, response);
			admin.adGroupList();
			break;
			
		case "/adGroupDel":
			System.out.println("관리자) 그룹 삭제 요청");
			admin = new AdminService(request, response);
			admin.adGroupDel();
			break;
			
		case "/adGroupSession":	
			System.out.println("관리자) 선택 그룹 세션 요청");
			admin = new AdminService(request, response);
			admin.adGroupSession();
			break;
		}
	}

}

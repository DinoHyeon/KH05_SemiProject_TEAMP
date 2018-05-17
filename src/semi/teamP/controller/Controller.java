package semi.teamP.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.service.AdminService;
import semi.teamP.service.BoardService;
import semi.teamP.service.GroupService;
import semi.teamP.service.HeaderMenuService;
import semi.teamP.service.MemberService;
import semi.teamP.service.PlanService;
import semi.teamP.service.ReplyService;
import semi.teamP.service.TodoService;


@WebServlet({ "/login", "/findPw", "/findId", "/ChangePw", "/join", "/idOverlay", "/emailOverlay", "/infoUpdate", "/infoUpdateForm", "/logout", "/withdrawal", "/infoFormAccess", "/memberPasswordCheck"
	,"/write", "/detail", "/updateForm", "/update", "/comunityBbsDelete","/groupBbsDelete","/comunityList","/adminList", "/groupList", "/createMenuSession" , "/groupWrite" , "/adminGroupBbsList"
	,"/fileList", "/fileWrite", "/fileUpdate", "/fileUpdateForm", "/fileDetail", "/fileDelete", "/fileDownLoad", "/adminFileBbsList"
	,"/groupJoin", "/groupDetail", "/groupCreate", "/groupDelete", "/inviteMemberIdChk", "/groupWithdrawal", "/groupInviteList", "/groupInvite", "/inviteRefuse", "/inviteAccept", "/memberOut", "/groupInfoUpdate", "/groupInfoUpdateForm", "/groupMemberList", "/memberChk" 
	,"/replyWrite", "/replyUpdate", "/replyDelete", "/replyCheck", "/replyUpdateForm"
	,"/planWrite", "/planlist", "/planChange", "/planDelete", "/planDetail", "/planTableList","/planDayList"
	,"/todoDetail", "/todoWrite", "/todoUpdate", "/todoDelete", "/todoChange"
	,"/adMemberList", "/adMemberDel", "/adGroupList", "/adGroupDel", "/adGroupSession"
	,"/headerMenuInfo"})
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
		HeaderMenuService header = null;
		
		switch (subAddr) {
		case "/createMenuSession":
			System.out.println("메뉴세션 생성 요청");
			String menu = request.getParameter("menuName");
			request.getSession().setAttribute("menuName", menu);
			if(request.getSession().getAttribute("menuName")!=null) {
				Gson json = new Gson();
				HashMap<String, String> map = new HashMap<>();
				map.put("menu", menu);
				String obj = json.toJson(map);
				response.getWriter().println(obj);
			}
			break;
			
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
			System.out.println("회원등록 요청");
			member = new MemberService(request, response);
			member.join();
			break;
			
		case "/idOverlay":
			System.out.println("아이디 중복 검사 요청");
			member = new MemberService(request, response);		
			member.idOverlay();
			break;
			
		case "/emailOverlay":
			System.out.println("이메일 중복 검사 요청");
			member = new MemberService(request, response);	
			member.emailOverlay();
			break;
		
		case "/memberPasswordCheck":
			System.out.println("회원 비밀번호 확인 요청");
			member = new MemberService(request, response);
			member.memberPasswordCheck();
			break;
			
		case "/infoUpdate":
			System.out.println("회원정보 수정 요청");
			member = new MemberService(request, response);		
			member.infoUpdate();
			break;
			
		case "/infoUpdateForm":
			System.out.println("회원정보 수정 폼 요청");
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
			System.out.println("게시글 글 등록 요청");
			board = new BoardService(request, response);
			board.write();
			break;
		
		case "/groupWrite":
			System.out.println("글쓰기(그룹이있는사람) 요청");
			board = new BoardService(request, response);
			board.groupWrite();
			
		case "/detail":
			System.out.println("게시글 상세보기 요청");
			board = new BoardService(request, response);
			board.detail();
			break;
			
		case "/updateForm":
			System.out.println("게시글 수정 폼 요청");
			board = new BoardService(request, response);
			board.updateForm();
			break;
			
		case "/update":
			System.out.println("게시글 수정 요청");
			board = new BoardService(request, response);
			board.update();
			break;
			
		case "/comunityBbsDelete":
			System.out.println("게시글 삭제 요청");
			board = new BoardService(request, response);	
			board.comunityBbsDelete();
			break;
			
		case "/groupBbsDelete":
			System.out.println("게시글 삭제 요청");
			board = new BoardService(request, response);	
			board.groupBbsDelete();
			break;
			
		case "/comunityList":
			System.out.println("리스트 요청");
			board = new BoardService(request, response);
			board.list();
			break;
			
		case "/adminList":
			System.out.println("관리자 리스트 요청");
			board = new BoardService(request, response);
			board.adminList();
			break;
			
		case "/adminGroupBbsList":
			System.out.println("그룹 리스트 요청(관리자)");
			board = new BoardService(request, response);
			board.adminGroupBbsList();
			break;
			
		case "/groupList":
			System.out.println("그룹 리스트 요청");
			board = new BoardService(request, response);
			board.groupList();
			break;
			
		case "/fileList":
	         System.out.println("파일게시판  리스트 요청");
	         board = new BoardService(request, response);
	         board.fileList();
	         break;   
	      
	    case "/fileWrite":   
	         System.out.println("파일 게시글 글 등록 요청");
	         board = new BoardService(request, response);
	         board.fileWrite();
	         break; 
	         
	    case "/fileUpdate":
	    	System.out.println("파일 게시글 수정 요청");
	    	board = new BoardService(request, response);
	    	board.fileUpdate();
	    	break;
	    	
	    case "/fileUpdateForm":
	    	System.out.println("파일 게시글 수정 폼 요청");
	    	board = new BoardService(request, response);
	    	board.fileUpdateForm();
	    	break;
	    	
	    case "/fileDetail":
	    	System.out.println("파일 게시글 상세보기 요청");
	    	board = new BoardService(request, response);
	    	board.fileDetail();
	    	break;
	    	
	    case "/fileDelete":
	    	System.out.println("파일 게시글 삭제 요청");
	    	board = new BoardService(request, response);
	    	board.fileDelete();
	    	break;
	    	
	    case "/fileDownLoad":
	    	System.out.println("첨부파일 다운로드 요청");
	    	board = new BoardService(request, response);
	    	board.fileDownLoad();
	    	break;
	    	    	
	    case "/adminFileBbsList":
	    	System.out.println("파일게시판 관리자 모드");
	    	board = new BoardService(request, response);
	    	board.adminFileBbsList();
	    	break;
			
		case "/groupDetail":
			System.out.println("그룹 정보 보기 요청");
			group = new GroupService(request, response);
			group.groupDetail();
			break;
		
		case "/groupInfoUpdate":
			System.out.println("그룹 정보 수정");
			group = new GroupService(request, response);
			group.groupInfoUpdate();
			break;
			
		case "/groupMemberList":
			System.out.println("그룹 멤버 조회 요청");
			group = new GroupService(request, response);
			group.groupMemberList();
			break;
			
		case "/memberOut":
			System.out.println("그룹 멤버 추방 요청");
			group = new GroupService(request, response);
			group.groupMemberOut();
			break;
		case "/groupWithdrawal":
			System.out.println("그룹 탈퇴 요청");
			group = new GroupService(request, response);
			group.groupWithdrawal();
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
		case "/inviteMemberIdChk":
			System.out.println("그룹 초대 멤버 아이디 확인");
			group = new GroupService(request, response);
			group.inviteMemberIdChk();
			break;
			
		case "/groupInvite":
			System.out.println("그룹 초대 요청");
			group = new GroupService(request, response);
			group.groupInvite();
			break;
			
		case "/groupInviteList":
			System.out.println("그룹 초대 리스트 요청");
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
			System.out.println("댓글 수정 요청");
			reply = new ReplyService(request, response);
			reply.replyUpdate();
			break;
			
		case "/replyDelete":
			System.out.println("댓글 삭제 요청");
			reply = new ReplyService(request, response);
			reply.replyDelete();
			break;
			
		case "/replyCheck":
			System.out.println("댓글 불러오기 요청");
			reply = new ReplyService(request, response);
			reply.replyCheck();
			break;
			
		case "/replyUpdateForm":
			System.out.println("댓글 수정 폼 요청");
			reply = new ReplyService(request, response);
			reply.replyUpdateForm();
			break;
			
		case "/planWrite":
			System.out.println("일정 작성 요청");
			plan = new PlanService(request, response);
			plan.planWrite();
			break;
			
		case "/planlist":
			System.out.println("일정 리스트 요청");
			plan = new PlanService(request, response);
			plan.planlist();
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
		
		case "/planTableList":
			System.out.println("일정 테이블 호출 요청");
			plan = new PlanService(request, response);
			plan.planTableList();
			break;
			
		case "/planDayList":
			System.out.println("일정 하단 테이블 호출 요청");
			plan = new PlanService(request, response);
			plan.planDayList();
			break;
			
		case "/todoDetail":
			System.out.println("할일 상세보기 요청 ");
			todo = new TodoService(request, response);
			todo.todoDetail();
			break;
			
		case "/todoWrite":
			System.out.println("할일 작성 요청");
			todo = new TodoService(request, response);
			todo.todoWrite();
			break;
			
		case "/todoUpdate":
			System.out.println("할일 수정 요청");
			todo = new TodoService(request, response);
			todo.todoUpdate();
			break;
			
		case "/todoDelete":
			System.out.println("할일 삭제 요청");
			todo = new TodoService(request, response);
			todo.todoDelete();
			break;
			
		case "/todoChange":
			System.out.println("할일 상태 변경 요청");
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
			System.out.println("관리자) 그룹 접근 권한 요청");
			admin = new AdminService(request, response);
			admin.adGroupSession();
			break;
		case "/headerMenuInfo":
			System.out.println("상단메뉴 정보요청");
			header = new HeaderMenuService(request,response);
			header.getGroupInfo();
			break;
		}
	}

}

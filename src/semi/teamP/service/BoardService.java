package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.teamP.dao.BoardDAO;
import semi.teamP.dto.BoardDTO;

public class BoardService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public BoardService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	// 글쓰기
	public void write() throws IOException {
		
		BoardDTO dto = new BoardDTO();
		dto.setMember_id((String)request.getSession().getAttribute("loginId"));
		dto.setBbs_name(request.getParameter("bbs_name"));
		dto.setBbs_subject(request.getParameter("bbs_subject"));
		dto.setBbs_content(request.getParameter("bbs_content"));
		dto.setGroup_idx((int)request.getSession().getAttribute("groupNum"));	
		
		BoardDAO dao = new BoardDAO();
		int idx = dao.write(dto);
		
		if(idx > 0) {
			response.sendRedirect("detail?idx=" + dto.getBbs_idx());
		}
	}

	//수정 보기
	public void updateForm() throws ServletException, IOException {
		String idx = request.getParameter("idx");
		//상세정보 가져오기(DB)
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.detail(idx);
		//수정 보기 페이지에 뿌려 준다.
		request.setAttribute("dto", dto);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/updateForm.jsp");
		dis.forward(request, response);
	}

	//상세보기
	public void detail() throws ServletException, IOException {
	      //DB 에 개별 데이터 요청
	      BoardDAO dao = new BoardDAO();
	      BoardDTO dto =  dao.detail(request.getParameter("idx"));
	      //가져온 데이터를 request 에 담기      
	      request.setAttribute("info", dto);
	      //특정한 페이지로 이동 
	      RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/detail.jsp");
	      dis.forward(request, response);
	      
	   }
	
	//게시판 삭제
   public void delete() throws IOException {
      //파라메터 추출
      String idx = request.getParameter("idx");
      BoardDAO dao = new  BoardDAO();
      if(dao.del(idx) > 0) {
    	  if(!request.getSession().getAttribute("loginId").equals("admin")) {
    		  response.sendRedirect("comunityList");
    	  }else {
    		  response.sendRedirect("adminList");
    	  }
      }  
   }

	//수정
	public void update() throws IOException {
		BoardDTO dto = new BoardDTO();
		dto.setBbs_subject(request.getParameter("bbs_subject"));
		dto.setBbs_content(request.getParameter("bbs_content"));
		dto.setBbs_idx(Integer.parseInt(request.getParameter("idx")));
		BoardDAO dao = new BoardDAO();
		
		if(dao.update(dto) > 0) {
			response.sendRedirect("detail?idx=" + dto.getBbs_idx());
		}
	}
	//의견나눔게시판 리스트 불러오기
	public void list() throws IOException, ServletException {
		BoardDAO dao = new BoardDAO();
		//데이터가 담긴 어레이 리스트
		ArrayList<BoardDTO> list = dao.list();
		System.out.println(list.size());
		request.setAttribute("list",list);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/comunityBbs.jsp");
		dis.forward(request, response);
	}
	//공지사항 리스트 불러오기
	public void adminList() throws ServletException, IOException {
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.adminList();
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/adminBbs.jsp");
		dis.forward(request, response);
		
	}
	//그룹 리스트 불러오기
	public void groupList() throws ServletException, IOException {
		int group_idx = (int)request.getSession().getAttribute("groupNum");
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.groupList(group_idx);
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/groupBbs.jsp");
		dis.forward(request, response);
	}

}

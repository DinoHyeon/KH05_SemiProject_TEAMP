package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import semi.teamP.dao.BoardDAO;
import semi.teamP.dto.BoardDTO;
import semi.teamP.dto.PageDTO;

public class BoardService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public BoardService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	//글쓰기(그룹이 있는 사람)
	public void groupWrite() throws ServletException, IOException {
		BoardDTO dto = new BoardDTO();
		//로그인 세션값 dto에 담기
		dto.setMember_id((String)request.getSession().getAttribute("loginId"));
		//글쓰기폼의 파라미터값 dto에 담기
		dto.setBbs_name(request.getParameter("bbs_name"));
		dto.setBbs_subject(request.getParameter("bbs_subject"));
		dto.setBbs_content(request.getParameter("bbs_content"));
		//그룹번호 세션값 dto에 담기
		dto.setGroup_idx(((int)request.getSession().getAttribute("groupNum")));	
		
		BoardDAO dao = new BoardDAO();
		int idx = dao.groupWrite(dto);
		
		//그룹번호값이 0이 아닌경우(그룹이 있는경우) 해당페이지로 보냄 
		if(idx > 0 && dto.getGroup_idx() != 0) {
			response.sendRedirect("detail?idx=" + dto.getBbs_idx());
		}
	}

	// 글쓰기(그룹이 없는 사람)
	public void write() throws IOException, ServletException {
		BoardDTO dto = new BoardDTO();
		
		dto.setMember_id((String)request.getSession().getAttribute("loginId"));
		dto.setBbs_name(request.getParameter("bbs_name"));
		dto.setBbs_subject(request.getParameter("bbs_subject"));
		dto.setBbs_content(request.getParameter("bbs_content"));
			
		BoardDAO dao = new BoardDAO();
		int idx = dao.write(dto);
		int groupNum = (int) request.getSession().getAttribute("groupNum");
		//EL태그사용을 위한 값셋팅
		request.setAttribute("groupNum", groupNum);
		//그룹번호가 0이면(그룹이 없으면) 해당 페이지로 보냄
		if(idx > 0 && groupNum == 0) {
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
	      System.out.println("페이지번호 : "+Integer.parseInt(request.getParameter("pageNo")));
	      request.setAttribute("pageNo", Integer.parseInt(request.getParameter("pageNo")));
	      request.setAttribute("info", dto);
	      
	      /*******************************
	       *detail 컨트롤러는 여러번의 응답을 요청받는다 
	       * 
	       * dis.foward() 는 한번의 응답만 요청받아서 끝내버린다
	       * 
	       * dis.include(request,response)사용 !!!!!!!!!!!!!!
	       * 응답을 끝내고 대기했다가 다른 응답이 오면 다시 처리해준다
	       * response.setCharacterEncoding("UTF-8"); 후에 인코딩이 필요함. 안해주면 ???로 뜸
	       * *****************************/
	      RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/detail.jsp");
	      response.setCharacterEncoding("UTF-8");
	      dis.include(request, response);
	   }
	
	//의견나눔게시판 삭제
   public void comunityBbsDelete() throws IOException {
      //파라메터 추출
      String idx = request.getParameter("idx");
      BoardDAO dao = new  BoardDAO();
      if(dao.del(idx) > 0) {
    	  //관리자가 아니면(일반유저) 삭제시 comunityList 호출
    	  if(!request.getSession().getAttribute("loginId").equals("admin")) {
    		  response.sendRedirect("comunityList");
    	  }else {//관리자면 관리자 의견나눔게시판 관리페이지 호출
    		  response.sendRedirect("adminList");
    	  }
      }  
   }
   
   //그룹게시판 삭제
   public void groupBbsDelete() throws IOException {
	   //파라메터 추출
	      String idx = request.getParameter("idx");
	      BoardDAO dao = new  BoardDAO();
	      if(dao.del(idx) > 0) {
	    	  //관리자가 아니면(일반유저) 삭제시 groupList 호출
	    	  if(!request.getSession().getAttribute("loginId").equals("admin")) {
	    		  response.sendRedirect("groupList");
	    	  }else {//관리자면 관리자 그룹게시판 관리페이지 호출
	    		  response.sendRedirect("adminGroupBbsList");
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
		String keyField = "";
		String keyWord ="";
	
		//검색값이 있다면 해당 파라미터 가져오기
		if(request.getParameter("keyWord") != null) {
			 keyField = request.getParameter("keyField");
			 keyWord = request.getParameter("keyWord");
			 System.out.println(keyField);
			 System.out.println(keyWord);
		}  
		
		//페이징
		BoardDAO dao = new BoardDAO();
		int pageNo = 0;
		if(request.getParameter("pageNo")!=null) {
			pageNo = Integer.parseInt(request.getParameter("pageNo"));
			System.out.println("pageNo"+pageNo);
		}else {
			System.out.println("pageNo"+pageNo);
		}
			
	 	PageDTO paging = new PageDTO();
        paging.setPageNo(pageNo);
        paging.setPageSize(10);
        paging.setTotalCount(dao.getTotalCount(keyField, keyWord));

		ArrayList<BoardDTO> list = dao.list(keyField, keyWord,(pageNo-1)*10, pageNo*10);
		System.out.println(list.size());
		request.setAttribute("list",list);
		request.setAttribute("paging",paging);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/comunityBbs.jsp");
		dis.forward(request, response);
	}
	
	//공지사항 리스트 불러오기
	public void adminList() throws ServletException, IOException {
		String keyField = "";
		String keyWord ="";
	
		//검색값이 있다면 해당 파라미터 가져오기
		if(request.getParameter("keyWord") != null) {
			 keyField = request.getParameter("keyField");
			 keyWord = request.getParameter("keyWord");
			 System.out.println(keyField);
			 System.out.println(keyWord);
		}
		
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.adminList(keyField, keyWord);
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/adminBbs.jsp");
		dis.forward(request, response);
		
	}
	
	
	//그룹 리스트 불러오기(그룹장 및 그룹원)
	public void groupList() throws ServletException, IOException {
		String keyField = "";
		String keyWord ="";
	
		//검색값이 있다면 해당 파라미터 가져오기
		if(request.getParameter("keyWord") != null) {
			 keyField = request.getParameter("keyField");
			 keyWord = request.getParameter("keyWord");
			 System.out.println(keyField);
			 System.out.println(keyWord);
		}
		
		int group_idx = (int)request.getSession().getAttribute("groupNum");
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.groupList(group_idx, keyField, keyWord);
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/groupBbs.jsp");
		dis.forward(request, response);
	}
	
	//그룹 리스트 불러오기(관리자)
	public void adminGroupBbsList() throws ServletException, IOException {
		String keyField = "";
		String keyWord ="";
	
		//검색값이 있다면 해당 파라미터 가져오기
		if(request.getParameter("keyWord") != null) {
			 keyField = request.getParameter("keyField");
			 keyWord = request.getParameter("keyWord");
			 System.out.println(keyField);
			 System.out.println(keyWord);
		}
		
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.adminGroupBbsList(keyField,keyWord);
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/adminGroupBbsList.jsp");
		dis.forward(request, response);
	}

	//파일 게시판 불러오기
   public void fileList() throws ServletException, IOException {
	   String keyField = "";
	   String keyWord ="";

	   //검색값이 있다면 해당 파라미터 가져오기
	   if(request.getParameter("keyWord") != null) {
		   keyField = request.getParameter("keyField");
		   keyWord = request.getParameter("keyWord");
		   System.out.println(keyField);
		   System.out.println(keyWord);
	   }	  
	   
      int group_idx = (int)request.getSession().getAttribute("groupNum");
      //DB 이용해서 데이터 가져오기
      BoardDAO dao = new BoardDAO();
      ArrayList<BoardDTO> list = dao.filelist(group_idx, keyField, keyWord);
      //가져온 데이터를 request 에 담기
      request.setAttribute("list", list);
      //특정한 페이지로 이동 
      RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/fileBbs.jsp");
      dis.forward(request, response);

   }

   //파일게시판 글쓰기 
   public void fileWrite() throws IOException {
      //1. PhotoUpload 에게 request 를 전달
      PhotoUpload upload = new PhotoUpload(request,response);
      //2. regist 메서드를 사용해서 사진 등록
      //3. 제목, 내용, 작성자, 파일명을 받는다  BoardDTO
      BoardDTO dto = upload.regist();
      System.out.println(dto.getBbs_content());
      System.out.println(dto.getNewFileName());
      //4. DAO 에 dto 를 전달하여 DB 에 추가해 달라고 요청
      BoardDAO dao = new BoardDAO();
      int pk = dao.fileWrite(dto);      
      //5. 결과에 따라 페이지 이동 
      //실패(글쓰기 폼 )
      String page = "TeamPBbs/fileWriteForm.jsp";
      if(pk > 0) {
         //성공(상세보기) = 글쓰기 한 후 idx를 반환
         page = "fileDetail?idx=" + pk;
      }
      response.sendRedirect(page);
      
   }
	
   //파일게시판 수정
	public void fileUpdate() throws IOException {
		PhotoUpload upload = new PhotoUpload(request,response);
		BoardDTO dto = upload.regist();
		//DB 이용 해서 글 수정
		BoardDAO dao = new BoardDAO();
		String oldFileName = null;
		//올린 파일이 있는가? 있다면 기존파일명은?
		
		dao.fileUpdate(dto); //DB를 이용해서 글 수정
		
		if(dto.getNewFileName() != null) { //새로 올리는 파일이 있을 경우
			//올린 파일이 있다는 것은 기존 파일을 지워야 하는 것을 의미하므로 파일명을 알아야한다.
			oldFileName = dao.fileNameCall(dto.getBbs_idx());
			dao = new BoardDAO(); // update()에서 자원을 닫았으므로 다시 객체화
			dao.fileNameUpdate(dto.getBbs_idx(),dto.getNewFileName(), oldFileName);
			//기존 파일을 폴더에서 삭제
			upload.del(oldFileName);
		}
		response.sendRedirect("fileDetail?idx=" + dto.getBbs_idx());
	}
	
	
	//파일게시판 수정 폼
	public void fileUpdateForm() throws ServletException, IOException {
		String idx = request.getParameter("idx");
		//상세정보 가져오기(DB)
		BoardDAO dao = new BoardDAO();
		BoardDTO dto = dao.fileDetail(idx);
		//수정 보기 페이지에 뿌려 준다.
		request.setAttribute("dto", dto);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/fileUpdateForm.jsp");
		dis.forward(request, response);
	}

	//파일게시판 상세보기
	public void fileDetail() throws ServletException, IOException {
		 //DB 에 개별 데이터 요청
	      BoardDAO dao = new BoardDAO();
	      BoardDTO dto =  dao.fileDetail(request.getParameter("idx"));
	      //가져온 데이터를 request 에 담기      
	      request.setAttribute("info", dto);  
	      RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/fileDetail.jsp");
	      dis.forward(request, response);
	}
	
	//파일게시판 삭제
	public void fileDelete() throws IOException {
		String idx = request.getParameter("idx");
		BoardDAO dao = new BoardDAO();
		String fileName = dao.fileNameCall(Integer.parseInt(idx));
		//CASCADE 조건을 주었으므로 Bbs테이블을 지우면 Bbs_file의 자식도 지워지기 때문에  del() DAO 를 사용하여도 무관함
		if(dao.del(idx) > 0) {
			if(fileName != null) {
				PhotoUpload upload = new PhotoUpload(request,response);
				upload.del(fileName);
			}
		}
		if(request.getSession().getAttribute("loginId").equals("admin")) {
			response.sendRedirect("adminFileBbsList");
		}else {
			response.sendRedirect("fileList");
		}
		
	}
	
	//파일게시판 (관리자모드)
	public void adminFileBbsList() throws ServletException, IOException {
		String keyField = "";
		String keyWord ="";
	
		//검색값이 있다면 해당 파라미터 가져오기
		if(request.getParameter("keyWord") != null) {
			 keyField = request.getParameter("keyField");
			 keyWord = request.getParameter("keyWord");
			 System.out.println(keyField);
			 System.out.println(keyWord);
		}
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.adminFileBbsList(keyField, keyWord);
		request.setAttribute("list", list);
		RequestDispatcher dis = request.getRequestDispatcher("TeamPBbs/adminFileBbsList.jsp");
		dis.forward(request, response);
	}

	//첨부파일 다운로드
	public void fileDownLoad() throws IOException {
		request.setCharacterEncoding("UTF-8");
		String idx = request.getParameter("idx");
		BoardDAO dao = new BoardDAO();
		String fileName = dao.fileNameCall(Integer.parseInt(idx));
		
		if(fileName != null) {
			PhotoUpload upload = new PhotoUpload(request,response);
			upload.downLoad(fileName);
		}
		
	}


}

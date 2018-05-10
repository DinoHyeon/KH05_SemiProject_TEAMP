package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.TodoDAO;
import semi.teamP.dto.TodoDTO;

public class TodoService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public TodoService(HttpServletRequest request, HttpServletResponse response) {
		super();
		this.request = request;
		this.response = response;
	}
	//리스트 요청
	public void todoDetail() throws IOException {
		TodoDAO dao=new TodoDAO();
		//로그인 상태
		String loginId = (String) request.getSession().getAttribute("loginId");
		//데이터가 담긴 어레이리스트 
		ArrayList<TodoDTO> list= dao.list(loginId);
		//response 반환
		Gson json = new Gson();
		HashMap<String, Object>map=new HashMap<>();
		if(loginId!=null) { 
			request.setAttribute("list", list); 
			map.put("login",true);//로그인에 되어있다면 true
		}else {
			map.put("login",false);//로그인상태아니면 false
		}
		
		map.put("list",list);//리스트 넣고
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");//한글있으니까 깨짐방지
		response.getWriter().println(obj);
		
	}
		

	public void todoChange() {
		// TODO Auto-generated method stub
		
	}

	public void todoUpdate() {
		// TODO Auto-generated method stub
		
	}

	public void todoDelete() throws IOException {
		String content = request.getParameter("delcontent");
		System.out.println("id : "+id);
		PhotoDAO dao = new PhotoDAO();
		//글 번호로 파일명 추출(DB)
		//fileName이라는 변수에 dao.fileNameCall메서드 실행(id)값을 인자값으로 넘김
		String fileName = dao.fileNameCall(Integer.parseInt(id));
		System.out.println(fileName);
		//글 삭제(DB)
		if(dao.del(id)>0) {
			//파일 삭제(파일이 있을 경우만)
			System.out.println("성공");
			
		}
		System.out.println(dao.delete(delList));
		Gson json = new Gson();
		HashMap<String, Boolean> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
		
	}

	public void todoWrite() throws IOException {
		//1.파라메터 추출
		TodoDTO dto=new TodoDTO();
		request.setCharacterEncoding("UTF-8");
	//	String id = (String) request.getSession().getAttribute("loginId");
		dto.setTodo_content(request.getParameter("content"));
		dto.setMember_id((String) request.getSession().getAttribute("loginId"));
		System.out.println(dto.getTodo_content());
		System.out.println(dto.getMember_id());
		
		//2. DAO 요청
		TodoDAO dao = new TodoDAO();
		int success=dao.write(dto);
		System.out.println(success);
		//3. 결과값 json 변환
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		//4. resposne 로 반환		
		response.setContentType("text/html; charset=UTF-8");//한글깨짐방지
		response.getWriter().println(obj);
	}
	
		
	}


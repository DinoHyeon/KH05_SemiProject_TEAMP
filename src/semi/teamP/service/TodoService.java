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
		//form 방식에서는 상관 없으나 javascript 배열 방식으로 보낼 경우는 뒤에 [] 를 붙여 준다.
		String delcontent = request.getParameterValues("delcontent"); //가져온 delList[]를 변수로 담기
		System.out.println(delcontent);
		//복수개의 데이터를 지우기
		//1.지울 수 만큼 쿼리를 반복
		//2. DELETE FROM bbs2 WHERE idx=?+OR idx=?
		TodoDAO dao=new TodoDAO();
		boolean success = false;
		if(dao.delete(delList) == delList.length) {
			success = true;
			
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


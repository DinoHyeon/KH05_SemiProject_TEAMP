package semi.teamP.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import oracle.net.aso.s;
import semi.teamP.dao.GroupDAO;
import semi.teamP.dao.PlanDAO;
import semi.teamP.dto.BoardDTO;
import semi.teamP.dto.GroupInfoDTO;
import semi.teamP.dto.PlanDTO;

public class PlanService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public PlanService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	public void planlist() throws IOException {
		int groupIdx = 0;
		PlanDAO dao = new PlanDAO();
		//데이터가 담긴 어레이 리스트
		ArrayList<PlanDTO> list = dao.list(groupIdx);//리스트 직접 뽑아 볼 것		
		
		//response 반환
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();		
		map.put("list",list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	   public void planWrite() throws IOException, ServletException {
		      request.setCharacterEncoding("UTF-8");
		      PlanDTO plandto= new PlanDTO();
		      //String groupIdx = (String) request.getSession().getAttribute("groupNum"); //로그인 아이디
		//${sessionScope.groupNum}
		   //   int bbsidx = Integer.parseInt(request.getParameter("cid")); // 게시글 번호 

		      plandto.setGroup_idx(Integer.parseInt(request.getParameter("groupidx")));
		      plandto.setMember_id(request.getParameter("member"));
		      plandto.setPlan_startDay(request.getParameter("StartDay"));
		      plandto.setPlan_endDay(request.getParameter("endDay"));
		      plandto.setPlan_content(request.getParameter("content"));
		      plandto.setPlan_title(request.getParameter("title"));
		      
		      System.out.println("일정 : "+request.getParameter("content"));
		      System.out.println("오잉 : "+Integer.parseInt(request.getParameter("groupidx")));

		     PlanDAO dao = new PlanDAO();
		      int success = dao.planWrite(plandto);

		      String page = "plan.jsp";
		      String msg = "일정생성에 실패했습니다.";
		      System.out.println("일정 : "+success);

		      if(success != 0) {
		      
		         msg = "일정 생성에 성공했습니다.";
		      }
		      
		      Gson json = new Gson();
		      HashMap<String, Object> map = new HashMap<>();
		      request.getSession().setAttribute("success",Integer.toString(success));
		      //      ArrayList<ReplyDTO> list =dao.replylist(bbsidx);

		      map.put("success", success);
		      String obj = json.toJson(map);
		      response.setContentType("text/html; charset=UTF-8");
		      response.getWriter().println(obj);
		      
//		      request.setAttribute("msg", msg);
//		      RequestDispatcher dis = request.getRequestDispatcher(page);
//		      dis.forward(request, response);
		      //int success = dao.createGroup(infoDto);
		      
		   }



	public void planDetail() {
		// TODO Auto-generated method stub
		
	}

	public void planDelete() {
		// TODO Auto-generated method stub
		
	}
	public void planChange() {
		// TODO Auto-generated method stub
		
	}
	
	//WBS형식 테이블 추출
	public void planTableList() throws IOException{
		int groupIdx=(int) request.getSession().getAttribute("groupNum");//해당 그룹 번호 request로 받아야한다. -> 해당 그룹의 프로젝트 시작기간, 종료기간을 받기 위해
		
		GroupDAO Gdao = new GroupDAO();
		GroupInfoDTO Gdto = Gdao.getGroupInfo(groupIdx);//그룹의 정보를 받는다.
		String inputGroupStartDay = Gdto.getGroup_StrartDay();//yyyy-MM-dd
		String inputGroupEndDay = Gdto.getGroup_EndDay();//yyyy-MM-dd
		
		//시작날짜와 종료날짜 사이의 날짜 구하기
		final String DATE_PATTERN = "yyyy-MM-dd";
		SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
		Date DateGroupEndDay = null;
		Date DateGroupStartDay = null;
		try {
			DateGroupStartDay = sdf.parse(inputGroupStartDay);
			DateGroupEndDay = sdf.parse(inputGroupEndDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		ArrayList<String> groupPeriod = new ArrayList<String>();//프로젝트 기간사이에 있는 날짜 출력 'yyyy-MM-dd'
		ArrayList<String> groupPeriodMonth = new ArrayList<String>();//프로젝트 기간사이에 있는 일 출력 'MM'
		ArrayList<String> groupPeriodDay = new ArrayList<String>();//프로젝트 기간사이에 있는 일 출력 'dd'
		Date currentDay = DateGroupStartDay;
		while(currentDay.compareTo(DateGroupEndDay) <= 0) {
			groupPeriod.add(sdf.format(currentDay));
			Calendar c = Calendar.getInstance();
			c.setTime(currentDay);
			c.add(Calendar.DAY_OF_MONTH, 1);
			currentDay = (Date) c.getTime();
		}
		
		//월,일 리스트에 값 넣기
		for(int i=0; i<groupPeriod.size(); i++) {
			groupPeriodMonth.add(groupPeriod.get(i).substring(5, 7));//달
			groupPeriodDay.add(groupPeriod.get(i).substring(8, 10));//일
		}
		
		
		//리스트 불러오기
		PlanDAO dao = new PlanDAO();
		ArrayList<PlanDTO>dto = dao.list(groupIdx);
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("date", groupPeriod);
		map.put("month", groupPeriodMonth);
		map.put("day", groupPeriodDay);
		map.put("planList",dto);
		String obj = json.toJson(map);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}
}

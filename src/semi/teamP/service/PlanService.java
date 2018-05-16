package semi.teamP.service;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import oracle.net.aso.s;
import semi.teamP.dao.GroupDAO;
import semi.teamP.dao.PlanDAO;
import semi.teamP.dao.TodoDAO;
import semi.teamP.dto.BoardDTO;
import semi.teamP.dto.GroupInfoDTO;
import semi.teamP.dto.PlanDTO;
import semi.teamP.dto.TodoDTO;

public class PlanService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	
	public PlanService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	public void planlist() throws IOException {
		PlanDAO dao = new PlanDAO();
		//데이터가 담긴 어레이 리스트
		ArrayList<PlanDTO> list = dao.list();//리스트 직접 뽑아 볼 것		
		
		//response 반환
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();		
		map.put("list",list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

	public void planWrite() throws IOException {
		request.setCharacterEncoding("UTF-8");
		//글쓰기 서비스
		//1.파라메터 추출
		request.setCharacterEncoding("UTF-8");
		int groupIdx =(int) request.getSession().getAttribute("groupNum");
		String userName =request.getParameter("userName");
		String title =request.getParameter("title");
		String sDate=request.getParameter("syear")+request.getParameter("smonth")
		+request.getParameter("sday");
		String eDate =request.getParameter("eyear")+request.getParameter("emonth")
		+request.getParameter("eday");
		String memo = request.getParameter("memo");
		PlanDTO dto = new PlanDTO();
		dto.setMember_id(userName);
		dto.setPlan_title(title);
		dto.setPlan_startDay(sDate);
		dto.setPlan_endDay(eDate);
		dto.setPlan_content(memo);
		System.out.println(groupIdx+"지금 가지고 있는 그룹idx값");
		
		//2.DAO 요청
		PlanDAO dao = new PlanDAO();
		int success = dao.write(dto,groupIdx);
		//3.결과값 json변환
		Gson json = new Gson();
		HashMap<String, Integer> map = new HashMap<>();
		map.put("success", success);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
		
		
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
		int groupIdx=42;//해당 그룹 번호 request로 받아야한다. -> 해당 그룹의 프로젝트 시작기간, 종료기간을 받기 위해
		
		GroupDAO dao = new GroupDAO();
		GroupInfoDTO dto = dao.getGroupInfo(groupIdx);//그룹의 정보를 받는다.
		String inputGroupStartDay = dto.getGroup_StrartDay();//yyyy-MM-dd
		String inputGroupEndDay = dto.getGroup_EndDay();//yyyy-MM-dd
		
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
		
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();
		map.put("date", groupPeriod);
		map.put("month", groupPeriodMonth);
		map.put("day", groupPeriodDay);
		String obj = json.toJson(map);
		response.getWriter().println(obj);
	}
	
	public void planDayList() throws IOException {
		PlanDAO dao=new PlanDAO();
		String date= (String)request.getParameter("date");
		int groupIdx =(int) request.getSession().getAttribute("groupNum");
		System.out.println("선택한 날짜는:"+date);
		//데이터가 담긴 어레이리스트 
		ArrayList<PlanDTO> list= dao.list(date,groupIdx);
		//response 반환
		Gson json = new Gson();
		HashMap<String, Object>map=new HashMap<>();
		request.setAttribute("list", list); 
		map.put("list",list);//리스트 넣고
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");//한글있으니까 깨짐방지
		response.getWriter().println(obj);
		
	}
		
		
	
}

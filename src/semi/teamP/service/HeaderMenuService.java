package semi.teamP.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import semi.teamP.dao.GroupDAO;
import semi.teamP.dao.PlanDAO;
import semi.teamP.dto.GroupInfoDTO;
import semi.teamP.dto.PlanDTO;

public class HeaderMenuService {
	HttpServletRequest request = null;
	HttpServletResponse response = null;
	public HeaderMenuService(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}
	
	//그룹정보 가져오기
	public void getGroupInfo() throws IOException {
		int groupIdx = (int) request.getSession().getAttribute("groupNum");

		//그룹정보
		GroupDAO Gdao = new GroupDAO();
		GroupInfoDTO dto = Gdao.getGroupInfo(groupIdx);
		
		//일정
		PlanDAO Pdao = new PlanDAO();
		ArrayList<PlanDTO> list = Pdao.list(groupIdx);//리스트 직접 뽑아 볼 것		
		
		//response 반환
		Gson json = new Gson();
		HashMap<String, Object> map = new HashMap<>();		
		map.put("groupInfo",dto);
		map.put("planList",list);
		String obj = json.toJson(map);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().println(obj);
	}

}

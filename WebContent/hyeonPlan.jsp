<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<title>Insert title here</title>
	<style>
		table td{
			border:1px solid black;
			border-collapse: collapse;
			text-align: center;
		}
		
		div{
			position: absolute;
			top: 15.9%;
		    width: 78%;
		    height: 80%;
			background-color: white;
	        overflow: auto;
		}
	</style>
</head>
<body>
	<div>
		<table id="1115" style="width:100%;">
		</table>
	</div>
</body>
<script>
	var date = [];
	var day = [];

	var obj = {};
	var content = "";
	
	obj.type="POST";
	obj.dataType="JSON";
	obj.error=function(e){"실패"};	
	$(document).ready(function(){
		
		obj.url="./planTableList";
		obj.data={};
		obj.success=function(data){
			console.log(data);
			var dayNum = 0;
			var DupleMonthNum_key=[];
			var DupleMonthNum_value=[];
			var DupleMonthNum;
			date = data.date;
			day = data.day;
			dayNum = data.day.length;
			DupleMonthNum=DuplicatesChk(data.month);
			
			console.log(DupleMonthNum);
			
			//중복 월(key)과 중복 갯수(value)를 각각 배열에 담음
			$.each(DupleMonthNum, function(key, value){
				DupleMonthNum_key.push(key); 
				DupleMonthNum_value.push(value); 
			});

			
 			/* 테이블 생성 apeend */
 			content += "<tr id='title'>";
			content += "<td  class='plan_title' rowspan='2'>일정</td>";
			content += "<td class='member_id' rowspan='2'>수행자</td>";
			content += "<td class='plan_state' rowspan='2'>상태</td>";
			content += "<td class='plan_startDay' rowspan='2'>시작일</td>";
			content += "<td class='plan_endDay' rowspan='2'>종료일</td>";
			
			for(var i=0; i<DupleMonthNum_key.length; i++){//달 td생성을 위한 for
				content += "<td colspan="+DupleMonthNum_value[i]+">"+DupleMonthNum_key[i]+"</td>";
			}
			content += "</tr>";
			content += "<tr>";
			for(var i=0; i<day.length; i++){
				content += "<td>"+day[i]+"</td>";
			}
			content += "</tr>"; 
			
			data.planList.forEach(function(item,index){
				 content +="<tr class="+item.plan_idx+">";
				 content +="<td class='plan_title' rowspan='2'>"+item.plan_title+"</td>";//일정
				 content +="<td class='member_id' rowspan='2'>"+item.member_id+"</td>";//수행자
				 content +="<td class='plan_state' rowspan='2'>"+item.plan_state+"</td>";//상태
				 content +="<td class='plan_startDay' id="+item.plan_startDay+" rowspan='2'>"+item.plan_startDay+"</td>";//시작일
				 content +="<td class='plan_endDay' id="+item.plan_endDay+" rowspan='2'>"+item.plan_endDay+"</td>";//종료일
				 content +="</tr>";
				 
				for(var i=0; i<day.length; i++){
					content += "<td class="+item.plan_idx+" id="+date[i]+">　</td>";
				}
		      });   
			
			$("#1115").empty();
			$("#1115").append(content);
			
			
			data.planList.forEach(function(item,index){
				var betweenDateArr = betweenDate(item.plan_startDay, item.plan_endDay);
				for(var j=0; j<betweenDateArr.length; j++){
					for(var i=0; i<day.length; i++){
						if($("td[class="+item.plan_idx+"]")[i].id==betweenDateArr[j]){
							$("td[class="+item.plan_idx+"]")[i].style.backgroundColor = 'yellow';
						}
	   				}
					if(item.plan_state=='완료'){
						for(var i=0; i<day.length; i++){
							if($("td[class="+item.plan_idx+"]")[i].id==item.plan_plan_finishDate){
								$("td[class="+item.plan_idx+"]")[i].style.backgroundColor = 'red';
							}
		   				}
					}
				} 

		    });   
			

/* 			$("td[class='9']").each(function(idx){
				console.log($(this)[0].id)
			});
			 */
			
			
			content="";
		} 
		ajaxCall(obj);
	});
	
	
	/* 중복값의 개수를 반환해주는 함수 */
	function DuplicatesChk(arr) {
		var results = {};
		var over = 0;
		for(var i=0; i<arr.length; i++){
			for(var j=0; j<arr.length; j++){
				if(arr[i]==arr[j]){
					over++;
					results[arr[i]]=over;
				}
			}
			over=0;
		}
		return results;
	}
	
	
	//시작 날짜와 종료 날짜 사이에 있는 날짜를 구하여 배열에 담는 함수
	function betweenDate(startDay, endDay){
		var startDayInfo = startDay.split("-");
		var endDayInfo = endDay.split("-");
		var betweenDate = []; //날짜 사이에 있는 값을 저장할 배열
		//시작날짜
		var betweenDay = new Date(startDayInfo[0], startDayInfo[1]-1, startDayInfo[2]);//계산 결과 값을 담을 변수
		
		var startDayDate = new Date(startDayInfo[0], startDayInfo[1]-1, startDayInfo[2]);//시작일 Date
		var endDayDate = new Date(endDayInfo[0], endDayInfo[1]-1, endDayInfo[2]);//종료일 Date
		
		/* 결과 값을 담을 배열에 미리 담아놓을 시작일 */
		var startYear = startDayDate.getFullYear();
		var startMonth = startDayDate.getMonth()+1;
		if(startMonth<10){startMonth = "0" + startMonth};
		var startDate = startDayDate.getDate()
		if(startDate<10){startDate = "0" + startDate};
		betweenDate.push(startYear+"-"+startMonth+"-"+startDate);
		
		/* 시작일과 종료일의 차이 */
		var btMs = endDayDate.getTime() - startDayDate.getTime();
		var btDay = btMs / (1000*60*60*24);
		
		
		/* 시작일과 종료일 사이에 있는 날짜를 구하기 */
		for(var i=0; i<btDay; i++){
			betweenDay.setDate(betweenDay.getDate()+1);
		
			var year = betweenDay.getFullYear();
			var month = betweenDay.getMonth()+1;
			if(month<10){month = "0" + month};
			var date = betweenDay.getDate()
			if(date<10){date = "0" + date};	
			betweenDate.push(year+"-"+month+"-"+date);
		}
		return betweenDate;
	}
	
	/* ajax실행 호출 함수 */
	function ajaxCall(param){
		$.ajax(param);
	}	
</script>
</html>
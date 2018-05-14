<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link href='/TeamP/WebContent/fullcal/fullcalendar.min.css' rel='stylesheet' />
		<link href='/TeamP/WebContent/fullcal/fullcalendar.print.min.css' rel='stylesheet' media='print' /> 
		<script src='/TeamP/WebContent/fullcal/lib/moment.min.js'></script> <script src='../lib/jquery.min.js'></script> 
		<script src='/TeamP/WebContent/fullcal/fullcalendar.min.js'></script>	
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		<style>
		#page{
				position: absolute;
				top: 15.9%;
		        width: 82.5%;
		        height: 84.1%;
				background-color: white;
				}
		/* #writePlan */
			#calendar{
				border: 1px solid black;
				position: absolute;
				top:15%;
				height:35%;
				width: 35%;
				}
		#myPlan{
		        position: absolute;
		        top:50%;
		        height: 50%;
		        width: 49%;
		        /* border : 1px solid black; */
		        
		       }
		#planTable{
				
				/* border : 1px solid black; */
		        top:50%;
		        left:50%;
		        align:center;
		        text-align: center;
		          }
		#planDetail{
					position: absolute;
					/* border:1px solid black; */
					top:16%;
					margin-left:40%;
					height:84%;
					width:30%;
					}
		input[type="text"]{
			width:200px;
		}
		</style>
	</head>
	<body>
		<%@include file="headerMenu.jsp"%>
		<%@include file="sideMenu.jsp"%>
		<div id="calendar">
		<!-- <input type="button" value="글쓰기" onclick = "location.href ='planwrite.jsp'"/> -->
		
		</div> 
		<div id="myPlan">
			<h3>ㅇㅇ님의일정</h3>
        	<table id="listTable">
			<tr>
				<th>일정번호</th>
				<th>수행자</th>
				<th>일정내용</th>
				
			</tr>
			<!-- JSON 내용을 테이블로 출력 -->
		</table>
        </div>
        <div id="planDetail">
        <h4>세부일정</h4>
        <table>
		<tr><td>수행자</td></tr>
		
		<tr><td>시작일</td></tr>
		<tr>
			<td>
				년
				월
				일
			</td>
		</tr>
		<tr><td>마감일</td></tr>
		<tr>
			<td>
				년
				월
				일
			</td>
		</tr>
		<tr><td>메모</td></tr>
		<tr><td><input type="text" id="memo"/></td></tr>
		
		<tr>
		</tr>
		</table>
        </div>
	</body>
	<script>
	$(document).ready(function(){
		var date =new Date();
		var d = date.getDate();
		var m = date.getMonth();
		var y = date.getFullYear();
		
		
	});
	var obj = {};
	obj.error=function(e){console.log(e)};
	obj.type="POST";
	obj.dataType = "JSON";
	
	$(document).ready(function(){
		
		obj.url="/plan";
		obj.success = function(data){
			//console.log(data);
			if(data.list !=null){
				//리스트 보여주기
				listPrint(data.list);
			}else{
				
			}
		}
		ajaxCall(obj);
	});
	$("#calendar").fullCalendar({
		dafaultDate : "2018-05-11"
		,editable : true
		,eventLimit : true
		,events:[
			{
				title:"Long Event"
				,start : "2018-05-08"
				,end : "2018-05-20"
			}
		]
	});
	//일정 리스트 작성메소드
	
	function listPrint(list){
		console.log(list);
		var content ="";
		//plan_idx, member_id, plan_content
		list.forEach(function(item, idx){
			content += "<tr>";
			content +="<td>"+item.plan_idx+"</td>";
			content +="<td>"+item.plan_member_id+"</td>";
			content +="<td>"+item.plan_content+"</td>";
			content += "</tr>";
		});		
		$("#listTable").append(content);
	}
	
	</script>
</html>
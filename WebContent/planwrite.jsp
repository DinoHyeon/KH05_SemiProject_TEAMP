<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
		<link rel="stylesheet" href="/resources/demos/style.css">
		<script>
		  $(function() {
		    $( "#datepicker" ).datepicker();
		  });
		</script>
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
					text-align: center;
					}
		 input[type="text"]{
			height:15px;
			width:200px;
		}
		
		table, th, td{
			border: 1px solid black;
			border-collapse: collapse;
			height: 30px;
		}
		
		</style>
	</head>
	<body>
		<%@include file="headerMenu.jsp"%>
		<%@include file="sideMenu.jsp"%>
		<div id="myPlan">
			<h3>일정</h3>
        	<table id="planTable">
        		<tr>
	        		<th>
	        			test님의 오늘 일정
	        		</th>
	        	</tr>
	        	<tr>
	        		<td>
	        			테이블만들기
	        		</td>
	        	</tr>
        		
        		
        	</table>
        </div>
        <div id="planDetail">
        
        <table>
			<tr>
				<th>수행자</th>
			</tr>
			
			<tr>
				<td><input type="text" id="pickmem"/></td>
			</tr>
			<tr>
				<th>타이틀</th>
			</tr>
			
			<tr>
				<td><input type="text" id="title"/></td>
			</tr>
			<tr><td>시작일</td></tr>
			<tr>
				<td>
					<select id="syear">
						<option></option>
					</select>년
					<select id="smonth">
						<option></option>
					</select>월
					<select id="sday">
						<option></option>
					</select>일
				</td>
			</tr>
			<tr><td>마감일</td></tr>
			<tr>
				<td>
					<select id="eyear">
						<option></option>
					</select>년
					<select id="emonth">
						<option></option>
					</select>월
					<select id="eday">
						<option></option>
					</select>일
				</td>
			</tr>
			<tr><td>메모</td></tr>
			<tr><td><input type="text" id="memo"/></td></tr>
			<tr>
				<td>
					<button id="planMake">일정확정</button>
				</td>
			</tr>
		</table>
        </div>
	</body>
	<script>
		var obj = {};//초기화			
		obj.type="post";
		obj.dataType="json";
		obj.error=function(e){console.log(e)};
	
		
		//글쓰기
		$("#planMake").click(function(){
			obj.url="./planWrite";
			obj.data={};
			//수행자,시작일,마감일,메모
			obj.data.userName= $("#pickmem").val();
			obj.data.title=$("#title").val();
			obj.data.syear = $("#syear").val();
			obj.data.smonth = $("#smonth").val();
			obj.data.sday = $("#sday").val();
			obj.data.eyear = $("#eyear").val();
			obj.data.emonth = $("#emonth").val();
			obj.data.eday = $("#eday").val();
			obj.data.memo = $("#memo").val();
			obj.success = function(data){
				console.log(data);
				if(data.success>0){
					alert("글 쓰기에 성공 하였습니다.");
					location.href = "main_Group.jsp";
				}else{
					alert("글 쓰기에 실패 하였습니다.");
				}
				
			}
			
			ajaxCall(obj);
		})
		$(document).ready(function() {
			var year=1930;
			var month=12;
			var day=31;
			
			//year element 추가
			for(var i=2018; i>=year; i--){
				$("#syear").append("<option value"+i+">"+i+"</option>");
				$("#eyear").append("<option value"+i+">"+i+"</option>");
			}
			//month element 추가
			for(var i=1; i<=month; i++){
				if(i<10){
					i='0'+i;
				}
				$("#smonth").append("<option value"+i+">"+i+"</option>");
				$("#emonth").append("<option value"+i+">"+i+"</option>");
			}
			//day element 추가
			for(var i=1; i<=day; i++){
				if(i<10){
					i='0'+i;
				}
				$("#sday").append("<option value"+i+">"+i+"</option>");
				$("#eday").append("<option value"+i+">"+i+"</option>");
			}
		})
		
		function ajaxCall(param){
		$.ajax(param);
	}
		
	</script>
</html>
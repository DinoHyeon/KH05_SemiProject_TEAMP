<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
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
		#writePlan{
				position: absolute;
				top:30%;
				left:10%;
				height:50%;
				width: 49%;
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
		<div id="writePlan">
		<input type="button" value="글쓰기" onclick = "location.href ='planwrite.jsp'"/>
		
		</div>
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
	var obj = {};
	obj.error=function(e){console.log(e)};
	obj.type="POST";
	obj.dataType = "JSON";
	
	$(document).ready(function(){
		obj.url="./plan";
		obj.success = function(data){
			//console.log(data);
			if(data.login){
				//리스트 보여주기
				listPrint(data.list);
			}else{
				alert("로그인이 필요한 서비스 입니다.");
				location.href="index.html";
			}
		}
		ajaxCall(obj);
	});
	</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<style>
	#createGroup{
		position: absolute;
		display: none;
	}
	
	#bg{
		position: absolute;
		display: none;
		background-color: black;
		opacity: 0.7;
		z-index: 2;
		width: 100%;
		height: 100%;
	}
	
	#pupupContent{
		position: absolute;
		display: none;
		z-index: 3;
		margin-top:10%;
		margin-left:25%;
		width: 800px;
		height: 500px;
		background-color: blue;
		
	}
	
	#close{
		position: absolute;
		margin-left:790px;
	}
	
	table{
		position: absolute;
		left : 37%;
		top : 35%;
		background-color: white;
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	td{
		border: 1px solid black;
		border-collapse: collapse;		
	}
</style>
</head>
<body>
	<div id="bg">
	</div>
	<div id="pupupContent">
		<input id="close" onclick="colse()" type="button" value="닫기">
		<table>
			<tr>
				<td>그룹장</td>
				<td>${sessionScope.loginId}</td>
			</tr>
			<tr>
				<td>그룹명</td>
				<td><input type="text"/></td>
			</tr>
			<tr>
				<td>시작일</td>
				<td><input type="date"/></td>
			</tr>
			<tr>
				<td>종료일</td>
				<td><input type="date"/></td>
			</tr>	
		</table>
		<input type="button" value="생성완료">
	</div>
	<input id="createGroup" type="button" value="그룹생성">

</body>
<script>
	var obj = {};		
	obj.type="post";
	obj.dataType="json";
	obj.error=function(e){console.log(e)};
	
	//페이지가 로드되었을 때 session에 그룹번호가 없는 경우 화면을 다르게 보여줘야한다.
	$(document).ready(function() {
		//이건 ajax로 처리
		if('${sessionScope.loginId}'==""){
			alert("로그인이 필요한 서비스입니다.");
			location.href="index.jsp";
		}
		//세션에 저장되어 있는 groupNum이 0이라면(*0은 현재 가입되어 있는 그룹이 없는 것을 의미)
		if('${sessionScope.groupNum}'==0){
			//button의 css속성 값을 변경
			$("input[type='button']").css("display","inline");
		}
	})
	
	$("#createGroup").click(function() {
		$("#bg").css("display","inline");
		$("#pupupContent").css("display","inline");
	})
	
	function colse() {
		$("#bg").css("display","none");
		$("#pupupContent").css("display","none");
		}
</script>
</html>
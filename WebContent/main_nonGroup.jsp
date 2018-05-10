<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	/* 페이지 영역을 잡기 위한 css 설정입니다. */
    #page{
       position: absolute;
		top: 15.9%;
	   width: 82.5%;
	    height: 84.1%;
		background-color: white;
   	}
   	
   	/* 팝업페이지가 나왔을 때 전체페이지를 검은색으로 한번 덮는다. */
	#bg{
		position: absolute;
		display: none;
		background-color: black;
		opacity: 0.7;
		z-index: 2;
		width: 100%;
		height: 100%;
	}
	
	/* 팝업 내용 */
	#popupContent{
		position: absolute;
	    display: none;
	    z-index: 3;
	    top: 20%;
	    left: 18%;
	    width: 60%;
	    height: 60%;
	    background-color: #004C63;
	}
	
	#close{
		position: absolute;
		font-size: 18px;
		font-weight: 900;
		color: white;
		left: 97%;
		top: 2%;
		display: none;
	}
	
	table td{
		border: 1px solid white;
	}
</style>
</head>
<body>

	<div id="bg">

	</div>
	<div id="popupContent">
			<div id="close">X</div>
			<h1 style="color:#FFD724">그룹 생성</h1>
			<form action="./groupCreate" method="post">
				<table>
					<tr>
						<input name="groupHeadName" type="hidden" value= ${sessionScope.loginId}>
						<td>그룹장 : ${sessionScope.loginId}</td>
					</tr>
					<tr>
						<td>그룹명</td>
					</tr>
					<tr>
						<td><input name="groupName" type="text"/></td>
					</tr>
					<tr>
						<td>프로젝트 기간 - 시작</td>
					</tr>								
					<tr>
						<td><input name="startDate" type="date"/></td>
					</tr>
				<tr>
						<td>프로젝트 기간 - 종료</td>
					</tr>								
					<tr>
						<td><input name="endDate" type="date"/></td>
					</tr>		
					<tr>
						<td><input id="createBnt" type="button" value="그룹 생성"></td>
					</tr>						
				</table>
			</form>
	</div>
	
	<%@include file="headerMenu.jsp"%>
	<%@include file="sideMenu.jsp"%>
    <div id="page">
		<h1>현재 가입되어 있는 그룹이 없습니다 :(</h1>
		<div id="create">그룹 생성</div>
		<div id="invite">그룹 초대</div>
    </div>
</body>
<script>
	$("#create").click(function() {
		$("#bg").css("display","inline");
		$("#close").css("display","inline");
		$("#popupContent").css("display","inline");
	})
	
	$("#close").click(function() {
		$("#bg").css("display","none");
		$("#popupContent").css("display","none");
		$("#close").css("display","none");
	})
	
	$("#createBnt").click(function() {
		var startDay = new Date($("input[name='startDate']").val());
		var endDay = new Date($("input[name='endDate']").val());
		/* 
		1. 프로젝트 명이 입력되어 있지 않은 경우
		2. 프로젝트 기간(시작, 종료)일이 입력되어 있지 않은 경우
		3. 프로젝트 기간이 안맞는 경우
		
		1,2,3의 경우가 아니라면 아이디 submit의 type을 submit으로 변경한다
		*/
		if($("input[name='groupName']").val()==""){
			alert("그룹명을 입력해주세요.")
			$("input[name='groupName']").focus();
		}else if($("input[name='startDate']").val()==""){
			alert("프로젝트 시작일을 입력해주세요.")
			$("input[name='startDate']").focus();			
		}else if($("input[name='endDate']").val()==""){
			alert("프로젝트 종료일을 입력해주세요.")
			$("input[name='endDate']").focus();			
		}else if(startDay>endDay){
			alert("프로젝트 시작일을 재입력해주세요.")
			$("input[name='startDate']").focus();		
		}else{
			$("#createBnt").attr("type","submit");
		}
	})
</script>
</html>
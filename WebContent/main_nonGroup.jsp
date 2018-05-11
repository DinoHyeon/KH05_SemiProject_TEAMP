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
		z-index: 3;
		width: 100%;
		height: 100%;
	}
	
	/* 팝업 내용 */
	#popupContent{
		position: absolute;
	    display: none;
	    z-index: 3;
	    top: 13%;
	    left: 18%;
	    width: 60%;
	    height: 75%;
	    background-color: #004C63;
	}
	
	/* 그룹 초대 팝업 */
	#inviteListPopup{
		position: absolute;
	    display: none;
	    z-index: 3;
	    top: 13%;
	    left: 18%;
	    width: 60%;
	    height: 75%;
	    background-color: #004C63;
	}
	
	.mainPopupClose{
		position: absolute;
		font-size: 18px;
		font-weight: 900;
		color: white;
		left: 97%;
		top: 2%;
		display: inline;
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
			<div class="mainPopupClose">X</div>
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
	
	
			
	<div id="inviteListPopup">
		<h1 style="color:#FFD724">그룹 초대</h1>
		<div class="mainPopupClose">X</div>
		<table id="inviteList">
			<tr>
				<td>그룹명</td>
				<td>그룹장</td>
				<td>내용</td>
				<td>날짜</td>
				<td></td>
			</tr>
		</table>
	</div>
		
		
	<%@include file="headerMenu.jsp"%>
	<%@include file="sideMenu.jsp"%>
    <div id="page">
		<h1>현재 가입되어 있는 그룹이 없습니다 :(</h1>
		<div id="create">그룹 생성</div>
		<div id="inviteListBtn">그룹 초대</div>
    </div>
</body>
<script>
	var obj = {};
	var idx;//idex값을 저장할 전역 변수
	obj.type="POST";
	obj.dataType="JSON";
	obj.error=function(e){console.log(e)};


	$("#create").click(function() {
		$("#bg").css("display","inline");
		$("#popupContent").css("display","inline");
	})
	
	$(".mainPopupClose").click(function() {
		$("#bg").css("display","none");
		$("#inviteListPopup").css("display","none");
		$("#popupContent").css("display","none");
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
	
	//그룹 초대 확인
	$("#inviteListBtn").click(function() {
		//오늘
		$("#bg").css("display","inline");
		$("#inviteListPopup").css("display","inline");
		
		//ajax 실행
		obj.url="./groupInviteList";
		obj.data={};
		obj.success = function(data) {
			 //inviteList 테이블 아이디
		}
		ajaxCall(obj);
	})
	
	
	function ajaxCall(param){
		console.log(param);
		$.ajax(param);
	}
</script>
</html>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
   	
   	table, td {
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	td{
		padding: 10px;
	}
</style>
</head>

<body>
	<%@include file="headerMenu.jsp"%>
	<%@include file="sideMenu.jsp"%>
	
    <div id="page">
		<table>
			<tr>
				<td>이름</td>
				<td>${dto.member_name}</td>
			</tr>
			<tr>
				<td>아이디</td>
				<td>${dto.member_Id}</td>
			</tr>			
			<tr>
				<td>생년월일</td>
				<td><span id="memberBitrh"></span></td>
			</tr>			
			<tr>
				<td>이메일</td>
				<td>
					<input id="memberEamil" onkeyup="pushEmail()" type="eamil" value=${dto.member_email}><div id="emailOverlay">중복체크</div><span id="emailOverlayMsg">
				</span></td>
			</tr>			
			<tr>
				<td>휴대폰 번호</td>
				<td><input id="memberPhone" type="text" value=${dto.member_phone}></td>
			</tr>							
			<tr>
				<td>비밀번호 변경</td>
				<td>
					<input id="memberPass" type="password" onkeyup="passChk()"/><span id="PwChkMsg"></span>
				</td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td>
					<input id="memberPassChk" type="password" onkeyup="passChk()"/><span id="PwChkMsg"></span>
				</td>
			</tr>
		</table>
		<div id="changInfo">회원 정보 수정</div>
    </div>
</body>

<script>
	var obj = {};
	obj.error=function(e){console.log(e)};
	obj.type="post";
	obj.dataType="json";
	
	//이메일 패스워드 확인 변수
	var emailChk = false;
	var pwChk = false;
	
	$(document).ready(function(){
		/* 생일 출력 */
		birth='${dto.member_birth}';
		var year = birth.substring(0,4);
		var month = birth.substring(4,6);
		var day = birth.substring(6,8);
		$("#memberBitrh").html(year+"년 "+month+"월"+day+"일");
	});

	//비빌번호 일치 여부 확인
	function passChk(){
	    if($("#memberPassChk").val()==$("#memberPass").val()){
	        $("#PwChkMsg").html("일치");
	        $("#PwChkMsg").css("color","green");
	        pwChk=true;
	    }else{
	    	 $("#PwChkMsg").html("불일치");
				$("#PwChkMsg").css("color","red");
				pwChk=false;
	    }
	}
	
	//이메일 중복검사 클릭시 실행되는 함수
	$("#emailOverlay").click(function() {
		//이메일 미입력인 경우
		if($("#memberEamil").val()==""){
			$("#emailOverlayMsg").html("미입력");
			$("#emailOverlayMsg").css("color","red");
			emailChk=false;
		}else if($("#memberEamil").val()=='${dto.member_email}'){//이메일을 수정하지 않은경우
			$("#emailOverlayMsg").html("기존 사용 이메일");
			$("#emailOverlayMsg").css("color","green");
			emailChk=true;
		}else{
			obj.url="./emailOverlay";
			obj.data={email:$("#memberEamil").val()};
			obj.success=function(d){
			if(d.emailChk ==true){
				$("#emailOverlayMsg").html("사용 불가능");
				$("#emailOverlayMsg").css("color","red");
				$("#email").val("");
				emailChk=false;
			}else{
				$("#emailOverlayMsg").html("사용 가능");
				$("#emailOverlayMsg").css("color","green");
				emailChk=true;
			}
		};
			ajaxCall(obj);
		}
	})
	
	
	//회원 수정 버튼 클릭
	$("#changInfo").click(function(){
		if($("#memberPassChk").val()=="" && $("#memberPass").val()==""){
	    	pwChk=true;
	    };
	    
		if(!pwChk){//비밀번호 체크는 비밀번호,비밀번호 확인에 입력한 값이 같거나 공백으로 있을 경우에 true이다.
			alert("비밀번호가 일치하지 않습니다.")
			$("#memberPass").focus();
		}else if($("#phone").val() == ""){
			alert("변경하실 휴대폰 번호를 입력해주세요.")
			$("#memberPhone").focus();
		}else if($("#email").val() == ""){
			alert("이메일 주소를 입력해주세요.")
			$("#memberEmail").focus();
		}else if(!emailChk){
			alert("이메일 주소 중복확인을 해주세요.")
			$("#memberEmail").focus();
		}else{
			obj.url="./infoUpdate";
			obj.data={};
			obj.data.phone=$("#memberPhone").val();
			obj.data.email=$("#memberEamil").val();
			obj.data.pw=$("#memberPass").val();

			obj.success=function(data){
				if(data.success==1){
					alert("정보수정이 정상적으로 처리되었습니다.");
					location.href="main.jsp";
				}else{
					alert("정보수정을 정상적으로 처리하지 못했습니다.");
				}
			}
			console.log(obj);
			ajaxCall(obj);
		}
	})
	
	/* ajax 호출 함수 */
	function ajaxCall(param){
		$.ajax(param);
	}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<form action="./ChangePw" method="post"">
	<table>
		<input type="hidden" name="userId" value="${msg}"/>
		<tr><td>비밀번호</td></tr>
		<tr><td><input type="password" name="changePw" id="userPw"/></td></tr>
		<tr><td>비밀번호 확인</td></tr>
		<tr><td><input type="password" id="userPwChk" onkeyup="chk()"/><span id="userPwChkMsg"></span></td></tr>
		<tr><td><input id="changPw" type="button" value="비밀번호 변경"/></td></tr>
	</table>
</form>
</body>
<script>
	var pwChk = false;

	//비밀번호 일치 확인
	function chk(){
	    if($("#userPw").val()==$("#userPwChk").val()){
	        $("#userPwChkMsg").html("비밀번호가 일치합니다.");
	        $("#userPwChkMsg").css("color","green");
	        pwChk=true;
	    }else{
	        $("#userPwChkMsg").html("비밀번호가 일치하지않습니다..");
			$("#userPwChkMsg").css("color","red");
			pwChk=false;
	    }
	}
	
	$("#changPw").click(function(){
		if(!pwChk){
			alert("올바른 비밀번호를 입력해주세요.");
		}else{
			$("#changPw").attr("type","submit");
		}
    });
</script>
</html>
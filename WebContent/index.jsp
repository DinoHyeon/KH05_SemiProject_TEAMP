<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style>
	table,td{
		border: 1px solid black;
		border-collapse: collapse;
	}
	
	input{
		border-width: 0px;
	}
</style>
</head>
<body>
	<button onclick="location.href='join.jsp'">회원가입</button>
	TeamP
	<table>
		<tr><td>아이디</td></tr>
		<tr><td><input type="text" id="userId"/></td></tr>
		<tr><td>비밀번호</td></tr>
		<tr><td><input type="password" id="userPw"/></td></tr>
		<tr><td><button id="login">로그인</button></td></tr>
	</table>
	<button onclick="location.href='findInfo.jsp'">아이디/비밀번호 찾기</button>
</body>
<script>
	$("#login").click(function() {
		$.ajax({
			type:"post",
			url:"./login",
			data:{
				id:$("#userId").val(),
				pw:$("#userPw").val().toLowerCase()
			},
			dataType:"json",
			success:function(data){//인자 값은 서버에서 주는 메세지
				if(data.login){
					alert("로그인에 성공 했습니다.")
					if(data.projectIdx>0){
						location.href="main_Group.jsp"
					}else{
						location.href="main_nonGroup.jsp"
					}
				}else{
					alert("로그인에 실패 했습니다.")
				}
			},
			error:function(err){//인자 값은 서버에서 주는 메세지
				console.log(err)
			}
		});
	});
	
	var msg = "${msg}"
	if(msg!=""){
		alert(msg);
	}
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
</style>
</head>
<body>
	<%@include file="headerMenu.jsp"%>
	<%@include file="sideMenu.jsp"%>
    <div id="page">
    	<form action="./memberDataAccess" method="post">
    		<h1>${sessionScope.loginId}님 비밀번호를 입력해주세요.</h1>
			<table>
				<tr>
					<td>현재 비밀번호</td>
				</tr>
				<tr>
					<td><input type="password" name="memberPass"></td>
				</tr>
				<tr>
					<td><input type="submit" value="입력"></td>
				</tr>
			</table>
		</form>
    </div>
</body>
<script>
	var msg = '${msg}';
	
	if(msg!=""){
		alert(msg);
		location.href="memberInfoAccess.jsp"
	}
	
</script>
</html>
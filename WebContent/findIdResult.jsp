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
	<h1>회원님의 아이디는 ${msg}입니다.</h1>
	<button onclick="location.href='index.jsp'">로그인</button>
	<button onclick="location.href='findInfo.jsp'">비밀번호 재설정</button>
</body>
</html>
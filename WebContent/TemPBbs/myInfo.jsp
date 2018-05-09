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
	
	#myinfo{
		position: absolute;
		left: 41%;
		top: 2%;
	}
	
	table, td{
		border: none;
		border-collapse: collapse;
	}
	
	td{
		padding: 15px 17px;
	}
	
	input{
		width: 210px;
		height: 50%;
	}
	
	h1{
		position: absolute;
		top: -15%;
		left: 50%;
	}
</style>
</head>
<body>
	<div id="page">
		<h1>내 정보</h1>
		<div id="myinfo">
			<table>
				<tr>
					<td>이름</td>
					<td>박현정</td>
				</tr>
				<tr>
					<td>아이디</td>
					<td>test01</td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password"/></td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td><input type="password"/></td>
				</tr>				
				<tr>
					<td>생년월일</td>
					<td>박현정</td>
				</tr>			
				<tr>
					<td>이메일</td>
					<td><input type="text"/></td>
				</tr>			
				<tr>
					<td>휴대폰 번호</td>
					<td><input type="text"/></td>
				</tr>							
			</table>
		</div>
	</div>
</body>
</html>
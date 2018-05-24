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
   	
   	table,th,td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}
	table{
		width: 500px;
	}
	input[type='text']{
		width: 100%;
	}
	textarea{
		width: 100%;
		resize: none;
	}
	td{
		text-align: center;
	}
	#tel{
  	 	border: 1px solid black;
   		border-collapse: collapse;
   		padding: 10 5;
   		text-align: center;
   		margin-top: 60px;
   		margin-left: 50px;
   		width: 95%;
   		height: 50%;
   	}
     	
   	h2{
   		margin-left: 600px;
   	}
</style>
</head>
<body>
	<%@include file="../headerMenu.jsp"%>
	<%@include file="../sideMenu.jsp"%>
	
	<!--
	updateForm.jsp 
	수정 공용 페이지
	-->
	
    <div id="page">
		<form action="update" method="get">
		<table id="tel">
			<tr>
				<th width="10%">작성자</th>
			<td>
				${sessionScope.loginId}
				<input type ="hidden" name="idx" value="${dto.bbs_idx}"/>
			</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type ="text" name="bbs_subject" value="${dto.bbs_subject}"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td height="400px"><textarea rows="20" name="bbs_content" >${dto.bbs_content}</textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="./detail?idx=${dto.bbs_idx}&pageNo=${sessionScope.pageNo}">취소</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<button>저장</button>
				</td>
			</tr>
		</table>
	</form>
    </div>
</body>
<script>
</script>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
   	table{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
		width: 500px;
		
	}
	th{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
		width: 100px;
	}
	td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
		width: 400px;		
	}
  
	#tab{
   		margin-left: 450px;
   		margin-top: 30px;
   	}
   	#hie{
   		height: 300px;
   	}
   	h2{
   		margin-left: 600px;
   	}
	
</style>
</head>
<body>
	<%@include file="../headerMenu.jsp"%>
	<%@include file="../sideMenu.jsp"%>
    <div id="page">  
			
			<h2>${info.bbs_subject}</h2>
	
		<table id="tab">
		<tr>
			<th>작성자</th>
			<td>${info.member_id}</td>
		</tr>	
		
		<c:if test="${info.newFileName != null}">
		<tr>
			<th>첨부파일 </th>
			<td><img src="./upload/${info.newFileName}" width="500"/><a href = "./fileDownLoad?idx=${info.bbs_idx}">다운로드</a></td>
		</tr>
		</c:if>
			
		<tr>
			<th>내용</th>
			<td id="hie">${info.bbs_content}</td>
		</tr>		
		
		<tr>
			<td colspan="2">
				<a href="./fileList">리스트가기</a>
				&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${sessionScope.loginId == info.member_id}">
					<a href="./fileUpdateForm?idx=${info.bbs_idx}">수정</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				
				<c:if test="${sessionScope.loginId == info.member_id || sessionScope.loginId == 'admin' }">
					<a href="./fileDelete?idx=${info.bbs_idx}">삭제</a>
				</c:if>	
			</td>
		</tr>
	</table>
    </div>
</body>
<script>
</script>
</html>
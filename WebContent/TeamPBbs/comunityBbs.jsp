<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
   	table,td,th{
   		border: 1px solid black;
   		border-collapse: collapse;
   		padding: 10 5;
   		text-align: center;
   	}
</style>
</head>
<body>
	<%@include file="../headerMenu.jsp"%>
	<%@include file="../sideMenu.jsp"%>
	
	<!--
	comunityBbs.jsp 
	의견나눔게시판 글의 리스트를 불러오는 페이지
	-->
	
    <div id="page">
		<table>
			<tr>
				<th>번호</th>
				<th>게시판구분</th>
				<th>제목</th>
				<th>작성자</th>
				<th>날짜</th>
				<th>조회수</th>
			</tr>
			
			<!-- 셋팅된 dto값을 테이블에 뿌려준다 -->
			<c:forEach items="${list}" var="bbs">
				<tr>
					<td>${bbs.bbs_idx}</td>
					<td>${bbs.bbs_name}</td>
					<td><a href="detail?idx=${bbs.bbs_idx}">${bbs.bbs_subject }</a></td>
					<td>${bbs.member_id }</td>
					<td>${bbs.bbs_date }</td>
					<td>${bbs.bbs_bHit }</td>
				</tr>
			</c:forEach>
		</table>
		
		<!-- 관리자는 의견나눔게시판에 글을 쓸 이유가 없어서 아이디가 'admin' 일시 버튼을 막아놓음 -->
		<c:if test="${sessionScope.loginId != 'admin'}">
			<button onclick="location.href = 'TeamPBbs/writeForm.jsp'">글쓰기</button>
		</c:if>
		
    </div>
</body>
<script>

</script>
</html>
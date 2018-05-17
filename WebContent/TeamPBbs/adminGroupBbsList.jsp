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
	adminGroupBbsList.jsp 
	관리자(admin) 로그인 시 모든 그룹의 글 보기 및 삭제 가능하게 하는 기능
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
		
		<form action="./adminGroupBbsList" method="get">
			<table>
				<tr>
					<td>
						<select name ="keyField">
							<!-- DB컬럼값과 동일한 value를 주어 keyField를 구분 -->
							<option value="member_id">이 름</option>
							<option value="bbs_subject">제 목</option>
							<option value="bbs_content">내 용</option>
						</select>
						<input type="text" name="keyWord"/>
						<input type="submit" value="찾기"/>  
					</td>
				</tr>
			</table>
		</form>
	
    </div>
</body>
<script>
</script>
</html>
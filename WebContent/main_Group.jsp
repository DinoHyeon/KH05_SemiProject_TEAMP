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
		<!-- 이 영역에 페이지 코드 작성하시면 됩니다 :) -->
    </div>
</body>
<script>
	//그룹 삭제 *그룹관리가 있는 페이지에는 모두 입력해야합니다.
	$("#groupDel").click(function() {
		//그룹 삭제 함수 호출
		groupDel();
	});
</script>
</html>
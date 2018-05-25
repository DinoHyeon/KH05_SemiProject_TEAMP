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
    /* #tel{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}  */
     #tel th{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	} 
    
     #tel td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}
	#tel{
		width: 500px;
	}
	input[type='text']{
		width: 100%;
	}
	textarea{
		width: 100%;
		resize: none;
	}
	#tel td{
		text-align: center;
	}
	#sessionId{
		border: none;
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
     	
   	#j{
   		margin-left: 600px;
   	}
   	
</style>
</head>
<body>
	<%@include file="../headerMenu.jsp"%>
	<%@include file="../sideMenu.jsp"%>

	<!--
	gmWriteForm.jsp 
	그룹장만 글을 작성 할 수 있는 페이지
	각 그룹들은 자신의 그룹의 글만 볼 수 있다.
	-->
	
    <div id="page">
    <h2 id="j">글쓰기</h2>
    	<!-- /groupWrite 컨트롤러에서 처리 -->
		<form action="../groupWrite" method="get">
		<!-- Bbs 테이블에 bbs_name 값을 groupBbs 로 추가  -->
		<input type="hidden" name="bbs_name" value="groupBbs"/>
		<input type = "hidden" name="pageNo" value="${sessionScope.pageNo}"/>
		<table id="tel">
			<tr>
				<th width="10%">작성자</th>
				<td><input id="sessionId" type ="text" value="${sessionScope.loginId}" readonly="readonly" /></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type ="text" name="bbs_subject"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td height="400px"><textarea rows="20" name="bbs_content" ></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
					<a href="../groupList">리스트가기</a>		
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
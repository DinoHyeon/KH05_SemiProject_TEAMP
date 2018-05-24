<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		width: 10%;
	}
	td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
		width: 450px;		
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
     	
   	h2{
   		margin-left: 600px;
   	}
</style>
</head>
<body>
	
	<%@include file="../headerMenu.jsp"%>
	<%@include file="../sideMenu.jsp"%>
	
	<!-- 
		writeForm.jsp
		그룹에 가입되어 있지 않는 회원이 글을 작성 하는 경우 
		(그룹에 가입되어있지않은 회원 : 관리자 아님, 그룹장일수가 없기때문에 의견나눔게시판에만 글 등록이 가능해야함) 	
		 
		 그룹에 가입되어 있는 회원이 글을 작성하는 경우 
		 (그룹에 가입되어있는 회원 : 관리자 아님, 그룹장일수가 있으므로 의견나눔게시판, 그룹게시판에 글 등록이 모두가능해야함)
	--> 
	
    <div id="page">
    <h2>글 쓰기</h2>
    	<!-- 그룹번호 세션값이 groupNum (로그인시 디폴트값:0) 이 0 일때  == 그룹에 가입되어있지 않으면 -->
    	<c:if test="${groupNum == 0}">
    		<!-- /write 컨트롤러 에서 처리 -->
			<form action="../write" method="get">
			<input type = "hidden" name="pageNo" value="${sessionScope.pageNo}"/>
			<!-- 세션아이디가 admin 이 아닐때  == 의견나눔게시판 말고는 작성할 곳이 없으므로 freeBbs를 hidden 타입으로 보냄 -->
			<c:if test="${sessionScope.memberLv != 'admin' }">
				<input type="hidden" name="bbs_name" value="freeBbs"/>
			</c:if>
			
			<!-- 세션아이디가 admin 일떼 == 공지사항 말고는 작성할 곳이 없으므로 adminBbs를 hidden 타입으로 보냄 -->
			<c:if test="${sessionScope.memberLv == 'admin'}">
				<input type="hidden" name="bbs_name" value = "adminBbs"/>
			</c:if>
			
			<table id="tel">
				<tr>
					<th width="10%">작성자</th>
					<td><input id="sessionId" type ="text" value="${sessionScope.loginId}" readonly="readonly" /></td>
				</tr>
				<tr>
					<th width="10%">제목</th>
					<td><input type ="text" name="bbs_subject"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td height="400px"><textarea rows="20" name="bbs_content" ></textarea></td>
				</tr>
				<tr>
					<td colspan="2">
						<!-- admin 일시 공지사항게시판에 글을 작성한 것이므로 adminList 로 복귀 -->
						<c:if test="${sessionScope.memberLv == 'admin'}">
							<a href="../adminList?pageNo=${sessionScope.pageNo}">리스트가기</a>
						</c:if>
						<!-- admin이 아닐시 의견나눔게시판에 글을 작성한 것이므로 comunityList로 복귀 -->
						<c:if test="${sessionScope.memberLv != 'admin'}">
							<a href="../comunityList?pageNo=${sessionScope.pageNo}">리스트가기</a>
						</c:if>		
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button>저장</button>		
					</td>
				</tr>
			</table>
		</form>
	</c:if>
	
	<!-- 그룹번호 세션값이 groupNum (로그인시 디폴트값:0) 이 0이 아닐때  == 그룹에 가입되어 있으면 -->
	<c:if test="${groupNum != 0}">
			<!-- /groupWrite 컨트롤러에서 처리 -->
			<form action="../groupWrite" method="get">
			<input type = "hidden" name="pageNo" value="${sessionScope.pageNo}"/>
			
			<c:if test="${sessionScope.memberLv != 'admin' }">
				<input type="hidden" name="bbs_name" value="freeBbs"/>
			</c:if>
			
			<c:if test="${sessionScope.memberLv == 'admin'}">
				<input type="hidden" name="bbs_name" value = "adminBbs"/>
			</c:if>
			
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
						<c:if test="${sessionScope.memberLv == 'admin'}">
							<a href="../adminList?pageNo=${sessionScope.pageNo}">리스트가기</a>
						</c:if>
						<c:if test="${sessionScope.memberLv != 'admin'}">
							<a href="../comunityList?pageNo=${sessionScope.pageNo}">리스트가기</a>
						</c:if>		
							&nbsp;&nbsp;&nbsp;&nbsp;
							<button>저장</button>		
					</td>
				</tr>
			</table>
		</form>
	</c:if>
	
    </div>
</body>
<script>
</script>
</html>
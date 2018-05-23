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
   	#tab{
   		margin-left: 550px;
   		margin-top: 20px;
   	}
   	#btn{
   		margin-left: 825px;
   		margin-top: -20px;
   	}
   	
  
   	
   	#w{
   		margin-left: 600px;
   	}
   	#aa{
  	 	margin-left: 10px;  	 	
   	}
   	#btnno{
   		margin-left: 580px;
   		margin-top: 20px;
   	}
   	#b{
   		color: #FFD724;
   	}
   	#c:hover{   	
		background-color: #F6F6F6;
		/* #566A70 */
	}
	#d{
		color: black;
	}
	/*링크가 걸린 상황*/
    #d:link{
        text-decoration: none;
        color: black;
    }
    /*마우스 오버 상태*/
    #d:hover{
        text-decoration: underline;
        color: blue;
    }
    /*링크 눌렀을 때*/
    #d:active{
        text-decoration: overline;
        color:  green;
    }
    /*방문 후 */
    #d:visited{
        text-decoration: none;
        color: gray;
    }
	#f{
		border: 1px solid #E7E7E7;
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
    <c:if test="${sessionScope.loginId != 'admin' }">
   		 <h2 id="w">의견 나눔 게시판</h2>
   	 </c:if>
   	 <c:if test="${sessionScope.loginId == 'admin' }">
   		 <h2 id="w">관리자 의견 나눔 게시판</h2>
   	 </c:if>
		<table id="tel">		
			<tr bgcolor="#004D65">		
				
				<th valign="top"><a id="b">제목</a></th>
				<th valign="top" width="10%"><a id="b">작성자</a></th>
				<th valign="top" width="10%"><a id="b">날짜</a></th>
				<th valign="top" width="10%"><a id="b">조회수</a></th>
			</tr>
			
			<!-- 셋팅된 dto값을 테이블에 뿌려준다 -->
			<c:forEach items="${list}" var="bbs">
				<tr id="c">				
				
					<td id="f" valign="top" align="left"><a id="d" href="detail?idx=${bbs.bbs_idx}&pageNo=${paging.pageNo}">${bbs.bbs_subject } (${bbs.reply_cnt})</a></td>
					<td id="f" valign="top">${bbs.member_id }</td>
					<td id="f" valign="top">${bbs.bbs_date }</td>
					<td id="f" valign="top">${bbs.bbs_bHit }</td>
				</tr>
			</c:forEach>
		</table>
		
		<jsp:include page="paging.jsp" flush="true">
		    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
		    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
		    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
		    <jsp:param name="pageNo" value="${paging.pageNo}" />
		    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
		    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
		    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
		</jsp:include>

		
		<!-- 관리자는 의견나눔게시판에 글을 쓸 이유가 없어서 아이디가 'admin' 일시 버튼을 막아놓음 -->
		<c:if test="${sessionScope.loginId != 'admin'}">
			<button id="btn"  onclick="location.href = 'TeamPBbs/writeForm.jsp'">글쓰기</button>
		</c:if>
		
		<!-- 게시판 검색 폼 -->
		<form action="./comunityList" method="get">
			<table id="tab">
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Team P ::그룹 게시판</title>
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
   		margin-top: 5%;
   		margin-left: 3%;
   		width: 95%;
   		height: 10%;
   	}
   	#tab{
   		margin-left: 43%;   
   		margin-top: -2%;	
   	}
   	#btn{
   		margin-left: 70%;
   		color: #FFD724;
        background-color: #004C63;   
        border-radius: 8px;		
   	}
	#btn:hover{
		cursor: pointer;
		background-color: #FFD724;
        color: #004C63; 
	}  	
   	#w{
   		margin-left: 45%;
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
	groupBbs.jsp 
	그룹별로 그룹게시글을 볼 수 있는 페이지
	-->
	
    <div id="page">
    <h2 id="w">그룹 게시판</h2>
		<table id="tel">
			<tr bgcolor="#004D65">				
				<th valign="top" height="10%"><a id="b">제목</a></th>
				<th valign="top" width="10%"><a id="b">작성자</a></th>
				<th valign="top" width="10%"><a id="b">날짜</a></th>
				<th valign="top" width="10%"><a id="b">조회수</a></th>
			</tr>
			<c:forEach items="${list}" var="bbs">
				<tr id="c">					
					<td id="f" valign="top" align="left"><a id="d"  href="detail?idx=${bbs.bbs_idx}&pageNo=${paging.pageNo}">${bbs.bbs_subject }(${bbs.reply_cnt})</a></td>
					<td id="f" valign="top">${bbs.member_id }</td>
					<td id="f" valign="top">${bbs.bbs_date }</td>
					<td id="f" valign="top">${bbs.bbs_bHit }</td>
				</tr>
			</c:forEach>
		</table>
		
		<jsp:include page="paging/groupPaging.jsp" flush="true">
		    <jsp:param name="firstPageNo" value="${paging.firstPageNo}" />
		    <jsp:param name="prevPageNo" value="${paging.prevPageNo}" />
		    <jsp:param name="startPageNo" value="${paging.startPageNo}" />
		    <jsp:param name="pageNo" value="${paging.pageNo}" />
		    <jsp:param name="endPageNo" value="${paging.endPageNo}" />
		    <jsp:param name="nextPageNo" value="${paging.nextPageNo}" />
		    <jsp:param name="finalPageNo" value="${paging.finalPageNo}" />
		</jsp:include>
		
		<!--
		 그룹을 생성하는순간 그룹장이 되고 memberLv 세션값이 master가 됨
		그룹장만 글을 작성할수 있으므로 마스터 일때만 버튼을 보여주면 됨 
		-->
		<c:if test="${sessionScope.memberLv == 'master'}">
			<button id="btn" onclick="location.href = 'TeamPBbs/gmWriteForm.jsp'">글쓰기</button>
		</c:if>
		<c:if test="${sessionScope.memberLv != 'master'}">
			<br/><br/>
		</c:if>
		
		<form action="./groupList" method="get">
			<table id="tab">
				<tr>
					<td>
						<select name ="keyField">
							<!-- DB컬럼값과 동일한 value를 주어 keyField를 구분 -->
							<option value="member_id">작성자</option>
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
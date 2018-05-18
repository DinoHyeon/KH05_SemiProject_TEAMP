<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		width: 450px;		
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
	detail.jsp
	의견나눔게시판, 공지사항게시판, 그룹게시판 글 작성시 이동하는 상세보기 페이지 (모두 detail.jsp를 공유함)
 -->

<div id=page>
   
   <div id="list">
    <h2>${info.bbs_subject }</h2>
   <table id="tel">     
   
   <tr>
      <th>작성자</th>
      <td align="left">${info.member_id }</td>
   </tr>
   
   <tr>
      <th>내용</th>
      <td height="400px" align="left">${info.bbs_content }</td>
   </tr>
   

   <tr>      
   		<!-- dto에 셋팅된 bbs_name을 사용하여 리스트돌아가기 클릭시 각각의 페이지로 분기 시키기 -->
      <td colspan="2">
	     	 <c:if test="${info.bbs_name == 'freeBbs'}">
	     	 	<a href ="/SemiProject_TeamP/comunityList">리스트</a>
	     	 </c:if>
	     	 
	     	 <c:if test="${info.bbs_name == 'adminBbs'}">
	     	 	<a href ="/SemiProject_TeamP/adminList">리스트</a>
	     	 </c:if>
	     	 
	     	 <c:if test="${sessionScope.loginId != 'admin' && info.bbs_name == 'groupBbs'}">
	     	 	<a href ="/SemiProject_TeamP/groupList">리스트</a>
	     	 </c:if> 
	     	 
	     	 <c:if test="${sessionScope.loginId == 'admin' && info.bbs_name == 'groupBbs'}">
	     	 	<a href ="/SemiProject_TeamP/adminGroupBbsList">리스트</a>
	     	 </c:if> 
	     	 
	         &nbsp;&nbsp;&nbsp;&nbsp;
	         
	         <!-- 자신의 글만 수정가능 -->
	         <c:if test="${sessionScope.loginId == info.member_id}">
	         <a href="./updateForm?idx=${info.bbs_idx}">수정</a>
	         </c:if>
	         &nbsp;&nbsp;&nbsp;&nbsp;
	         
	         <!-- 자신 과 관리자만 삭제 가능 -->
	         
	         <!-- 관리자와 로그인한유저만 의견나눔게시판 삭제 가능-->
	         <c:if test="${(sessionScope.loginId == info.member_id || sessionScope.loginId == 'admin') && info.bbs_name == 'freeBbs'}">  
	        	 <a href="./comunityBbsDelete?idx=${info.bbs_idx}">삭제</a>
	  		 </c:if>
			<!-- 관리자와 로그인한유저(그룹장)만 그룹게시판 삭제 가능-->
			 <c:if test="${(sessionScope.loginId == info.member_id || sessionScope.loginId == 'admin') && info.bbs_name == 'groupBbs'}">  
	        	 <a href="./groupBbsDelete?idx=${info.bbs_idx}">삭제</a>
	  		 </c:if>
      </td>
   </tr>
   
   </table>
      </div>
   </div>
</body>

</html>
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
   
  table,th,td{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	}
</style>
</head>
<body>
<%@include file="../headerMenu.jsp"%>
<%@include file="../sideMenu.jsp"%>
<div id=page>
   
   <div id="list">
   <table>
   <tr>
      <th>작성자</th>
      <td>${info.member_id }</td>
   </tr>
   <tr>
      <th>제목</th>
      <td>${info.bbs_subject }</td>
   </tr>
   <tr>
      <th>내용</th>
      <td>${info.bbs_content }</td>
   </tr>
   

   <tr>      
   	
      <td colspan="2">
	     	<a href="#" onclick="history.go(-1)">리스트 </a> 
	         &nbsp;&nbsp;&nbsp;&nbsp;
	         <a href="./updateForm?idx=${info.bbs_idx}">수정</a>
	         &nbsp;&nbsp;&nbsp;&nbsp;
	         <a href="./delete?idx=${info.bbs_idx}">삭제</a>
      </td>
   </tr>
   
   </table>
      </div>
   </div>
</body>

</html>
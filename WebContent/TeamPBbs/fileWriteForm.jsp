<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
   	
   	/* #tel{
		border: 1px solid black;
		border-collapse: collapse;
		padding: 5px 10px;
	} */
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
   		margin-top: 58px;
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
    <div id="page">
    <h2 id="j">글쓰기</h2>
		<form action="../fileWrite" method="post" enctype="multipart/form-data">
		<input type="hidden" name="bbs_name" value="fileBbs">
		
   			<table id="tel">
			   <tr>
			      <th width="10%">작성자</th>
			      <td><input id="sessionId" type="text" name="member_id"  value="${sessionScope.loginId}" readonly="readonly"/></td>
			   </tr>
			   <tr>
			      <th>제목</th>
			      <td><input type="text" name="bbs_subject"/></td>
			   </tr>
			   <tr>
			      <th>내용</th>
			      <td height="400px"><textarea rows="20" cols="30" name="bbs_content"></textarea></td>
			   </tr>
			   <tr>
			      <th>사진</th>
			      <td><input type="file" name="photo"/></td>
			   </tr>
			   
			   <tr>      
			      <td colspan="2">
			         <a href="../fileList?pageNo=${sessionScope.pageNo}">리스트 </a>
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
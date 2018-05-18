<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
<style>
   
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
   		margin-left: 500px;
   		width: 30%;
   	}
   	#tab{
   		margin-left: 550px;
   		margin-top: 20px;
   	}
   	#btn{
   		margin-left: 825px;
   		margin-top: -20px;
   	}
   	
   	h2{
   		margin-left: 630px;
   	}
   	#aa{
  	 	margin-left: 10px;  	 	
   	}
   	#btnno{
   		margin-left: 580px;
   		margin-top: 20px;
   	}
      
</style>
</head>
<body>
   <%@include file="../headerMenu.jsp"%>
   <%@include file="../sideMenu.jsp"%>
    <div id="page">
    <h2>파일 게시판</h2>
      <table id="tel">
         <tr>            
            <th id="tel">제목</th>
			<th id="tel">작성자</th>
			<th id="tel">날짜</th>
			<th id="tel">조회수</th>
         </tr>
         <c:forEach items="${list}" var="bbs">
            <tr>               
               <td id="tel"><a href="fileDetail?idx=${bbs.bbs_idx}">${bbs.bbs_subject }</a></td>
               <td id="tel">${bbs.member_id }</td>
               <td id="tel">${bbs.bbs_date }</td>
               <td id="tel">${bbs.bbs_bHit }</td>
            </tr>
         </c:forEach>
      </table>
      
      <div id="btnno">
		<a id="aa" href="#">이전</a>
		<a id="aa" href="#">[1]</a>
		<a id="aa" href="#">2</a>
		<a id="aa" href="#">3</a>
		<a id="aa" href="#">4</a>
		<a id="aa" href="#">다음</a>
		</div>
		
		<button id="btn" onclick="location.href = 'TeamPBbs/fileWriteForm.jsp'">글쓰기</button>
      
      <form action="./fileList" method="get">
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
</html>
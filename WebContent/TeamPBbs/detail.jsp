<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Team P</title>
<style>
      #page{
      position: absolute;
      top: 15.9%;
        width: 82.5%;
        height: 84.1%;
      background-color: white;
   }
 	
	#tel th{
		border: 1px solid black;
		border-collapse: collapse;
		
	
	}
	#tel td{
		border: 1px solid black;
		border-collapse: collapse;		
	
	}  
  
	#tel{
  	 	border: 1px solid black;
   		border-collapse: collapse;   		
   		text-align: center;
   		margin-top: 0%;
   		margin-left:  2%;
   		width: 95%;
   		height: 50%;
   	}
   	
     	
   	#n{
   		margin-left: 50%;
   	}
   	
  .textname {
	border: none;
	text-align: center;
	}
	
	.input_text {
		width: 29%;
		border: none;
		background-color: red;
	}

	#register {
		border: none;
	    font-weight: 900;
	    color: #004C63;
		background-color: #FFD724;
		z-index: 2;
		line-height: 23px;
		text-align: center;
		border-radius: 8px;
	}
	#register:hover{
		cursor: pointer;
		background-color: #004C63;
		color: #FFD724;
	}
	#ccontent{
		resize:none;
		height: 70%;
		width: 90%;
	}
	#listtable{		
		margin-top: 4%;   	
		width: 80%;
		
	}
	#listTable2{
		margin-left: 2.5%;
		width: 119%;
		margin-top: -5%;
		border: 1px solid black;
	}	
	#o{
		color: black;
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
    <h2 id="n">${info.bbs_subject }</h2>
   <table id="tel">     
    <tr id="hidden" style="display:none;">
			<th>게시글 번호</th>
				<td id="bbsno">${info.bbs_idx}</td>
			</tr>
   <tr>
      <th width="10%">작성자</th>
      <td align="left">${info.member_id }</td>
   </tr>
   
   <tr>
      <th>내용</th>
      <td height="400px" align="left" valign="top">${info.bbs_content }</td>
   </tr>
   

   <tr>      
   		<!-- dto에 셋팅된 bbs_name을 사용하여 리스트돌아가기 클릭시 각각의 페이지로 분기 시키기 -->
      <td colspan="2">
	     	 <c:if test="${info.bbs_name == 'freeBbs'}">
	     	 	<a id="o" href ="/SemiProject_TeamP/comunityList?pageNo=${sessionScope.pageNo}">리스트</a>
	     	 </c:if>
	     	 
	     	 <c:if test="${info.bbs_name == 'adminBbs'}">
	     	 	<a id="o" href ="/SemiProject_TeamP/adminList?pageNo=${sessionScope.pageNo}">리스트</a>
	     	 </c:if>
	     	 
	     	 <c:if test="${sessionScope.memberLv != 'admin' && info.bbs_name == 'groupBbs'}">
	     	 	<a id="o" href ="/SemiProject_TeamP/groupList?pageNo=${sessionScope.pageNo}">리스트</a>
	     	 </c:if> 
	     	 
	     	 <c:if test="${sessionScope.memberLv == 'admin' && info.bbs_name == 'groupBbs'}">
	     	 	<a id="o" href ="/SemiProject_TeamP/adminGroupBbsList?pageNo=${sessionScope.pageNo}">리스트</a>
	     	 </c:if> 
	     	 
	         &nbsp;&nbsp;&nbsp;&nbsp;
	         
	         <!-- 자신의 글만 수정가능 -->
	         <c:if test="${sessionScope.loginId == info.member_id}">
	         <a id="o" href="./updateForm?idx=${info.bbs_idx}">수정</a>
	         </c:if>
	         &nbsp;&nbsp;&nbsp;&nbsp;
	         
	         <!-- 자신 과 관리자만 삭제 가능 -->
	         
	         <!-- 관리자와 로그인한유저만 의견나눔게시판 삭제 가능-->
	         <c:if test="${(sessionScope.loginId == info.member_id || sessionScope.memberLv == 'admin') && info.bbs_name == 'freeBbs'}">  
	        	 <a id="o" href="./comunityBbsDelete?idx=${info.bbs_idx}">삭제</a>
	  		 </c:if>
	  		 
			<!-- 관리자와 로그인한유저(그룹장)만 그룹게시판 삭제 가능-->
			 <c:if test="${(sessionScope.loginId == info.member_id || sessionScope.memberLv == 'admin') && info.bbs_name == 'groupBbs'}">  
	        	 <a id="o" href="./groupBbsDelete?idx=${info.bbs_idx}">삭제</a>
	  		 </c:if>
	  		 
	  		 <!-- 관리자만 공지사항게시판 삭제 가능-->
			 <c:if test="${sessionScope.memberLv == 'admin' && info.bbs_name == 'adminBbs'}">  
	        	 <a id="o" href="./adminList?idx=${info.bbs_idx}&pageNo=${sessionScope.pageNo}">삭제</a>
	  		 </c:if>
	  		 
      </td>
   </tr>
   <tr>
   				<td colspan="2">
						<!--댓글 등록 창  --> <textarea id="ccontent" cols="50" placeholder="댓글을 입력하세요.."></textarea> <input
						type="button" id="register" value="등록" />
					</td>

				</tr>
   </table>
	   <div id="listtable">
			<table id="listTable2"></table>
			</div>
	      </div>
	   </div>
</body>
<script>
var commentdate = '${sessionScope.comment_date}';

var obj = {};
var idx;
obj.type = "POST";
obj.dataType = "JSON";

obj.error = function(e) {
	console.log(e)
};

$(document).ready(function() {
	listPrint2();

	
});

$("#register").click(function() {
	if($("#ccontent").val()==""){
		alert("댓글 내용을 입력해주세요");
	}
	else{
		obj.url = "./replyWrite";
	
					obj.data = {};
				
					obj.data.cid = $("#bbsno").text();
					obj.data.ccontent = $("#ccontent").val();
					obj.success = function(data) {
						if (data.success > 0) {
							alert("댓글쓰기에 성공 했습니다.");
							listPrint2();
							} else {
							alert("댓글쓰기에 실패 했습니다.");
						}
					}
	}
					ajaxCall(obj);
				});

function listPrint2() {
	obj.url = "./replyCheck";
	obj.data = {};
	obj.data.cid = $("#bbsno").text();
	obj.success = function(data) {
		var content = "";
			data.list.forEach(function(item, index) {
					content += "<tr id =" +item.member_id+">";
					content += "<td><input class='textname' type='text' value="+item.member_id+" readonly></td>";
				    content += "<td width='50%'><input class="+item.comment_idx+" value='"+item.comment_content+"' type='text'  style='border:0px; width:100%' readonly/></td>";
			        //content +="<td><input class="+item.comment_idx+" id="+item.comment_date+"</td>";
				   	content += "<td>"
							+ "<input class='commentup' value='수정' type='button' id="+item.comment_idx+">"
							+ "<input class='commentdel' type='button' value='삭제' id="+item.comment_idx+">"
							+ "</td>";
			        content += "<td>" + item.comment_date + "</td>";
				
					content += "</tr>";
				});

		$("#listTable2").empty();
		$("#listTable2").append(content);
		
		var person= {};
		if(person1 =$("input[type='text']")&&$("input[class='textname']")){
			person=person1;
		}
		
		if(button=$("input[type='button']")&&$("input[class='commentdel']")) {
			 button1=button;
		 }
		
		if(button=$("input[type='button']")&&$("input[class='commentup']")) {
			 button2=button;
		 }
		
		for(var i=0; i<person.length; i++){
			
		
			if('${sessionScope.loginId}' != person.get(i).value){
		
			$(button1[i]).css("display","none");
			$(button2[i]).css("display","none");

					
			}
			}

	
	}
			ajaxCall(obj);
}

$(document).on('click', '.commentdel', function() {
	console.log("삭제");
	var cid = $("#bbsno").text();

	var delcomment = $(this).attr("id");
	obj.url = "./replyDelete";
	obj.data = {	};
	
	obj.data = {};
	obj.data.delcomment = delcomment;
	obj.data.cid = cid;
	obj.success = function(data) {
		console.log(data);
		if (data.success>0) {
			alert("삭제에 성공하였습니다.")
			listPrint2();
		} else {
			alert("삭제 실패")
		}

	}

	ajaxCall(obj);
});

var i = 0;

$(document).on('click', '.commentup', function() {
	console.log("수정");
	if (i == 0) {
		var upcomment = $(this).attr("id");
		console.log(upcomment);
		$("input[class=" + upcomment + "]").css("border", "1px solid");

		$("input[class=" + upcomment + "]").css("border-color", "green");
		$("input[class=" + upcomment + "]").attr("readonly", false);
	
		console.log("i값" + i)
		i = i + 1;

	} else {
		var upcomment = $(this).attr("id");
		var content = $("input[class=" + upcomment + "]").val();
		//var time=$("inpput[class=" +upcomment+"]").id;
		//var content= $(".edit").val();	

		obj.url = "./replyUpdate";
		obj.data = {};
		obj.data.upcomment = upcomment;
		obj.data.content = content;
		obj.success = function(data) {
			console.log(data);
			if (data.success) {
				alert("수정에 성공하였습니다.")
				i=0;
				listPrint2();
			} else {
				alert("수정 실패")
			}

		};

		ajaxCall(obj);
	}

});


function ajaxCall(param) {
	console.log(param);
	$.ajax(param);
}

</script>

</html>
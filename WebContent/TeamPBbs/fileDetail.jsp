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
	.edit {
		width: 100%;
		resize: none;
		border: 1px solid white;
	}
	
	.textname {
		border: none;
		text-align: center;
		width: 10%;
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
		background-color: #004C63;
		color: #FFD724;
		cursor: pointer;
	}
	#ccontent{
		resize:none;
		height: 70%;
		width: 90%;
	}
	#listtable{		
		margin-top: 4%;   	
		width: 80%;
		border: 1px solid black;
	}
	#listTable2{
		margin-left: 4.7%;
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
    <div id="page">  
			
			<h2>${info.bbs_subject}</h2>
	
		<table id="tel">
		   <tr id="hidden" style="display:none;">
			<th>게시글 번호</th>
				<td id="bbsno">${info.bbs_idx}</td>
			</tr>
   
   
		<tr>
			<th width="10%">작성자</th>
			<td align="left">${info.member_id}</td>
		</tr>	
		
		<c:if test="${info.newFileName != null}">
		<tr>
			<th>첨부파일 </th>
			<td><img src="./upload/${info.newFileName}" width="500"/><a href = "./fileDownLoad?idx=${info.bbs_idx}">다운로드</a></td>
		</tr>
		</c:if>
			
		<tr>
			<th>내용</th>
			<td height="400px" align="left" valign="top">${info.bbs_content}</td>
		</tr>		
		
		<tr>
			<td colspan="2">
			<c:if test="${sessionScope.loginId == 'admin'}">
				<a id="o" href="./adminFileBbsList?pageNo=${sessionScope.pageNo}">리스트가기</a>
			</c:if>
			
			<c:if test="${sessionScope.loginId != 'admin'}">
				<a id="o" href="./fileList?pageNo=${sessionScope.pageNo}">리스트가기</a>
			</c:if>		
								
				&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${sessionScope.loginId == info.member_id}">
					<a id="o" href="./fileUpdateForm?idx=${info.bbs_idx}">수정</a>
					&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				
				<c:if test="${sessionScope.loginId == info.member_id || sessionScope.loginId == 'admin' }">
					<a id="o" href="./fileDelete?idx=${info.bbs_idx}">삭제</a>
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
		<table id="listTable2">	</table>
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
//
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
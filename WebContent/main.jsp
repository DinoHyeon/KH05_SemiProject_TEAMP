<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta charset="UTF-8">
        <title>J-QUERY</title>
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <style>
			body{
				margin : 0px;
			}
			
            #mainInfo{
                position: fixed;
                left: 82.5%;
                width: 17.5%;
                height: 100%;
                background-color: #004C63;
            }
            
            #header{
                position: absolute;
                width: 82.5%;
                height: 8%;
                background-color: white;
            }
            
            #navi{
                position: absolute;
                background-color: none;
                left : 61%;
                top : 28.5%;
            }
            
            #navi button{
                border: none;
                background-color: white;
                font-size: 14px;
                padding : 5px;
                color : #004C63;
                border : 1px solid white;
            }
            
            #groupName{
                position: absolute;
                padding: 15px;
                left: 15px;
                top: 80px;
            }
            
            #group{
                position: absolute;
                background-color: #566A70;
                width: 82.5%;
                top: 8%;
                height: 7.9%;
            }
            
            #groupInfo{
                position: absolute;
                background-color: #FFD724;
                color: #004C63;
                width: 8%;
                height: 60%;
                top: 18.5%;
                left: 91%;
                text-align: center;
                line-height: 33px;
                font-weight: 900;
                border-radius: 8px;
            }
            
            #page{
                position: absolute;
                width: 82.5%;
                /* height: 623px; */
            }
            
            #TeamP{
            	position: absolute;
            	color: #FFD724;
            	left: 74%;
            	top: 1%;
            	font-weight: 900;
            	font-size: 16px;
            }
            
            #userName{
                position: absolute;
            	color: #FFD724;
            	width: 100%;
                text-align: center;
            	top: 8%;
            	font-weight: 900;
            	font-size: 20px;
            }
            
            
            #groupName{
                position: absolute;
            	color: #FFD724;
                width: 83%;
            	top: 10.5%;
            	font-weight: 900;
            	font-size: 16px;
                text-align: center;
            }
        </style>
    </head>
    
    <body>
        <div id="mainInfo">
        	<div id="TeamP">Team P</div>
            <div id="userName">박현정</div>
            <div id="groupName">현재 그룹이 없어요:(</div>
        </div>
        <div id="header">
            <div id="navi">
                <button id="myInfo">내정보</button>
                <button id="notice">공지사항</button>
                <button id="plan">일정</button>
                <button id="fileBbs">파일게시판</button>
                <button id="groupBbs">그룹게시판</button>
                <button id="comunityBbs">의견나눔게시판</button>
            </div>
        </div>
        <div id="group">
            <div id="groupInfo">그룹 정보</div>
        </div>
        <div id="page">
            
        </div>
    </body>
    
<script>
	var obj = {};		
	obj.type="post";
	obj.dataType="json";
	obj.error=function(e){console.log(e)};
	
	//페이지가 로드되었을 때 session에 그룹번호가 없는 경우 화면을 다르게 보여줘야한다.
	$(document).ready(function() {
		//이건 ajax로 처리
		if('${sessionScope.loginId}'==""){
			alert("로그인이 필요한 서비스입니다.");
			location.href="index.jsp";
		}
		//세션에 저장되어 있는 groupNum이 0이라면(*0은 현재 가입되어 있는 그룹이 없는 것을 의미)
		if('${sessionScope.groupNum}'==0){
			//button의 css속성 값을 변경
			$("input[type='button']").css("display","inline");
		}
	})

	    	$("button").click(function(){
    		$("button").css("font-weight","normal");
    		$(this).css("font-weight","900");
    	})
    
		$("#myInfo").click(function(e){
			console.log("내정보");
			//$(표현할 위치).load(불러올 페이지^[id|class|tag], callBack함수);
			$("#page").load("./TemPBbs/myInfo.jsp")
		});
		
		$("#notice").click(function(e){
			console.log("공지사항");
			//$(표현할 위치).load(불러올 페이지^[id|class|tag], callBack함수);
			$("#page").load("./TemPBbs/notice.jsp", 
					function(res, stat){//res:전체 소스 , stat:성공|실패 여부
						console.log(res);
						console.log(stat);
			});
		});
		
		$("#plan").click(function(e){
			console.log("일정");
			//$(표현할 위치).load(불러올 페이지^[id|class|tag], callBack함수);
			$("#page").load("./TemPBbs/plan.jsp", 
					function(res, stat){//res:전체 소스 , stat:성공|실패 여부
						console.log(res);
						console.log(stat);
			});
		});
		
		$("#fileBbs").click(function(e){
			console.log("내정보");
			//$(표현할 위치).load(불러올 페이지^[id|class|tag], callBack함수);
			$("#page").load("./TemPBbs/fileBbs.jsp", 
					function(res, stat){//res:전체 소스 , stat:성공|실패 여부
						console.log(res);
						console.log(stat);
			});
		});
		
		$("#groupBbs").click(function(e){
			console.log("내정보");
			//$(표현할 위치).load(불러올 페이지^[id|class|tag], callBack함수);
			$("#page").load("./TemPBbs/groupBbs.jsp", 
					function(res, stat){//res:전체 소스 , stat:성공|실패 여부
						console.log(res);
						console.log(stat);
			});
		});
		
		$("#comunityBbs").click(function(e){
			console.log("내정보");
			//$(표현할 위치).load(불러올 페이지^[id|class|tag], callBack함수);
			$("#page").load("./TemPBbs/comunityBbs.jsp", 
					function(res, stat){//res:전체 소스 , stat:성공|실패 여부
						console.log(res);
						console.log(stat);
			});
		});
		
        $("#groupInfo").hover(function(){
			$(this).css("background-color","#004C63");
			$(this).css("color","#FFD724");
        },function(){//mouseleave
			$(this).css("background-color","#FFD724");
			$(this).css("color","#004C63");
        })
</script>
</html>
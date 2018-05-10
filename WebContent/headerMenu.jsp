<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
        <style>
			body{
				margin : 0px;
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
                top : 15.7%;
                width: 45%;
            }
            
            #navi button{
                border: none;
                background-color: white;
                font-size: 14px;
                padding : 3%;
                color : #004C63;
                border : 1px solid white;
            }
            

            #group{
                position: absolute;
                background-color: #566A70;
                width: 82.5%;
                top: 8%;
                height: 7.9%;
            }
            
            #Nongroup{
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
               	display: block;
            }
            
           #groupManage{
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
               	display: block;
            }
            
            #groupBg{
		        position: absolute;
				display: none;
				background-color: black;
				opacity: 0.7;
				z-index: 2;
				width: 100%;
				height: 100%;
            }
            
         	#popupContentMaster{
				position: absolute;
			    display: none;
			    z-index: 3;
			    top: 20%;
			    left: 18%;
			    width: 60%;
			    height: 60%;
			    background-color: #004C63;
			}
		
			#close{
				position: absolute;
				font-size: 18px;
				font-weight: 900;
				color: white;
				left: 97%;
				top: 2%;
				display: none;
			}
	            
        </style>
</head>
<body>
	 <div id="header">
            <div id="navi">
                <button onclick="location.href='memberInfoAccess.jsp'" id="myInfo">내정보</button>
                <button id="notice">공지사항</button>
                <button id="plan">일정</button>
                <button id="fileBbs">파일게시판</button>
                <button id="groupBbs">그룹게시판</button>
                <button id="comunityBbs">의견나눔게시판</button>
            </div>
        </div>
        
      	<div id="Nongroup">
			<h1>가입하신 그룹이 없습니다.</h1>
	 	</div>
        
        <div id="group">
            <div id="groupInfo">그룹 정보</div>
            <div id="groupManage">그룹 관리</div>
        </div>
        
       	<div id="groupBg"></div>
       	
       	<div id="popupContentMaster">
			<div id="close">X</div>
		</div>
        
</body>
<script>
	$(document).ready(function() {
		//그룹가입 여부에 따른 ... *include처리 방법 고민
		if('${sessionScope.groupNum}'!="0"){
			$("#Nongroup").css("display","none")
		}else{
			$("#Nongroup").css("display","inline")
		}
		
		//회원등급에 따른 버튼...
		if('${sessionScope.memberLv}'=="member"){
			$("#groupManage").css("display","none")
			console.log("멤버")
		}else{
			$("#groupInfo").css("display","none")
		}
	})
	
	//그룹원이 클릭했을 경우
	$("#groupInfo").click(function() {
		$("#groupBg").css("display","inline");
		$("#close").css("display","inline");
	})
	
	//그룹장이 클릭했을 경우
	$("#groupManage").click(function() {
		$("#groupBg").css("display","inline");
		$("#popupContentMaster").css("display","inline");
		$("#close").css("display","inline");
	})
	
	//닫기
	$("#close").click(function() {
		$("#groupBg").css("display","none");
		$("#close").css("display","none");
		$("#popupContentMaster").css("display","none");
	})
</script>
</html>
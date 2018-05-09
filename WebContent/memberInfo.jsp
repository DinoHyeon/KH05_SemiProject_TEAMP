<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
</body>
</html>
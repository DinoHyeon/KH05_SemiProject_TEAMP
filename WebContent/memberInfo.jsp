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
<script>
</script>
</html>
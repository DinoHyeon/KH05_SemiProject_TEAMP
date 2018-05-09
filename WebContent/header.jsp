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
            <div id="userName"></div>
            <div id="groupName">현재 그룹이 없어요:(</div>
        </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Team P :: 아이디찾기</title>
    <style>
        body{
                margin: 0;
                background-color: #004D65;
        }        
        #title{
                position: absolute;
                color: #FFD724;
                font-weight: 900;
                left: 33%;
                top: 16.55%; 
        }        
        #goIndex{
                position: absolute;
                color: #FFD724;
                font-weight: 900;
                left: 91.5%;
                top: 2%;
                font-size: 28px;
        }
        #findIdSection{
                 position: absolute;
                 border: 4px solid #FFD724;
                 width: 74%;
                 height: 56%;
                 left: 12%;
                 top: 39%;
        }
        #findIdtitle{
                 position: absolute;
                 color: #FFD724;
                 font-weight: 800;
                 left: 13%;
                 top: 32.55%;
        }
        
        h2{
                position: absolute; 
                left: 38.5%;
                top: 20%; 
                color: white;
        }
        #memberId{
                position: absolute;
                color: #FFD724;
                left: 46.5%;
                top: 37%;   
                text-align: center;
        }
        #login{
                position: absolute;
                float: left;
                width: 15%;
                height: 9%;
                left: 34%;
                top: 69%;
                border-radius: 8px;
                background-color: #FFD724;
                color: #004D65;
                border: none;
                font-weight: 900;
                text-align: center;
                line-height: 35px;
                font-size: 15px;          
        }
        #changePw{
                position: absolute;
                float: left;
                width: 15%;
                height: 9%;
                left: 52%;
                top: 69%;
                border-radius: 8px;
                background-color: #FFD724;
                color: #004D65;
                border: none;
                font-weight: 900;
                text-align: center;
                line-height: 35px;
                font-size: 15px;
        }
    </style>
</head>
<body>
    <div id="goIndex">Team P</div>
    <h1 id="title">아이디/비밀번호를 잊어버리셨나요?</h1>
    <h2 id="findIdtitle">아이디 찾기</h2>
    <div id=findIdSection>
        <h2>${name} 회원님의 아이디는</h2>
        <h2 id="memberId">${msg}</h2>
        <button id="login" onclick="location.href='index.jsp'">로그인</button>
        <button id="changePw" onclick="location.href='findInfo.jsp'">비밀번호 재설정</button>
    </div>
</body>
<script>
	$("#goIndex").click(function(){
	    location.href="index.jsp"
	})

    $("#login").mouseenter(function(){
        $("#login").css("background","#00455A");
        $("#login").css("color","#FFD724")
        $("#login").mouseleave(function(){
            $("#login").css("background","#FFD724");
            $("#login").css("color","#004D65")
        })
    })
    
    $("#changePw").mouseenter(function(){
        $("#changePw").css("background","#00455A");
        $("#changePw").css("color","#FFD724")
        $("#changePw").mouseleave(function(){
            $("#changePw").css("background","#FFD724");
            $("#changePw").css("color","#004D65")
        })
    })    
</script>
</html>
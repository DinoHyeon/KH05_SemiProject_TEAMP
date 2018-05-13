<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
    <title>Team P :: 비밀번호 재설정</title>
    <style>
        body{
            margin: 0;
            background-color: #004D65;
        } 
        #goIndex{
            position: absolute;
            color: #FFD724;
            font-weight: 900;
            left: 91.5%;
            top: 2%;
            font-size: 28px;
        }
        #title{
            position: absolute;
            color: #FFD724;
            font-weight: 900;
            left: 33%;
            top: 16.55%; 
        }           
        #changePwSection{
             position: absolute;
             border: 4px solid #FFD724;
             width: 74%;
             height: 39%;
             left: 12%;
             top: 44%;
        } 
        #findPwtitle{
            position: absolute;
            color: #FFD724;
            font-weight: 800;
            left: 13%;
            top: 37.7%;
        }  
        table{
            position: absolute;
            left: 36%;
            top: 14%;
            width: 50%;
            height: 40%;
            color: white;
            font-weight: 530;
        }
        
        td{
            padding: 1%;
        }
        
        input[type='password']{
            border-width: 0px;
            width: 50%;
            height: 158%;
        }
        #userPwChkMsg{
            position: absolute;
            left: 52%;
            top: 80.6%;
            font-size: 12px;
        }
        #changPw{
            position: absolute;
            float: left;
            width: 24.8%;
            height: 14%;
            left: 36.3%;
            top: 67%;
            border-radius: 8px;
            background-color: #FFD724;
            color: #004D65;
            border: none;
            font-weight: 900;
            text-align: center;
            line-height: 41px;
            font-size: 15px;
        }
    </style>
    </head>
    <body>
        <div id="goIndex">Team P</div>
        <h1 id="title">아이디/비밀번호를 잊어버리셨나요?</h1>
        <h2 id="findPwtitle">비밀번호 재설정</h2>  
        <div id="changePwSection"> 
            <form action="./ChangePw" method="post"">
                <table>
                    <input type="hidden" name="userId" value="${msg}"/>
                    <tr><td>비밀번호</td></tr>
                    <tr><td><input type="password" name="changePw" id="userPw"/></td></tr>
                    <tr><td>비밀번호 확인</td></tr>
                    <tr><td><input type="password" id="userPwChk" onkeyup="chk()"/><span id="userPwChkMsg"></span></td></tr>
                </table>
                <input id="changPw" type="button" value="비밀번호 변경">                               
            </form>
        </div>                                                                     
    </body>
    <script>
        var pwChk = false;
	    
        $("#goIndex").click(function(){
	        location.href="index.jsp"
	    })
        
        $("#changPw").mouseenter(function(){
            $("#changPw").css("background","#00455A");
            $("#changPw").css("color","#FFD724")
            $("#changPw").mouseleave(function(){
                $("#changPw").css("background","#FFD724");
                $("#changPw").css("color","#004D65")
            })
        })
        //비밀번호 일치 확인
        function chk(){
            if($("#userPw").val()==$("#userPwChk").val()){
                $("#userPwChkMsg").html("일치");
                $("#userPwChkMsg").css("color","green");
                pwChk=true;
            }else{
                $("#userPwChkMsg").html("불일치");
                $("#userPwChkMsg").css("color","red");
                pwChk=false;
            }
        }

        $("#changPw").click(function(){
            if(!pwChk){
                alert("올바른 비밀번호를 입력해주세요.");
            }else{
                $("#changPw").attr("type","submit");
            }
        });
    </script>
</html>
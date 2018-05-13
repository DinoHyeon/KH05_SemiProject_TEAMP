<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <style>
            body{
                margin: 0;
                background-color: #004D65;
            }
            input[type='text'],input[type='email']{
                border-width: 0px;
                width: 100%;
                height: 160%;
            }
            
            select{
                width: 31.7%;
                height: 130%; 
            }
            
            td{
                padding-top: 2%;
                color: white;
                font-weight: 400;
            }
            
            table{
                width: 100%;
            }
            h1{
                position: absolute;
                color: #FFD724;
                font-weight: 900;
                left: 33%;
                top: 16.55%; 
            }
            #findIdtitle{
                position: absolute;
                color: #FFD724;
                font-weight: 800;
                left: 13%;
                top: 32.55%;
            }
            #findPwtitle{
                position: absolute;
                color: #FFD724;
                font-weight: 800;
                left: 75.6%;
                top: 32.55%;
            }
            
            #findInfoSection{
                position: absolute;
                border: 4px solid #FFD724;
                width: 74%;
                height: 56%;
                left: 12%;
                top: 39%;
            }
            #findIdTalbe{
                position: absolute;
                left: 10%;
                top: 21%;
                height: 40%;
                width: 28%;
            }
            #findPwTable{
                position: absolute;
                left: 61%;
                top: 9%;
                height: 40%;
                width: 28%;
            }
            
            #divisionLine
            {
                position: absolute;
                border-left: 4px solid #FFD724;  
                left: 50%;
                top: 4%;
                width: 5%;
                height: 92%;
            }
            
            #findIdBtn{
                position: absolute;
                float: left;
                width: 15%;
                height: 9%;
                left: 16.5%;
                top: 81%;
                border-radius: 8px;
                background-color: #FFD724;
                color: #004D65;
                border: none;
                font-weight: 900;
                text-align: center;
                line-height: 35px;
                font-size: 15px;
            }
            
            #findPwBtn{
                position: absolute;
                float: left;
                width: 15%;
                height: 9%;
                left: 67.5%;
                top: 81%;
                border-radius: 8px;
                background-color: #FFD724;
                color: #004D65;
                border: none;
                font-weight: 900;
                text-align: center;
                line-height: 35px;
                font-size: 15px;
            }
        	#goIndex{
	            position: absolute;
	            color: #FFD724;
	            font-weight: 900;
	            left: 91.5%;
	            top: 2%;
	            font-size: 28px;
	        }
        </style>
        <title>Insert title here</title>
    </head>
    <body>
    	<div id="goIndex">Team P</div>
        <h1>아이디/비밀번호를 잊어버리셨나요?</h1>
        <h2 id="findIdtitle">아이디 찾기</h2>
        <h2 id="findPwtitle">비밀번호 찾기</h2>
        <div id="findInfoSection">
            <form action="./findId" method="post">
                <table id="findIdTalbe">
                    <tr><td>이름</td></tr>
                    <tr><td><input type="text" name="idUserName"/></td></tr>
                    <tr><td>생년월일</td></tr>
                        <tr>
                            <td>
                                <select name="idYear">
                                    <option></option>
                                </select>
                                <select name="idMonth">
                                    <option></option>
                                </select>
                                <select name="idDay">
                                    <option></option>
                                </select>
                            </td>
                        </tr>
                    <tr><td>이메일</td></tr>
                    <tr><td><input type="email" name="idEmail"/></td></tr>		
                </table>
                <input id="findIdBtn" type="button" value="아이디 찾기"/>
            </form>
            <div id="divisionLine"></div>
            <form action="./findPw" method="post">
                <table id="findPwTable">
                    <tr><td>이름</td></tr>
                    <tr><td><input type="text" name="pwUserName"/></td></tr>
                    <tr><td>아이디</td></tr>
                    <tr><td><input type="text" name="pwUserId"/></td></tr>		
                    <tr><td>생년월일</td></tr>
                        <tr>
                            <td>
                                <select name="pwYear">
                                    <option></option>
                                </select>
                                <select name="pwMonth">
                                    <option></option>
                                </select>
                                <select name="pwDay">
                                    <option></option>
                                </select>
                            </td>
                        </tr>
                    <tr><td>이메일</td></tr>
                    <tr><td><input type="email" name="pwEmail"/></td></tr>		
                    <tr><td>휴대폰</td></tr>
                    <tr><td><input type="text" name="pwPhone"/></td></tr>	
                </table>
                <input id="findPwBtn" type="button" value="비밀번호 재설정"/>
            </form>
        </div>    
    </body>
    <script>
        $(document).ready(function() {
            var year=1930;
            var month=12;
            var day=31;

            //year element 추가
            for(var i=2018; i>=year; i--){
                $("select[name='idYear']").append("<option value"+i+">"+i+"</option>");
                $("select[name='pwYear']").append("<option value"+i+">"+i+"</option>");
            }
            //month element 추가
            for(var i=1; i<=month; i++){
                if(i<10){
                    i='0'+i;
                }
                $("select[name='idMonth']").append("<option value"+i+">"+i+"</option>");
                $("select[name='pwMonth']").append("<option value"+i+">"+i+"</option>");
            }
            //day element 추가
            for(var i=1; i<=day; i++){
                if(i<10){
                    i='0'+i;
                }
                $("select[name='idDay']").append("<option value"+i+">"+i+"</option>");
                $("select[name='pwDay']").append("<option value"+i+">"+i+"</option>");
            }
        })
        
     	$("#goIndex").click(function(){
	        location.href="index.jsp"
	    })
        /* 아이디 찾기 버튼 클릭 css 변경 */
        $("#findIdBtn").mouseenter(function(){
            $("#findIdBtn").css("background","#00455A");
            $("#findIdBtn").css("color","#FFD724")
            $("#findIdBtn").mouseleave(function(){
                $("#findIdBtn").css("background","#FFD724");
                $("#findIdBtn").css("color","#004D65")
            })
        })
        
        /* 비밀번호 재설정 버튼 클릭 css 변경 */
        $("#findPwBtn").mouseenter(function(){
            $("#findPwBtn").css("background","#00455A");
            $("#findPwBtn").css("color","#FFD724")
            $("#findPwBtn").mouseleave(function(){
                $("#findPwBtn").css("background","#FFD724");
                $("#findPwBtn").css("color","#004D65")
            })
        })

        //아이디 찾기
        $("#findIdBtn").click(function(){
            if($("select[name='idYear']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("select[name='idMonth']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("select[name='idDay']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else if($("input[name='idUserName']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("input[name='idEmail']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else{
                $("#findId").attr("type","submit");
            }
        });

        //비밀번호 찾기
        $("#findPwBtn").click(function(){
            if($("select[name='pwYear']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("select[name='pwMonth']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("select[name='pwDay']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else if($("input[name='pwUserName']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("select[name='pwUserId']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("input[name='pwEmail']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else if ($("input[name='pwPhone']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else{
                $("#findPw").attr("type","submit");
            }
        });
    </script>
</html>
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
        <title>Team P :: 아이디찾기/비밀번호 재설정</title>
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
                    <tr><td><input type="email" name="idEmail" placeholder="teamP@email.com"/></td></tr>		
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
                    <tr><td><input type="email" name="pwEmail" placeholder="teamP@email.com"/></td></tr>		
                    <tr><td>휴대폰</td></tr>
                    <tr><td><input type="text" name="pwPhone" placeholder="010-1234-1234"/></td></tr>	
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
        
        var msg = "${msg}";
    	
    	if(msg != ""){
    		alert(msg);
    		location.href="findInfo.jsp";
    	}
        
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
            var Name_char = /^[ㄱ-ㅎ|가-힣]+$/;
    		var userName = $("input[name='idUserName']").val();
    		
    		var email_char = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		var userEmail = $("input[name='idEmail']").val();
        	
            if($("select[name='idYear']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='idYear']").focus();
            }else if ($("select[name='idMonth']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='idMonth']").focus();
            }else if ($("select[name='idDay']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='idDay']").focus();
            }else if($("input[name='idUserName']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='idUserName']").focus();
            }else if(!Name_char.test(userName)){//이름 입력제한
				alert("이름은 한글입력만 가능합니다.")
				$("input[name='idUserName']").val("");
				$("select[name='idUserName']").focus();
			}else if ($("input[name='idEmail']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
            }else if(!email_char.test(userEmail)){
            	alert("올바른 이메일 형식이 아닙니다.")
            	$("input[name='idEmail']").val("");
            	$("input[name='idEmail']").focus();
			}else{
                $("#findIdBtn").attr("type","submit");
            }
        });

        //비밀번호 찾기
        $("#findPwBtn").click(function(){
            var Name_char = /^[ㄱ-ㅎ|가-힣]+$/;
    		var userName = $("input[name='pwUserName']").val();
    		
    		var email_char = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		var userEmail = $("input[name='pwEmail']").val();
    		
			var Phone_char = /^\d{3}-\d{3,4}-\d{4}$/;
			var userPhone = $("input[name='pwPhone']").val()
        	
            if($("select[name='pwYear']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='pwYear']").focus();
            }else if ($("select[name='pwMonth']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='pwMonth']").focus();
            }else if ($("select[name='pwDay']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='pwDay']").focus();
            }else if($("input[name='pwUserName']").val()==""){
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='pwUserName']").focus();
            }else if(!Name_char.test(userName)){//이름 입력제한
				alert("이름은 한글입력만 가능합니다.")
				$("input[name='pwUserName']").val("");
				$("select[name='pwUserName']").focus();
			}else if ($("select[name='pwUserId']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='pwUserId']").focus();
            }else if ($("input[name='pwEmail']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='pwEmail']").focus();
            }else if(!email_char.test(userEmail)){
            	alert("올바른 이메일 형식이 아닙니다.")
            	$("input[name='pwEmail']").val("");
                $("select[name='pwEmail']").focus();
			}else if ($("input[name='pwPhone']").val()=="") {
                alert("필수 정보를 모두 입력해주세요.")
                $("select[name='pwPhone']").focus();
            }else if(!Phone_char.test(userPhone)){
				alert("휴대폰 번호는 '-'를 포함하여 작성해주세요.'");
				$("select[name='pwPhone']").val("");
				$("select[name='pwPhone']").focus();
			}else{
                $("#findPwBtn").attr("type","submit");
            }
        });
    </script>
</html>
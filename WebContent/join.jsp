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
	        h1{
	            position: absolute;
	            color: #FFD724;
	            font-weight: 900;
	            left: 36.3%;
	            top: 8.55%;
	        }
	        input[type='text'],input[type='email'],input[type='password']{
	            border-width: 0px;
	            width: 39%;
	            height: 100%;
	        }
	        select{
	            width: 12.5%;
	            height: 83%; 
	        }
	        table{
	            position: absolute;
	            width: 50%;
	            height: 60%;
	            left: 36%;
	            top: 21%;
	        }
	        
	        td{
	            color: white;
	            font-weight: 540;
	        }
	
	        #idOverlay{
	            position: absolute;
	            float: left;
	            width: 16%;
	            height: 5%;
	            left: 40.5%;
	            top: 22.2%;
	            border-radius: 8px;
	            background-color: #FFD724;
	            color: #004D65;
	            border: none;
	            font-weight: 900;
	            text-align: center;
	            line-height: 23px;
	            font-size: 14px;
	        }
	        #emailOverlay{
	            position: absolute;
	            float: left;
	            width: 16%;
	            height: 5%;
	            left: 40.5%;
	            top: 93.9%;
	            border-radius: 8px;
	            background-color: #FFD724;
	            color: #004D65;
	            border: none;
	            font-weight: 900;
	            text-align: center;
	            line-height: 23px;
	            font-size: 14px;
	        }
	        #idOverlayMsg{
	            position: absolute;
	            left: 58%;
	            top: 22.8%;
	            font-size: 12px;
	        }
	        #emailOverlayMsg{
	            position: absolute;
	            left: 58%;
	            top: 94.6%;
	            font-size: 12px;
	        }
	        #userPwChkMsg{
	            position: absolute;
	            left: 41%;
	            top: 51%;
	            font-size: 12px;
	        }
	        #join{
	            position: absolute;
	            float: left;
	            width: 19.5%;
	            height: 6%;
	            left: 36.1%;
	            top: 84.9%;
	            border-radius: 8px;
	            background-color: #FFD724;
	            color: #004D65;
	            border: none;
	            font-weight: 900;
	            text-align: center;
	            line-height: 23px;
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
	    <title>Team P :: 회원가입</title>
	</head>
	<body>
	    <div id="goIndex">Team P</div>
	    <h1>Team P와 함께 해요</h1>
		<table>
			<tr><td>이름</td></tr>
			<tr><td><input type="text" id="userName"/></td></tr>
			<tr><td>아이디</td></tr>
			<tr>
				<td>
					<input type="text" id="userId"/>
					<input id="idOverlay" type="button" value="아이디 중복 체크"/>
					<span id="idOverlayMsg"></span>
				</td>
			</tr>
			<tr><td>비밀번호</td></tr>
			<tr><td><input type="password" id="userPw" onkeyup="passInputChk()" placeholder="숫자와 영문자 조합 8~16자리"/></td></tr>
			<tr><td>비밀번호 확인</td></tr>
			<tr><td><input type="password" id="userPwChk" onkeyup="chk()" placeholder="숫자와 영문자 조합 8~16자리"/><span id="userPwChkMsg"></span></td></tr>
			<tr><td>생년월일</td></tr>
			<tr>
				<td>
					<select id="year">
						<option></option>
					</select>
					<select id="month">
						<option></option>
					</select>
					<select id="day">
						<option></option>
					</select>
				</td>
			</tr>
			<tr><td>휴대폰 번호</td></tr>
			<tr><td><input type="text" id="phone" placeholder="010-1234-1234"/></td></tr>
			<tr><td>이메일</td></tr>
			<tr>
				<td>
					<input type="email" id="email" placeholder="teamP@email.com">
					<input id="emailOverlay" type="button" value="이메일 중복 체크"/>
					<span id="emailOverlayMsg"></span>
				</td>
	        </tr>
		</table>
	    <input id="join" type="button" value="회원가입"/>
	</body>
	<script>
		var obj = {};//초기화			
		obj.type="post";
		obj.dataType="json";
		obj.error=function(e){console.log(e)};
	
		var idChk=false;
		var emailChk=false;
		var pwChk=false;
		
		$(document).ready(function() {
			var year=1930;
			var month=12;
			var day=31;
			
			//year element 추가
			for(var i=2018; i>=year; i--){
				$("#year").append("<option value"+i+">"+i+"</option>");
			}
			//month element 추가
			for(var i=1; i<=month; i++){
				if(i<10){
					i='0'+i;
				}
				$("#month").append("<option value"+i+">"+i+"</option>");
			}
			//day element 추가
			for(var i=1; i<=day; i++){
				if(i<10){
					i='0'+i;
				}
				$("#day").append("<option value"+i+">"+i+"</option>");
			}
		})
	    
	    
	    
	    $("#idOverlay").mouseenter(function(){
	        $("#idOverlay").css("background","#00455A");
	        $("#idOverlay").css("color","#FFD724")
	        $("#idOverlay").mouseleave(function(){
	            $("#idOverlay").css("background","#FFD724");
	            $("#idOverlay").css("color","#004D65")
	        })
	    })
	    
	    $("#emailOverlay").mouseenter(function(){
	        $("#emailOverlay").css("background","#00455A");
	        $("#emailOverlay").css("color","#FFD724")
	        $("#emailOverlay").mouseleave(function(){
	            $("#emailOverlay").css("background","#FFD724");
	            $("#emailOverlay").css("color","#004D65")
	        })
	    }) 
	    
	    $("#join").mouseenter(function(){
	        $("#join").css("background","#00455A");
	        $("#join").css("color","#FFD724")
	        $("#join").mouseleave(function(){
	            $("#join").css("background","#FFD724");
	            $("#join").css("color","#004D65")
	        })
	    })	
	    
	    $("#goIndex").click(function(){
	        location.href="index.jsp"
	    })

	    
		//아이디 중복확인 버튼을 눌렀을 때 아이디 중복여부 검사
		$("#idOverlay").click(function(){
	    	var input_char = /^[a-z|0-9]+$/;
			var userId = $("#userId").val();
			
			if(!input_char.test(userId)){
				alert("소문자와 숫자만 입력이 가능합니다.")
				$("#userId").val("");
				$("#idOverlayMsg").html("사용 불가능");
				$("#idOverlayMsg").css("color","red");
				idChk=false;
			}else if($("#userId").val()==""){
				$("#idOverlayMsg").html("미입력");
				$("#idOverlayMsg").css("color","red");
				idChk=false;
			}else{
				obj.url="./idOverlay";
				obj.data={id:$("#userId").val()};
				obj.success=function(d){
					if(d.idChk ==true){
						$("#idOverlayMsg").html("사용 가능");
						$("#idOverlayMsg").css("color","green");
						idChk=true;
					}else{
						$("#idOverlayMsg").html("사용 불가능");
						$("#idOverlayMsg").css("color","red");
						$("#userId").val("");
						idChk=false;
					}
				};
				ajaxCall(obj);
			}
		});
		
		//비밀번호 입력 제한
		function passInputChk() {
			var input_char = /^[a-z|0-9]+$/;
			var userPw = $("#userPw").val();
			if(!input_char.test(userPw)){
				alert("소문자와 숫자만 입력이 가능합니다.")
				$("#userPw").val("");
				$("#userPwChkMsg").html("사용 불가능");
				$("#userPwChkMsg").css("color","red");
				idChk=false;
			}
		}
		
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
		
		//이메일 중복확인 버튼을 눌렀을 때 이메일 중복여부 검사
		$("#emailOverlay").click(function(){
			var email_char = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			var userEmail = $("#email").val();
			if(!email_char.test(userEmail)){
				$("#emailOverlayMsg").html("올바른 이메일 형식이 아닙니다.");
				$("#emailOverlayMsg").css("color","red");
				emailChk=false;
			}else if($("#email").val()==""){
				$("#emailOverlayMsg").html("미입력");
				$("#emailOverlayMsg").css("color","red");
				emailChk=false;
			}else{
				obj.url="./emailOverlay";
				obj.data={email:$("#email").val()};
				obj.success=function(d){
				if(d.emailChk ==true){
					$("#emailOverlayMsg").html("사용 불가능");
					$("#emailOverlayMsg").css("color","red");
					$("#email").val("");
					emailChk=false;
				}else{
					$("#emailOverlayMsg").html("사용 가능");
					$("#emailOverlayMsg").css("color","green");
					emailChk=true;
				}
			};
				ajaxCall(obj);
			}
		});

		
		//입력하지 않은 값이 있는지 확인하고 데이터 전송
		$("#join").click(function(){
			var Name_char = /^[ㄱ-ㅎ|가-힣]+$/;
			var userName = $("#userName").val();
			
			var Pw_char = /^[a-z|0-9]{8,16}$/;
			var userPw = $("#userPw").val();
			
			var Phone_char = /^\d{3}-\d{3,4}-\d{4}$/;
			var userPhone = $("#phone").val();
			
			if(!idChk){
				alert("아이디 중복 체크를 실행 해 주세요!")
			}else if($("#userName").val() == ""){
				alert("필수 정보를 모두 입력해주세요.")
				$("#userName").focus();
			}else if(!Name_char.test(userName)){//이름 입력제한
				alert("이름은 한글입력만 가능합니다.")
				$("#userName").val("");
				$("#userName").focus();
			}else if(!pwChk){
				//비밀번호 입력 확인
				alert("필수 정보를 모두 입력해주세요.")
				$("#userPw").focus();
			}else if(!Pw_char.test(userPw)){
				alert("비밀번호는 숫자와 영문자 조합으로 8~16자리를 사용해야 합니다.")
				$("#userPw").val("");
				$("#userPwChkMsg").html("사용 불가능");
				$("#userPwChkMsg").css("color","red");
				$("#userPw").focus();
				idChk=false;
			}else if($("#phone").val() == ""){
				//휴대폰 번호 확인
				alert("필수 정보를 모두 입력해주세요.")
				$("#phone").focus();
			}else if(!Phone_char.test(userPhone)){
				alert("휴대폰 번호는 '-'를 포함하여 작성해주세요.'");
				$("#phone").val("");
				$("#phone").focus();
			}else if($("#year").val()=="" & $("#month").val()=="" & $("#day").val()==""){
				//생년월일
				alert("필수 정보를 모두 입력해주세요.")
				$("#year").focus();
			}else if($("#email").val() == ""){
				//이메일 입력 확인
				alert("필수 정보를 모두 입력해주세요.")
				$("#email").focus();}
			else{
				console.log("서버 전송")
				obj.url="./join";
				//data 값 입력
				console.log($("#year").val());
				obj.data.id=$("#userId").val();
				obj.data.pw=$("#userPw").val().toLowerCase();
				obj.data.name=$("#userName").val();
				obj.data.birth_year=$("#year").val();
				obj.data.birth_month=$("#month").val();
				obj.data.birth_day=$("#day").val();
				obj.data.phone=$("#phone").val();
				obj.data.email=$("#email").val();
				obj.success=function(data){
					if(data.success==1){
						alert("회원 가입이 정상 처리 되었습니다.");
						location.href="index.jsp";
					}else{
						alert("회원 가입에 실패했습니다.");
					}
				}
				console.log(obj);
				ajaxCall(obj);
			}
		})
		
		function ajaxCall(obj){
			$.ajax(obj);
		}
		
	</script>
</html>
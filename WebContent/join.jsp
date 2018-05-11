<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<table>
		<tr><td>이름</td></tr>
		<tr><td><input type="text" id="userName"/></td></tr>
		<tr><td>아이디</td></tr>
		<tr>
			<td>
				<input type="text" id="userId"/>
				<input id="idOverlay" type="button" value="중복 체크"/>
				<span id="idOverlayMsg"></span>
			</td>
		</tr>
		<tr><td>비밀번호</td></tr>
		<tr><td><input type="password" id="userPw"/></td></tr>
		<tr><td>비밀번호 확인</td></tr>
		<tr><td><input type="password" id="userPwChk" onkeyup="chk()"/><span id="userPwChkMsg"></span></td></tr>
		<tr><td>생년월일</td></tr>
		<tr>
			<td>
				<select id="year">
					<option></option>
				</select>년
				<select id="month">
					<option></option>
				</select>월
				<select id="day">
					<option></option>
				</select>일
			</td>
		</tr>
		<tr><td>휴대폰 번호</td></tr>
		<tr><td><input type="text" id="phone"/></td></tr>
		<tr><td>이메일</td></tr>
		<tr>
			<td>
				<input type="email" id="email"/>
				<input id="emailOverlay" type="button" value="중복 체크"/>
				<span id="emailOverlayMsg"></span>
			</td>
		</tr>
		<tr><td><input id="join" type="button" value="회원가입"/></td></tr>
	</table>
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
	
	//아이디 중복확인 버튼을 눌렀을 때 아이디 중복여부 검사
	$("#idOverlay").click(function(){
		if($("#userId").val()==""){
			$("#idOverlayMsg").html("아이디를 입력해주세요.");
			$("#idOverlayMsg").css("color","red");
			idChk=false;
		}else{
			obj.url="./idOverlay";
			obj.data={id:$("#userId").val()};
			obj.success=function(d){
				if(d.idChk ==true){
					$("#idOverlayMsg").html("사용 가능한 아이디입니다.");
					$("#idOverlayMsg").css("color","green");
					idChk=true;
				}else{
					$("#idOverlayMsg").html("이미 존재하는 아이디입니다.");
					$("#idOverlayMsg").css("color","red");
					$("#userId").val("");
					idChk=false;
				}
			};
			ajaxCall(obj);
		}
	});
	
	//비밀번호 일치 확인
	function chk(){
	    if($("#userPw").val()==$("#userPwChk").val()){
	        $("#userPwChkMsg").html("비밀번호가 일치합니다.");
	        $("#userPwChkMsg").css("color","green");
	        pwChk=true;
	    }else{
	        $("#userPwChkMsg").html("비밀번호가 일치하지않습니다..");
			$("#userPwChkMsg").css("color","red");
			pwChk=false;
	    }
	}
	
	//이메일 중복확인 버튼을 눌렀을 때 이메일 중복여부 검사
	$("#emailOverlay").click(function(){
		if($("#email").val()==""){
			$("#emailOverlayMsg").html("이메일을 입력해주세요.");
			$("#emailOverlayMsg").css("color","red");
			emailChk=false;
		}else{
			obj.url="./emailOverlay";
			obj.data={email:$("#email").val()};
			obj.success=function(d){
			if(d.emailChk ==true){
				$("#emailOverlayMsg").html("이미 존재하는 이메일입니다.");
				$("#emailOverlayMsg").css("color","red");
				$("#email").val("");
				emailChk=false;
			}else{
				$("#emailOverlayMsg").html("사용 가능한 이메일입니다.");
				$("#emailOverlayMsg").css("color","green");
				emailChk=true;
			}
		};
			ajaxCall(obj);
		}
	});
	
	//입력하지 않은 값이 있는지 확인하고 데이터 전송
	$("#join").click(function(){
		if(!idChk){
			alert("아이디 중복 체크를 실행 해 주세요!")
		}else if($("#userName").val() == ""){
			alert("필수 정보를 모두 입력해주세요.")
			$("#userName").focus();
		}else if(!pwChk){
			//비밀번호 입력 확인
			alert("필수 정보를 모두 입력해주세요.")
			$("#userPw").focus();
		}else if($("#phone").val() == ""){
			//휴대폰 번호 확인
			alert("필수 정보를 모두 입력해주세요.")
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
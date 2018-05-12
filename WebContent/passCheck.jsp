<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	#passChkBg{
		position: absolute;
		display: none;
		background-color: black;
		opacity: 0.5;
		z-index: 7;
	    top: 13%;
	    left: 18%;
	    width: 60%;
	    height: 75%;
	}
	
	#passChkPopup{
		position: absolute;
		display: none;
		background-color: #004C63;
		z-index: 8;
	    top: 30%;
	    left: 28%;
	    width: 40%;
	    height: 40%;
	}
	
	#passChkPopupClose{
		position: absolute;
		font-size: 18px;
		font-weight: 900;
		color: #FFD724;
	    left: 96%;
	    top: 2%;
		z-index: 8;
	}
</style>
</head>
<body>
	<div id="passChkBg">
	</div>
	<div id="passChkPopup">
		<div id="passChkPopupClose">X</div>
			<h1>${sessionScope.loginId}님 비밀번호를 입력해주세요.</h1>
			<table>
				<tr>
					<td>현재 비밀번호</td>
				</tr>
				<tr>
					<td><input type="password" id="memberPass"><span id="passCheckResultMsg"></span></td>
				</tr>
				<tr>
					<td><div id="memberPassChk">확인</div></td>
				</tr>
			</table>
	</div>
</body>
<script>
	$("#passChkPopupClose").click(function() {
		$("#passChkBg").css("display","none");
		$("#passChkPopup").css("display","none");
	})
	
	//확인 버튼을 눌렀을 때
	$("#memberPassChk").click(function() {
		memberPassChk();
	});

	function memberPassChk() {
		var success;
		obj.url="./memberPasswordCheck";
		obj.data={memberPass:$("#memberPass").val()};
		obj.success = function(data){
				if(data.success){
					//왜 변수에 값이 안들어가지..?
					var success = true;
					$("#memberPass").val("");
					$("#passCheckResultMsg").html("");
					$("#passChkBg").css("display","none");
					$("#passChkPopup").css("display","none");
				}else{
					$("#passCheckResultMsg").html("비밀번호 불일치");
					$("#passCheckResultMsg").css("color","red");
					var success = true;
				}
			 };
		ajaxCall(obj);
		return success;
	}

	function ajaxCall(param){
		console.log(param);
		$.ajax(param);
	}
</script>
</html>
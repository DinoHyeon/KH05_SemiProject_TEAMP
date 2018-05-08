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
<h1>아이디 찾기</h1>
<form action="./findId" method="post">
	<table>
		<tr><td>이름</td></tr>
		<tr><td><input type="text" name="idUserName"/></td></tr>
		<tr><td>생년월일</td></tr>
			<tr>
				<td>
					<select name="idYear">
						<option></option>
					</select>년
					<select name="idMonth">
						<option></option>
					</select>월
					<select name="idDay">
						<option></option>
					</select>일
				</td>
			</tr>
		<tr><td>이메일</td></tr>
		<tr><td><input type="email" name="idEmail"/></td></tr>		
		<tr><td><input id="findId" type="button" value="아이디 찾기"/></td></tr>
	</table>
</form>

<br/><br/>

<h1>비밀번호 찾기</h1>
<form action="./findPw" method="post">
	<table>
		<tr><td>이름</td></tr>
		<tr><td><input type="text" name="pwUserName"/></td></tr>
		<tr><td>아이디</td></tr>
		<tr><td><input type="text" name="pwUserId"/></td></tr>		
		<tr><td>생년월일</td></tr>
			<tr>
				<td>
					<select name="pwYear">
						<option></option>
					</select>년
					<select name="pwMonth">
						<option></option>
					</select>월
					<select name="pwDay">
						<option></option>
					</select>일
				</td>
			</tr>
		<tr><td>이메일</td></tr>
		<tr><td><input type="email" name="pwEmail"/></td></tr>		
		<tr><td>휴대폰</td></tr>
		<tr><td><input type="text" name="pwPhone"/></td></tr>	
		<tr><td><input id="findPw" type="button" value="아이디 찾기"/></td></tr>
	</table>
</form>
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
	
	//아이디 찾기
	$("#findId").click(function(){
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
	$("#findPw").click(function(){
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
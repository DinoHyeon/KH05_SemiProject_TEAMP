<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Team P</title>
<style>
	table{
        position: absolute;
        float: left;
        left: 40%;
        top: 33%;
        width: 40%;
        height: 22%;
        color: white;
	}
	
	input{
		border-width: 0px;
        margin: 5px;
        width: 40%;
        height: 79%;
	}
    
    body{
        background-color: #004D65;
    }
    
    #join{
        width: 6%;
        height: 5%;
        background-color: #FFD724;
        border-radius: 8px;
        position: absolute;
        left: 93%;
        top: 2%;
        text-align: center;
        line-height: 37px;
        font-weight: 600;
        color: #004D65;
    }
    #join:hover{
    	cursor: pointer;
    }
    
    #login{
        position: absolute;
        float: left;
        width: 16%;
        height: 5%;
        background-color: #FFD724;
        left: 40.5%;
        border-radius: 8px;
        color: #004D65;
        font-weight: 900;
        text-align: center;
        line-height: 40px;
        top: 58%;
    }
    #login:hover{
    	cursor: pointer;
    }
    
    #findIdPw{
       position: absolute;
        float: left;
        width: 16%;
        height: 5%;
        background-color: #FFD724;
        left: 40.5%;
        border-radius: 8px;
        color: #004D65;
        font-weight: 900;
        text-align: center;
        line-height: 37px;
        top: 65%;
    }
     #findIdPw:hover{
     	cursor: pointer;
     }
    
    #title{
    position: absolute;
    left: 43%;
    top: 23%;
    font-size: 50px;
    font-weight: 900;
    color: #FFD724;
    }
</style>
</head>
<body>
    <div id="join">회원가입</div>
	<div id="title">TeamP</div>
	<table>
		<tr><td>아이디</td></tr>
		<tr><td><input type="text" id="userId"/></td></tr>
		<tr><td>비밀번호</td></tr>
		<tr><td><input type="password" id="userPw"/></td></tr>
	</table>
    <div id="login">로그인</div>
	<div id="findIdPw">아이디/비밀번호 찾기</div>
</body>

<script>
	$("#login").mouseenter(function(){
	    $("#login").css("background","#00455A");
	    $("#login").css("color","#FFD724")
	    $("#login").mouseleave(function(){
	        $("#login").css("background","#FFD724");
	        $("#login").css("color","#004D65")
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
    
    $("#findIdPw").mouseenter(function(){
        $("#findIdPw").css("background","#00455A");
        $("#findIdPw").css("color","#FFD724")
        $("#findIdPw").mouseleave(function(){
            $("#findIdPw").css("background","#FFD724");
            $("#findIdPw").css("color","#004D65")
        })
    })
	
	$("#join").click(function() {
		location.href='join.jsp';
	})

	$("#findIdPw").click(function() {
		location.href='findInfo.jsp';
	})
	
	$("#login").click(function() {
		if($("#userId").val()==""){
			alert("아이디를 입력해주세요.");
			$("#userId").focus();
		}else if($("#userPw").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#userPw").focus();
		}else{
			$.ajax({
				type:"post",
				url:"./login",
				data:{
					id:$("#userId").val(),
					pw:$("#userPw").val().toLowerCase()
				},
				dataType:"json",
				success:function(data){//인자 값은 서버에서 주는 메세지
					if(data.login){
						alert($("#userId").val()+"님 TeamP에 오신걸 환영합니다.");
						if(data.memberLv=='member'||data.memberLv=='master'){
							if(data.projectIdx==0){
								location.href="main_nonGroup.jsp";
							}else{
								location.href="main_Group.jsp";
							}
						}else{
							location.href="main_Admin.jsp";
						}
					}else{
						alert("없는 아이디 또는 잘못된 비밀번호입니다.");
						("#userId").val();
						("#userPw").val();
					}
	
				},
				error:function(err){//인자 값은 서버에서 주는 메세지
					console.log(err)
				}
			});
		}
	});
	
	var msg = "${msg}"
	if(msg!=""){
		alert(msg);
		location.href="index.jsp";
	}
</script>
</html>
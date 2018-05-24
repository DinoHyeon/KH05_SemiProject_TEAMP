	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<style>


	
		/* 페이지 영역을 잡기 위한 css 설정입니다. */
	    #myInfoSection{
	        position: absolute;
			top: 15.9%;
		    width: 82.5%;
		    height: 84.1%;
			background-color: white;
	   	}
	   	
	   	#memberInfoFormBg{
	   		position: absolute;
			display: none;
			background-color: black;
			opacity: 0.7;
			z-index: 4;
			width: 100%;
			height: 100%;
	   	}
	    
	    #myInfoSection h1{
	        position: absolute;
	        color: #004D65;
	        font-weight: 900;
	        left: 46.2%;
	        top: 2.3%;
	    }
	    
	    #myInfoSection table{
	        position: absolute;
	        left: 29%;
	        top: 19%;
	        height: 52%;
	        width: 33%;
	        font-size: 19px;
	        font-weight: 1000;
	    }
	    
	    #myInfoSection table td{
	        color: #004D65;
	        font-weight: 530;
	    }
	    
	    #myInfoSection table td input[type='text'],input[type='password'],input[type='email']{
	        width: 100%;
	        height: 70%;
	    }
	    
	    #emailOverlay{
	        position: absolute;
	        left: 62.5%;
	        top: 42.5%;
	        float: left;
	        width: 6%;
	        height: 4%;
	        border-radius: 8px;
	        background-color: #00455A;
	        color: #FFD724;
	        border: none;
	        font-weight: 900;
	        text-align: center;
	        line-height: 23px;
	        font-size: 14px;
	    }
	    
	    #emailOverlayMsg{
	        position: absolute;
	        left: 69%;
	        top: 43%;
	        font-size: 12px;
	    }
	    
	    #changInfo{
	        position: absolute;
	        left: 42%;
	        top: 72%;
	        float: left;
	        width: 20%;
	        height: 6%;
	        border-radius: 8px;
	        background-color: #004D65;  
	        color: #FFD724;
	        border: none;
	        font-weight: 900;
	        text-align: center;
	        line-height: 39px;
	        font-size: 16px;
	    }
	    
	    #memberWithdrawal{
	        position: absolute;
	        left: 1%;
	        top: 92%;
	        float: left;
	        width: 8%;
	        height: 5%;
	        border-radius: 8px;
	        background-color: #FFD724;
	        color: #004D65;
	        border: none;
	        font-weight: 900;
	        text-align: center;
	        line-height: 32px;
	        font-size: 16px;
	    }
	    
	    #PwChkMsg{
	        position: absolute;
	        left: 62.5%;
	        top: 65.2%;
	        font-size: 12px;
	    }
	    
	    .pin {
  background-color: #aaa;
  display: block;
  height: 32px;
  width: 2px;
  position: absolute;
  left: 50%;
  top: 16%;
  z-index: 1;
}
.pin:after {
  background-color: #A31;
   border-radius: 50%;
  box-shadow: inset 0 0 0 1px hsla(0,0%,0%,.1),
              inset 3px 3px 3px hsla(0,0%,100%,.2),
              inset -3px -3px 3px hsla(0,0%,0%,.2),
              23px 20px 3px hsla(0,0%,0%,.15);
  content: '';
  height: 12px;
  left: -5px;
  position: absolute;
  top: -10px;
  width: 12px;
}
.pin:before {
  background-color: hsla(0,0%,0%,0.1);
  box-shadow: 0 0 .25em hsla(0,0%,0%,.1);
  content: '';

  height: 24px;
  width: 2px;
  left: 0;
  position: absolute;
  top: 8px;

}
#container{
 color: #333;
margin: 9% auto;
border:none;
width : 62%;
height: 62%;
left:30%;
box-shadow: 0 10px 10px 2px rgba(0,0,0,0.3);
 background: #eae672;


 


}
	    
	    
	</style>
	</head>
	
	<body>
		<%@include file="headerMenu.jsp"%>
		<%@include file="sideMenu.jsp"%>
		<div id="memberInfoFormBg">
		</div>
	    <div id="myInfoSection">
	       
    <div id="container">
    <i class="pin"></i>
 			<h1>[ MYINFO ]</h1>
    
			<table>
			
				<tr>
					<td>이름</td>
					<td><span id="memberInfoName"></span></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><span id="memberInfoId"></span></td>
				</tr>			
				<tr>
					<td>생년월일</td>
					<td><span id="memberBitrh"></span></td>
				</tr>			
				<tr>
					<td>이메일</td>
					<td><input id="memberEamil" onkeyup="pushEmail()" type="email" value=${dto.member_email}></td>
				</tr>			
				<tr>
					<td>휴대폰 번호</td>
					<td><input id="memberPhone" type="text" value=${dto.member_phone}></td>
				</tr>							
				<tr>
					<td>비밀번호 변경</td>
					<td>
						<input id="memberChangePass" type="password" onkeyup="passChk()"/>
					</td>
				</tr>
				<tr>
					<td>비밀번호 확인</td>
					<td>
						<input id="memberChangePassChk" type="password" onkeyup="passChk()"/>
					</td>
				</tr>
			</table>
	
			
			
				        <div id="emailOverlay">중복체크</div><span id="emailOverlayMsg"></span>
			<div id="changInfo">회원정보 수정</div>
					</div>
			<span id="PwChkMsg"></span>
	        <div id="memberWithdrawal">회원 탈퇴</div>
	    </div>
	</body>
	
	<script>
		var obj = {};
		obj.error=function(e){console.log(e+"에러발생")};
		obj.type="post";
		obj.dataType="json";
		
		//이메일 패스워드 확인 변수
		var emailChk = false;
		var pwChk = false;
		var email="";
		
		$(document).ready(function(){
			if('${sessionScope.loginId}'==""){
				alert("로그인이 필요한 서비스입니다.");
				location.href="index.jsp";
			}else{
				passCheckCss();
				$("#passChkBg").css("display","none");
				$("#memberInfoFormBg").css("display","inline");
				
				/* 생일 출력 */			
				obj.url="./infoUpdateForm";
				obj.data={};
				obj.success=function(data){
					console.log(data.membetInfo);
					$("#memberInfoName").html(data.membetInfo.member_name);
					$("#memberInfoId").html(data.membetInfo.member_Id);
					$("#memberEamil").val(data.membetInfo.member_email);
					email = data.membetInfo.member_email;
					$("#memberPhone").val(data.membetInfo.member_phone);
					
					var birth=data.membetInfo.member_birth;
					var year = birth.substring(0,4);
					var month = birth.substring(4,6);
					var day = birth.substring(6,8);
					$("#memberBitrh").html(year+"년 "+month+"월"+day+"일");
				};
				ajaxCall(obj);
			}
		});
	    
	 $("#emailOverlay").mouseenter(function(){
		        $("#emailOverlay").css("background","#FFD724");
		        $("#emailOverlay").css("color","#00455A")
		        $("#emailOverlay").mouseleave(function(){
		            $("#emailOverlay").css("background","#00455A");
		            $("#emailOverlay").css("color","#FFD724")
		        })
		    })
	    
	 $("#changInfo").mouseenter(function(){
		        $("#changInfo").css("background","#FFD724");
		        $("#changInfo").css("color","#00455A")
		        $("#changInfo").mouseleave(function(){
		            $("#changInfo").css("background","#00455A");
		            $("#changInfo").css("color","#FFD724")
		        })
		    })    
	    
	 $("#memberWithdrawal").mouseenter(function(){
		        $("#memberWithdrawal").css("background","#00455A");
		        $("#memberWithdrawal").css("color","#FFD724")
		        $("#memberWithdrawal").mouseleave(function(){
		            $("#memberWithdrawal").css("background","#FFD724");
		            $("#memberWithdrawal").css("color","#004D65")
		        })
		    })
	    
		//비빌번호 일치 여부 확인
		function passChk(){
		    if($("#memberChangePass").val()==$("#memberChangePassChk").val()){
		        $("#PwChkMsg").html("일치");
		        $("#PwChkMsg").css("color","green");
		        pwChk=true;
		    }else{
		    	 $("#PwChkMsg").html("불일치");
					$("#PwChkMsg").css("color","red");
					$("#PwChkMsg").val("");
					pwChk=false;
		    }
		}
		
		//이메일 중복검사 클릭시 실행되는 함수
		$("#emailOverlay").click(function() {
			//이메일 미입력인 경우
			if($("#memberEamil").val()==""){
				$("#emailOverlayMsg").html("미입력");
				$("#emailOverlayMsg").css("color","red");
				emailChk=false;
			}else if($("#memberEamil").val()==email){//이메일을 수정하지 않은경우
				$("#emailOverlayMsg").html("기존 사용 이메일");
				$("#emailOverlayMsg").css("color","green");
				emailChk=true;
			}else{
				obj.url="./emailOverlay";
				obj.data={email:$("#memberEamil").val()};
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
		})
		
		
		//회원 수정 버튼 클릭
		$("#changInfo").click(function(){
			if($("#memberChangePassChk").val()=="" && $("#memberChangePass").val()==""){
		    	pwChk=true;
		    };
		    
			if(!pwChk){//비밀번호 체크는 비밀번호,비밀번호 확인에 입력한 값이 같거나 공백으로 있을 경우에 true이다.
				alert("비밀번호가 일치하지 않습니다.")
				$("#memberChangePass").focus();
			}else if($("#phone").val() == ""){
				alert("변경하실 휴대폰 번호를 입력해주세요.")
				$("#memberPhone").focus();
			}else if($("#email").val() == ""){
				alert("이메일 주소를 입력해주세요.")
				$("#memberEmail").focus();
			}else if(!emailChk){
				alert("이메일 주소 중복확인을 해주세요.")
				$("#memberEmail").focus();
			}else{
				obj.url="./infoUpdate";
				obj.data={};
				obj.data.phone=$("#memberPhone").val();
				obj.data.email=$("#memberEamil").val();
				obj.data.pw=$("#memberChangePass").val();
	
				obj.success=function(data){
					if(data.success==1){
						alert("정보수정이 정상적으로 처리되었습니다.");
						//세션값에 따른 다른 메인
						if('${sessionScope.groupNum}'!='0'){
							location.href="main_Group.jsp"
						}else{
							location.href="main_nonGroup.jsp"
						}
					}else{
						alert("정보수정을 정상적으로 처리하지 못했습니다.");
					}
				}
				console.log(obj);
				ajaxCall(obj);
			}
		})
		
		//회원탈퇴
		$("#memberWithdrawal").click(function() {
			var con = confirm("정말 탈퇴 하시겠습니까?");
			if(con){//어떤 조건을 통해 비밀번호가 올바르게 입력되었는지 확인 할 수 있는가
				obj.url="./withdrawal";
				obj.data={};
				obj.data.memberId='${sessionScope.loginId}';
				obj.success=function(data){
					if(data.success){
						alert("회원탈퇴를 정상적으로 처리했습니다.");
						location.href="index.jsp";
					}else{
						alert("회원탈퇴를 실패했습니다.");
					}
				}
				ajaxCall(obj);
			}else{
				alert("회원탈퇴를 취소했습니다.");
			}
		})
		
		/* ajax 호출 함수 */
		function ajaxCall(param){
			$.ajax(param);
		}
	</script>
</html>
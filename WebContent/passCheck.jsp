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
	    
	    #passChkPopup #q{
	        color: #FFD724;
	        font-weight: 500;
	        text-align: center;
	        position: absolute;
	        top: 11%;
	        left: 25%;
	    }
		
	   #passChkPopup table{
	        position: absolute;
	        top: 30%;
	        left: 33%;
	        width: 50%;
	        height: 30%;
	    } 
	    
	    #passChkPopup td input[type='password']{
	        position: absolute;
	        top: 68%;
	        left: 6.4%;
	        width: 59%;
	        height: 32%;
	    } 
	    
	    #passChkPopup #memberPassChk{
	        position: absolute;
	        float: left;
	        width: 30%;
	        height: 12%;
	        left: 36.1%;
	        top: 74%;
	        border-radius: 8px;
	        background-color: #FFD724;
	        color: #004D65;
	        border: none;
	        font-weight: 900;
	        text-align: center;
	        line-height: 34px;
	        font-size: 16px;
	    }
	    #memberPassChk:hover{
	    	cursor: pointer;
	    }
	    
	   #passCheckResultMsg{
	        position: absolute;
	        left: 69.3%;
	        top: 75%;
	        font-size: 12px;
	        color: white;          
	        font-weight: 500
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
		#passChkPopupClose:hover{
			cursor: pointer;
		}
	</style>
	</head>
	<body>
		<div id="passChkBg">
		</div>
		<div id="passChkPopup">
			<div id="passChkPopupClose">X</div>
				<h2 id="q">현재 비밀번호를 입력해주세요.</h2>
				<table>
					<tr>
						<td id="passwordMsg"></td>
					</tr>
					<tr>
						<td><input type="password" id="memberPass"><span id="passCheckResultMsg"></span></td>
					</tr>
				</table>
	            <div id="memberPassChk">확인</div>
		</div>
	</body>
	<script>
		var pwChkResult = false;
 		$("#passChkPopupClose").click(function() {
			$("#passChkBg").css("display","none");
			$("#passChkPopup").css("display","none");
			$("#memberInfoFormBg").css("display","none");
			if('${sessionScope.menuName}'=='main'){
				if('${sessionScope.groupNum}'=='0'){
					location.href="main_nonGroup.jsp";
				}else{
					location.href="main_Group.jsp";
				}
			}else if('${sessionScope.menuName}'=='myInfo'){
				obj.url="./createMenuSession";
				obj.data={menuName:"main"};
				obj.success = function(data){
					if('${sessionScope.groupNum}'=='0'){
						location.href="main_nonGroup.jsp";
					}else{
						location.href="main_Group.jsp";
					}
					 };
				ajaxCall(obj);
			}else if('${sessionScope.menuName}'=='notice'){
				location.href='/SemiProject_TeamP/adminList?pageNo=${sessionScope.pageNo}';
			}else if('${sessionScope.menuName}'=='plan'){
				location.href='plan.jsp';
			}else if('${sessionScope.menuName}'=='fileBbs'){
				location.href ='/SemiProject_TeamP/fileList?pageNo=${sessionScope.pageNo}';
			}else if('${sessionScope.menuName}'=='groupBbs'){
				location.href ='/SemiProject_TeamP/groupList?pageNo=${sessionScope.pageNo}';
			}else if('${sessionScope.menuName}'=='comunityBbs'){
				location.href ='/SemiProject_TeamP/comunityList?pageNo=${sessionScope.pageNo}';
			}
		}) 
		
	    $("#memberPassChk").mouseenter(function(){
	        $("#memberPassChk").css("background","#00455A");
	        $("#memberPassChk").css("color","#FFD724")
	        $("#memberPassChk").mouseleave(function(){
	            $("#memberPassChk").css("background","#FFD724");
	            $("#memberPassChk").css("color","#004D65")
	        })
	    }) 
		
		//비밀번호 체크 클릭
		function passCheckCss() {
			$("#passChkBg").css("display","inline");
			$("#passChkPopup").css("display","inline");
		}
		
		//확인 버튼을 눌렀을 때
		$("#memberPassChk").click(function() {
				obj.url="./memberPasswordCheck";
				obj.data={memberPass:$("#memberPass").val()};
				obj.success = function(data){
						if(data.success){
							$("#memberPass").val("");
							$("#passCheckResultMsg").html("");
							$("#passChkBg").css("display","none");
							$("#passChkPopup").css("display","none");
							$("#memberInfoFormBg").css("display","none");
							$("#memberWithdrawal").bind("click");
						}else{
							$("#passCheckResultMsg").html("불일치");
							$("#passCheckResultMsg").css("color","red");
						}
					 };
				ajaxCall(obj);
		});
	
		
	
		function ajaxCall(param){
			console.log(param);
			$.ajax(param);
		}
	</script>
</html>
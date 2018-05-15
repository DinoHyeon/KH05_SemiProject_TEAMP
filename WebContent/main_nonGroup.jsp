<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Team P</title>
<style>
	/* 페이지 영역을 잡기 위한 css 설정입니다. */
    #page{
       position: absolute;
		top: 15.9%;
	   width: 82.5%;
	    height: 84.1%;
		background-color: white;
   	}
   	
   	/* 팝업페이지가 나왔을 때 전체페이지를 검은색으로 한번 덮는다. */
	#bg{
		position: absolute;
		display: none;
		background-color: black;
		opacity: 0.7;
		z-index: 3;
		width: 100%;
		height: 100%;
	}
	
	/* 팝업 내용 */
	#popupContent{
		position: absolute;
	    display: none;
	    z-index: 3;
	    top: 13%;
	    left: 18%;
	    width: 60%;
	    height: 75%;
	    background-color: #004C63;
	}
	
	/* 그룹 초대 리스트 팝업 */
	#inviteListPopup{
		position: absolute;
	    display: none;
	    z-index: 3;
	    top: 13%;
	    left: 18%;
	    width: 60%;
	    height: 75%;
	    background-color: #004C63;
	}
	
     #inviteListPopup table{
         position: absolute;
         top: 26%;
         left: 7.8%;
         width: 84%;
         height: 60%;
         background-color: white;
         border-collapse: collapse;
         text-align: center;
     }
     
     #inviteListPopup table td{
         border: 2px solid #004C63;
         vertical-align: text-top;
     }
     
     #inviteListPopup h3{
         position: absolute;
         top: 87%;
         left: 16.6%;
         text-align: center;
         color: #FFD724;
     }
     #inviteListPopup #groupNameTitle{
         position: absolute;
         top: 22%;
         left: 14%;
         text-align: center;
         color: #FFD724;
     }
     #inviteListPopup #groupMasterNameTitle{
         position: absolute;
         top: 22%;
         left: 31.4%;
         text-align: center;
         color: #FFD724;
     }
     #inviteListPopup #inviteContentTitle{
         position: absolute;
         top: 22%;
         left: 46.8%;
         text-align: center;
         color: #FFD724;
     }
     #inviteListPopup #inviteDateTitle{
         position: absolute;
         top: 22%;
         left: 58.9%;
         text-align: center;
         color: #FFD724;
     }
     #inviteListPopup #inviteResultTitle{
         position: absolute;
         top: 22%;
         left: 75.4%;
         text-align: center;
         color: #FFD724;
     }

	.mainPopupClose{
		position: absolute;
		font-size: 18px;
		font-weight: 900;
		color: #FFD724;
		left: 97%;
		top: 2%;
	}
	

    #create {
        position: absolute;
        float: left;
        width: 12%;
        height: 6%;
        background-color: #FFD724;
        left: 38%;
        border-radius: 8px;
        color: #004D65;
        font-weight: 900;
        text-align: center;
        line-height: 37px;
        top: 52%;
    }


	
	#inviteListBtn{
        position: absolute;
        float: left;
        width: 12%;
        height: 6%;
        background-color: #FFD724;
        left: 51.5%;
        border-radius: 8px;
        color: #004D65;
        font-weight: 900;
        text-align: center;
        line-height: 37px;
        top: 52%;
    }
    
    #main_nonGroupMsg{
        text-align: center;
        position: absolute;
        top: 33%;
        left: 32.5%;
    }
    
    .mainPopupTitle{
        text-align: center;
        color: #FFD724;
        position: absolute;
        top: 4%;
        left: 42%;
    }
    
    /* 그룹 생성 팝업 CSS */
    #popupContent table{
            position: absolute;
            top: 24%;
            left: 38%;
            height: 47%;
            width: 25.4%;
        }
    
    #popupContent table td{
        color: white;
        font-weight: 530;
    }
    
    #popupContent table td input{
        width: 100%;
        height: 91%;
    }
    
    #popupContent table td span[id='groupMasterName']{
		color: #FFD724;
		font-weight: 550;
		font-size: 15px;
    }
    
    #createBnt{
        position: absolute;
        float: left;
        width: 25.1%;
        height: 7%;
        background-color: #FFD724;
        left: 38.4%;
        border-radius: 8px;
        color: #004D65;
        font-weight: 900;
        font-size: 16px;
        text-align: center;
        line-height: 37px;
        top: 76%;
        border: none;
    }
</style>
</head>
<body>

	<div id="bg">

	</div>
	
	
	        <div id="popupContent">
                <div class="mainPopupClose">X</div>
                <h1 class="mainPopupTitle">그룹 생성</h1>
                <form action="./groupCreate" method="post">
                    <table>
                        <tr>
                            <input name="groupHeadName" type="hidden" value= ${sessionScope.loginId}>
                            <td>그룹장 : <span id="groupMasterName">${sessionScope.loginId}</span></td>
                        </tr>
                        <tr>
                            <td>그룹명</td>
                        </tr>
                        <tr>
                            <td><input name="groupName" type="text"/></td>
                        </tr>
                        <tr>
                            <td>프로젝트 기간 - 시작</td>
                        </tr>								
                        <tr>
                            <td><input name="startDate" type="date"
                            /></td>
                        </tr>
                    <tr>
                            <td>프로젝트 기간 - 종료</td>
                        </tr>								
                        <tr>
                            <td><input name="endDate" type="date"/></td>
                        </tr>							
                    </table>
                    <input id="createBnt" type="button" value="그룹 생성">
                </form>
        </div>
			
    <div id="inviteListPopup">
        <h1 class="mainPopupTitle">그룹 초대</h1>
        <div class="mainPopupClose">X</div>
        <div id="groupNameTitle">그룹명</div>
        <div id="groupMasterNameTitle">그룹장</div>
        <div id="inviteContentTitle">내용</div>
        <div id="inviteDateTitle">날짜</div>
        <div id="inviteResultTitle">수락/거절</div>
        <table id="inviteListBody">
        </table>	
        <h3>※ 한 개의 그룹에만 가입할 수 있으니 신중하게 초대를 수락해주세요 ※</h3>
    </div>
		
		
	<%@include file="headerMenu.jsp"%>
	<%@include file="sideMenu.jsp"%>
    <div id="page">
		<h3 id="main_nonGroupMsg">현재 가입되어 있는 그룹이 없어요 :(<br>
            멋진 그룹을 구성하거나 초대를 수락하는 건 어떨까요?
        </h3>
		<div id="create">그룹 생성</div>
		<div id="inviteListBtn">초대 목록</div>
    </div>
</body>
<script>
	var content ="";

	var msg = '${msg}';
	
	if(msg == "그룹 생성에 실패했습니다."){
		alert(msg);
		location.reload();
	}else if(msg == "그룹 생성에 성공했습니다."){
		alert(msg);
		location.href="main_Group.jsp";
	}
	
	var obj = {};
	var idx;//idex값을 저장할 전역 변수
	obj.type="POST";
	obj.dataType="JSON";
	obj.error=function(e){console.log(e)};

	$(document).ready(function(){
		if('${sessionScope.loginId}'==""){
			alert("로그인이 필요한 서비스입니다.");
			location.href="index.jsp";
		}
	});
    
    $("#create").mouseenter(function(){
        $("#create").css("background","#00455A");
        $("#create").css("color","#FFD724")
        $("#create").mouseleave(function(){
            $("#create").css("background","#FFD724");
            $("#create").css("color","#004D65")
        })
    })
    
    $("#inviteListBtn").mouseenter(function(){
        $("#inviteListBtn").css("background","#00455A");
        $("#inviteListBtn").css("color","#FFD724")
        $("#inviteListBtn").mouseleave(function(){
            $("#inviteListBtn").css("background","#FFD724");
            $("#inviteListBtn").css("color","#004D65")
        })
    })
    
    $("#createBnt").mouseenter(function(){
        $("#createBnt").css("background","#00455A");
        $("#createBnt").css("color","#FFD724")
        $("#createBnt").mouseleave(function(){
            $("#createBnt").css("background","#FFD724");
            $("#createBnt").css("color","#004D65")
        })
    })
    
	$("#create").click(function() {
		$("#bg").css("display","inline");
		$("#popupContent").css("display","inline");
	})
	
	$(".mainPopupClose").click(function() {
		$("#bg").css("display","none");
		$("#inviteListBody").empty();
		$("#inviteListPopup").css("display","none");
		$("#popupContent").css("display","none");
	})
	
	$("#createBnt").click(function() {
		var startDay = new Date($("input[name='startDate']").val());
		var endDay = new Date($("input[name='endDate']").val());
		/* 
		1. 프로젝트 명이 입력되어 있지 않은 경우
		2. 프로젝트 기간(시작, 종료)일이 입력되어 있지 않은 경우
		3. 프로젝트 기간이 안맞는 경우
		
		1,2,3의 경우가 아니라면 아이디 submit의 type을 submit으로 변경한다
		*/
		if($("input[name='groupName']").val()==""){
			alert("그룹명을 입력해주세요.")
			$("input[name='groupName']").focus();
		}else if($("input[name='startDate']").val()==""){
			alert("프로젝트 시작일을 입력해주세요.")
			$("input[name='startDate']").focus();			
		}else if($("input[name='endDate']").val()==""){
			alert("프로젝트 종료일을 입력해주세요.")
			$("input[name='endDate']").focus();			
		}else if(startDay>endDay){
			alert("프로젝트 시작일을 재입력해주세요.")
			$("input[name='startDate']").focus();		
		}else{
			$("#createBnt").attr("type","submit");
		}
	})
	
	//그룹 초대 확인
	$("#inviteListBtn").click(function() {
		//오늘
		$("#bg").css("display","inline");
		$("#inviteListPopup").css("display","inline");
		
		inviteListCall();
	})
	
	//거절 버튼을 클릭했을 때) 초대번호만 있으면 된다.
	$(document).on('click','.refuse', function() {
		var inviteIdx = $(this).attr("id");
		var con = confirm("초대를 거절 하시겠습니까?");
		if(con){
			obj.url="./inviteRefuse";
			obj.data={inviteIdx:inviteIdx};
			obj.success = function(data){
				console.log(data);
				if(data.result){
					alert("초대 거절을 성공했습니다");
					inviteListCall();
				}else{
					alert("초대 거절에 실패했습니다");
				}
			};
			ajaxCall(obj);
		}
	});

	//수락 버튼을 클릭했을 때) 그룹번호만 있으면 된다.
	$(document).on('click','.accept', function() {
		var groupIdx = $(this).attr("id");
		var con = confirm("초대를 수락 하시겠습니까?");
		if(con){
			obj.url="./inviteAccept";
			obj.data = {groupIdx:groupIdx};
			obj.success = function(data){
				if(data.result){
					alert("축하드립니다. 그룹가입이 되셨습니다 !");
					location.href="main_Group.jsp"
				}else{
					alert("그룹가입에 실패했습니다 TT..");
				}
			};
			ajaxCall(obj);
		}
	});
	
	
	function inviteListCall(){
		//ajax 실행
		obj.url="./groupInviteList";
		obj.data={};
		obj.success = function(data) {
			 
			  $("#inviteListBody").empty();
			 
			 data.list.forEach(function(item,index){
				 content +="<tr>";
				 content +="<td>"+item.group_name+"</td>";//그룹명
				 content +="<td>"+item.from_memberId+"</td>";//그룹장
				 content +="<td>"+item.invite_content+"</td>";//내용
				 content +="<td>"+item.invite_date+"</td>";//날짜
				 content +="<td>"+"<input class='accept' type='button' id="+item.group_idx+" value='수락'>"+"<input class='refuse' type='button' id="+item.invite_idx+" value='거절'>"+"</td>";//수락 거절
				 content +="</tr>";
				 
				 $("#inviteListBody").append(content);
				 
				 content="";
		      });   
		}
		ajaxCall(obj);
	}
	
	function ajaxCall(param){
		console.log(param);
		$.ajax(param);
	}
</script>
</html>
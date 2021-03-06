<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
        <style>
			body{
				margin : 0px;
			}
		
            #header{
                position: absolute;
                width: 82.5%;
                height: 8%;
                background-color: white;
            }
            
            #header #TeamPTitle{
           		position: absolute;
				top: 11%;
				left: 2%;
				font-weight: 900;
				color : #566A70;
                background-color: white;
                font-size: 50px;
            }
            
            #navi{
                position: absolute;
                background-color:white;
                left : 56%;
                top : 15.7%;
                width: 45%;
            }
            
            
            #navi button{
                border: none;
                background-color:white;
                font-size: 14px;
                padding : 3%;
                color : #004C63;
                border : 1px solid white;
            }
            
			/* 가입한 그룹이 있을 경우 나오는 header */
            #group{
                position: absolute;
                background-color: #566A70;
                width: 82.5%;
                top: 8%;
                height: 7.9%;
                z-index: 1;
            }
            
            #group #groupPeriod{
            	position: absolute;
                left : 1.5%;
                top : 26.5%;   
                color: white;      
                font-size: 25px;
                font-weight: 700;    	
            }
            
            #group #groupDday{
			    position: absolute;
			    left: 18.5%;
			    top: 45.5%;
			    color: white;
			    font-size: 16px;
			    font-weight: 600;                      	
            }
            
            #group #groupProgress{
            	position: absolute;
                left : 80%;
                top : 22.5%;    
				color: white;  	     
                font-size: 25px;
                font-weight: 700;                     	
            }                        
            
            /* 가입한 그룹이 없을 경우 나오는 header */
            #Nongroup{
			    position: absolute;
			    background-color: #566A70;
			    width: 82.5%;
			    top: 8%;
			    height: 7.9%;
			    z-index: 2;
			    text-align: center;
			}
            
            #group #groupfinish{
            	position: absolute;
                background-color: #FFD724;
                color: #004C63;
                width: 10%;
                height: 60%;
                top: 18.5%;
                left: 79.5%;
                text-align: center;
                line-height: 33px;
                font-weight: 900;
                border-radius: 8px;
               	display: none;
            }
            
            /* 그룹정보 버튼 */
            #groupInfo{
                position: absolute;
                background-color: #FFD724;
                color: #004C63;
                width: 8%;
                height: 60%;
                top: 18.5%;
                left: 91%;
                text-align: center;
                line-height: 33px;
                font-weight: 900;
                border-radius: 8px;
               	display: block;
            }
            #groupInfo:hover{
            	cursor: pointer;
            }
                       
            /* 그룹관리 버튼 */
           #groupManage{
                position: absolute;
                background-color: #FFD724;
                color: #004C63;
                width: 8%;
                height: 60%;
                top: 18.5%;
                left: 91%;
                text-align: center;
                line-height: 33px;
                font-weight: 900;
                border-radius: 8px;
               	display: block;
            }
            #groupManage:hover{
            	cursor: pointer;
            	background-color: #004C63;
            	color: #FFD724;
            }
            
            /* 팝업배경 */
            #groupBg{
		        position: absolute;
				display: none;
				background-color: black;
				opacity: 0.7;
				z-index: 3;
				width: 100%;
				height: 100%;
            }
            
            /* 그룹정보 팝어 */
            #popupContenMember{
				position: absolute;
			    display: none;
			    z-index: 4;
			    top: 13%;
			    left: 18%;
			    width: 60%;
			    height: 75%;
			    background-color: #004C63;
			}
			
            
            /* 그룹관리 팝업 */
         	#popupContentMaster{
				position: absolute;
			    display: none;
			    z-index: 4;
			    top: 13%;
			    left: 18%;
			    width: 60%;
			    height: 75%;
			    background-color: #004C63;
			}
		
			#invite{
        		position: absolute;
			    font-size: 13px;
			    font-weight: 900;
			    color: #FFD724;
			    top: 49.5%;
			    left: 69.2%;
			}
			#invite:hover{
				cursor: pointer;
				text-decoration: underline; 
			}
			
			#groupmemberName{
				position: absolute;
			    font-size: 13px;
			    font-weight: 600;
			    color: white;
			    top: 49.5%;
			    left: 32%;
			}
		
			#groupMemberList{
				position: absolute;
				border: 4px solid #FFD724;
				overflow: auto;
				width: 40%;
				height: 30%;
				top: 53%;
				left: 32%;
			}
			
			#groupInquiryMemberList{
				position: absolute;
				border: 4px solid #FFD724;
				overflow: auto;
				width: 40%;
				height: 30%;
				top: 53%;
				left: 32%;
			}
			
			#groupMemberList > td{
				border: none;
			}
			
			/* 멤버초대 팝업 */
			#popupContentInvite{
				position: absolute;
			    display: none;
			    z-index: 5;
			    top: 13%;
			    left: 30%;
			    width: 35%;
			    height: 45%;
			    background-color: #004C63;
			}
			
			/* 닫기버튼 */
			.headerPopupClose{
				position: absolute;
				font-size: 18px;
				font-weight: 900;
				color: #FFD724;
				left: 97%;
				top: 2%;
				display: none;
				z-index: 6;
				cursor: pointer;				
			}
			#g{
				color: white;
				margin-left: 45%;
			}
			#groupInfoManage{
				margin-left: 35%;
				padding: 10 10;
				margin-top: 5%;
				
			}
			/*그룹 정보수정  */
			#changeGroupInfo{
				color: white;
				margin-left: 40%;
				margin-top: 1.5%;
				position: absolute;
                background-color: #FFD724;
                color: #004C63;                
                text-align: center;
                line-height: 33px;
                font-weight: 900;
                border-radius: 8px;
               	display: block;
			}			
			#changeGroupInfo:hover {				 
			 	cursor: pointer;  
			 	background-color: #004C63;
            	color: #FFD724;     		
			}				
			#out{
				color: white;
				text-align: center;
			}
			#out:hover{				
				cursor: pointer;
				background-color: gray;				
			}
			#groupMemberId{
				color: white;
			}
			#groupDel{
				color: white;
           		margin-left: 55%;
            	margin-top: 1.5%;
            	position: absolute;
                background-color: #FFD724;
                color: #004C63;                
                text-align: center;
                line-height: 33px;
                font-weight: 900;
                border-radius: 8px;
                display: block;

			}
			#groupDel:hover{
				cursor: pointer;
				text-decoration: none;
				color: #FFD724;
				background-color: #004D65;
			}			
			#invitetable{
				margin-left: 20%;
				margin-top: 10%;			
			}
			#inviteinput{
				margin-left: 33.5%;
			}
			#inviteinput:hover {
				cursor: pointer;
			}
			#withdrawal{
				color: white;
				margin-left: 67%;
				position: absolute;
                background-color: #FFD724;
                color: #004C63;                
                text-align: center;                
                font-weight: 900;
                border-radius: 8px;
               	display: block;
			}
			#withdrawal:hover{
				color: white;			
				cursor: pointer;	
				text-decoration: none;
				color: #FFD724;
				background-color: #004C63;
			}
			#groupInfoInquiry{
				margin-left: 35%;
				margin-top: 5%;	
			}	
			#g1{
				color: white;
				margin-left: 40%;		
			}				
			#navi>button:hover{
				background-color: #F6F6F6;
				cursor: pointer;
			}
			
			   
        </style>
</head>
<body>
	<%@include file="passCheck.jsp"%>

	 <div id="header">
	 		<div id="TeamPTitle">TeamP</div>
            <div id="navi">
           		<button class="menu" id="main">메인</button>
                <button class="menu" onclick="location.href='/SemiProject_TeamP/memberInfoForm.jsp'" id="myInfo">내정보</button>
                <button class="menu" onclick="location.href='/SemiProject_TeamP/adminList?pageNo=1'" id="notice">공지사항</button>
                <button class="menu" onclick="location.href='/SemiProject_TeamP/plan.jsp'" id="plan">일정</button>
                
                 <c:if test = "${sessionScope.memberLv == 'admin' }">
                   <button class="menu" onclick="location.href ='/SemiProject_TeamP/adminFileBbsList?pageNo=1'" id="fileBbs">파일게시판</button>
                </c:if>
                
                <c:if test = "${sessionScope.memberLv != 'admin'}">
                   <button class="menu" onclick="location.href ='/SemiProject_TeamP/fileList?pageNo=1'" id="fileBbs">파일게시판</button>
                </c:if>
                
                 <!-- 관리자 로그인시 adminGroupList로 분기시켜 모든 그룹의 글 보기 및 삭제 가능 하게 하기-->
                <c:if test="${sessionScope.memberLv == 'admin'}">
                    <button class="menu" onclick="location.href ='/SemiProject_TeamP/adminGroupBbsList?pageNo=1'" id="groupBbs">그룹게시판</button>
                </c:if>
                
                <!-- 관리자가 아니면(그룹장 및 그룹원) 자신이 속한 그룹의 글들만 조회 가능 -->
                <c:if test="${sessionScope.memberLv != 'admin'}">
                    <button class="menu" onclick="location.href ='/SemiProject_TeamP/groupList?pageNo=1'" id="groupBbs">그룹게시판</button>
                </c:if>
                
                 <button class="menu" onclick="location.href ='/SemiProject_TeamP/comunityList?pageNo=1'" id="comunityBbs">의견나눔게시판</button>
            </div>
        </div>
        
        
        <!-- 가입한 그룹이 없을 경우 나오는 header -->
      	<div id="Nongroup">
			<h3 style="color: white;">현재 참여하고 있는 그룹이 없습니다.</h3>
	 	</div>
        <!-- 가입한 그룹이 있을 경우 나오는 header -->
        <div id="group">
            <div id="groupInfo">그룹 정보</div><!-- 현재 로그인한 회원의 레벨이 member인 경우 -->
            <div id="groupManage">그룹 관리</div><!-- 현재 로그인한 회원의 레벨이 master인 경우 -->
            <div id="groupfinish">프로젝트 완료</div>
            <div id="groupPeriod"></div><!-- 프로젝트 기간 -->
            <div id="groupDday"></div><!-- 프로젝트 남은 기간 -->
            <div id="groupProgress"></div><!-- 프로젝트 달성률 -->
        </div>
        
        
       	<div id="groupBg"></div><!-- 팝업이 띄워졌을 때 홈페이지에 깔리는 불투명한 배경 -->
       	
       	
       	<div id="popupContentMaster"><!-- 그룹장일 때 나오는 팝업 창 -->
			<div class="headerPopupClose">X</div>
			<h2 id="g">그룹 관리</h2>
			<table id="groupInfoManage">
				<tr>
					<td id="g">그룹장 </td>
					<td id="g"><span id="groupInfoMasterName"></span></td>
				</tr>
				<tr>
					<td id="g">그룹명</td>
					<td id="g"><input type='hidden' id="groupInfoIdx"><input id="groupInfoName" type="text"/></td>
				</tr>				
				<tr>
					<td id="g">프로젝트 기간 - 시작</td>
					<td><input id="groupInfoStartDate" type="date"/></td>
				</tr>					
				<tr>
					<td id="g">프로젝트 기간 - 종료</td>
					<td><input id="groupInfoEndDate" type="date"/></td>
				</tr>										
			</table>
			<div id="groupmemberName">그룹원</div>
			<table id="groupMemberList">
			</table>
			<div id="invite">초대</div>
			<div id="changeGroupInfo">그룹정보 수정</div>
			<div id="groupDel">그룹 삭제</div>
		</div>
		
		
		<!-- 그룹 초대 팝업 -->
		<div id="popupContentInvite">
			<div class="headerPopupClose">X</div>
			<h2 id="g1">그룹원 초대</h2>
			<table id="invitetable">
				<tr>
					<td id="g">그룹명</td>
					<td id="g"><span id="inviteGroupName"></span></td>
				</tr>
				<tr>
					<td id="g">아이디</td>
					<td><input id="inviteMember" type="text"/><input type="button" onclick="inviteMemberChk()" value="중복확인"/><span id="inviteMemberChkMsg"></span></td>
				</tr>
				<tr>
					<td id="g">초대 내용</td>
					<td>
						<textarea id="inviteMsg" rows="5" cols="28" style="resize: none"></textarea>
					</td>
				</tr>
			</table>
			<input id="inviteinput" type="button" value="초대" onclick="groupInvite()">
			
		</div>
        
        <!-- 그룹원일 때 나오는 창 -->
        <div id="popupContenMember"><!-- 그룹장일 때 나오는 팝업 창 -->
			<div class="headerPopupClose">X</div>
			<h2 id="g">그룹 정보</h2>
			<table id="groupInfoInquiry">
				<tr>
					<td id="g">그룹장</td>
					<td id="g"><span id="groupInfoInquiryMasterName"></span></td>
				</tr>
				<tr>
					<td id="g">그룹명</td>
					<td id="g"><input type='hidden' id="groupInfoIdx"><span id="groupInfoInquiryName"></span></td>
				</tr>			
				<tr>
					<td id="g">프로젝트 기간 - 시작</td>
					<td><input id="groupInfoInquiryStartDate" type="date"/></td>
				</tr>					
				<tr>
					<td id="g">프로젝트 기간 - 종료</td>
					<td><input id="groupInfoInquiryEndDate" type="date"/></td>
				</tr>									
			</table>
			<div id="groupmemberName">그룹원</div>
			<table id="groupInquiryMemberList">
			</table>
			<div id="withdrawal">탈퇴</div>
		</div>
</body>
<script>
	var path = window.location.pathname;
	var loaction = "";
	if(path.indexOf('WriteForm')>-1||path.indexOf('writeForm')>-1){
		loaction= ".";
	}
	
	console.log(path.indexOf('WriteForm'));
	var groupIdx = '${sessionScope.groupNum}';
	var groupName = "";
	var groupMemberContent = "";
	var groupStartDay="";
	var groupEndDay="";
	var groupDday="";
	
	var totalPlan=0;
	var finishPlan=0;
	var groupProgress=0;
	
	var obj = {};
	var idx;//idex값을 저장할 전역 변수
	obj.type="POST";
	obj.dataType="JSON";
	obj.error=function(e){console.log(e)};


	$(document).ready(function() {
		var currentDate = new Date();
		var currentDateYear = currentDate.getFullYear();
		var currentDateMonth = currentDate.getMonth()+1;
		var currentDateDay =  currentDate.getDate();
		
		var currentDay = currentDateYear+"-"+currentDateMonth+"-"+currentDateDay;
		//그룹가입 여부에 따른 header
		if(groupIdx!=0){
			//그룹이 있을 경우 nongroup를 none으로
			$("#Nongroup").css("display","none");
			//상단 부분 출력
			obj.url=loaction+"./headerMenuInfo";
			obj.data={};
			obj.success = function(data){
				groupStartDay=data.groupInfo.group_StrartDay;//시작일
				groupEndDay=data.groupInfo.group_EndDay;//종료일
				groupDday=BetweenDate(currentDay,groupEndDay);//남은 기간
				
				if(groupDday>0){
					$("#groupPeriod").html(groupDday+"일 남았습니다.");
				}else if(groupDday<0){
					$("#groupPeriod").html(Math.abs(groupDday)+"일 지났습니다.");
				}
				
				$("#groupDday").html(groupStartDay+" ~ "+groupEndDay);
				
				data.planList.forEach(function(item,index){
					totalPlan+=1;
					if(item.plan_state=='완료'){
						finishPlan+=1;
					}
				 })
				 
				 console.log("전체 일정 : "+totalPlan);
				if(finishPlan!=0){
					groupProgress=finishPlan/totalPlan*100;
				}
				console.log(groupProgress);
				$("#groupProgress").html(Math.floor(groupProgress)+" %  진행");
				
				if(groupProgress == 100 && groupDday<=0){
					$("#groupfinish").css("display","block");
					$("#groupProgress").css("left",68+"%");
				}
			}
			ajaxCall(obj);
		}else{
			//그룹이 없을 경우 nongroup를 inline으로
			$("#Nongroup").css("display","inline")
		}
		
		
		//회원 등급에 따른 header버튼 변경
		if('${sessionScope.memberLv}'=="master"){
			//master(그룹장)인 경우 
			$("#groupInfo").css("display","none")
		}else{
			//member(그룹원)인 경우 
			$("#groupManage").css("display","none")
		}
		
		if('${sessionScope.menuName}'!=""){
			switch ('${sessionScope.menuName}') {
			case "main":
				$("#main").css("font-weight","600");
				break;
			case "myInfo":
				$("#myInfo").css("font-weight","600");
				break;
			case "notice":
				$("#notice").css("font-weight","600");
				break;
			case "plan":
				$("#plan").css("font-weight","600");
				break;
			case "fileBbs":
				$("#fileBbs").css("font-weight","600");
				break;
			case "groupBbs":
				$("#groupBbs").css("font-weight","600");
				break;	
			case "comunityBbs":
				$("#comunityBbs").css("font-weight","600");
				break;					
			}
		}
	})
	
	//메뉴 클릭시 세션부여
	$(".menu").click(function() {
		obj.url=loaction+"./createMenuSession";
		obj.data={};
		obj.data={menuName:$(this).attr("id")};
		obj.success = function(data) {
			
		}
		ajaxCall(obj);
	})
	
	$("#main").click(function() {
		if('${sessionScope.groupNum}'!=0){
			location.href="main_Group.jsp";
		}else{
			location.href="main_nonGroup.jsp";
		}
	})
	
	//그룹원)그룹정보 버튼을 클릭했을 경우
	$("#groupInfo").click(function() {
		$("#groupBg").css("display","inline");
		$("#popupContenMember").css("display","inline");
		$(".headerPopupClose").css("display","inline");
		groupInfoLoad();
	})
	
	//그룹장)그룹관리 버튼을 클릭했을 경우
	$("#groupManage").click(function() {
		passCheckCss();
		//그룹정보 호출 함수
		groupInfoLoad();
		$("#groupBg").css("display","inline");
		$("#popupContentMaster").css("display","inline");
		$(".headerPopupClose").css("display","inline")
		
	});
	
	//초대 버튼을 클릭한 경우
	$("#invite").click(function() {
		$("#popupContentMaster").css("display","none");
		$("#inviteGroupName").html(groupName);
		$("#popupContentInvite").css("display","inline");
	})
	
	var idChk=false;
	//초대 회원 아이디 체크
	function inviteMemberChk() {
		if($("#inviteMember").val()==""){
			alert("아이디를 입력해주세요.");
			$("#inviteMemberChkMsg").html("초대 불가능");
			$("#inviteMemberChkMsg").css("color","red");
			idChk=false;
		}else{
			obj.url=loaction+"./inviteMemberIdChk";
			obj.data={};
			obj.data={inviteMemberId:$("#inviteMember").val()};
			obj.success = function(data) {
				if(!data.result){
					 alert("이미 그룹이 있거나 회원등록이 되어있지 않은 아이디입니다.");
					 $("#inviteMemberChkMsg").html("초대 불가능");
					 $("#inviteMemberChkMsg").css("color","red");
					 idChk=false;
				}else{
					$("#inviteMemberChkMsg").html("초대 가능");
					$("#inviteMemberChkMsg").css("color","green");
					idChk=true;
				}
			}
			ajaxCall(obj);
		}
	}
	
	//초대하기 버튼을 클릭한 경우
	function groupInvite() {
		//모든 값이 입력되어 있는지 아이디 중복검사를 했는지 확인
		if($("#inviteMember").val()==""){
			alert("초대할 멤버 아이디를 입력해주세요.");
			$("#inviteMember").focus();
		}else if(!idChk){
			alert("초대할 멤버 아이디 확인버튼을 클릭 해주세요.");
			$("#inviteMember").focus();
		}else if($("#inviteMsg").val()==""){
			alert("초대 내용을 입력해주세요.");
			$("#inviteMsg").focus();
		}else{
			obj.url=loaction+"./groupInvite";
			obj.data={};
			obj.data={
					inviteMemberId:$("#inviteMember").val(),
					inviteGroupIdx:groupIdx,
					inviteGroupName:$("#inviteGroupName").val(),
					inviteMsg:$("#inviteMsg").val()
					};
			obj.success = function(data) {
				if(data.success){
					alert($("#inviteMember").val()+"님을 초대했습니다.");
					$("#inviteMember").val("");
					$("#inviteGroupName").val("");
					$("#inviteMsg").val("");
					$("#inviteMemberChkMsg").html("");
					$("#popupContentInvite").css("display","none");
					$("#popupContentMaster").css("display","inline");
				}
			}
			ajaxCall(obj);
		}
	}
	
	//닫기
	$(".headerPopupClose").click(function() {
		if($("#popupContentMaster").css("display")!="none"){
			$("#groupBg").css("display","none");
			$("#popupContentMaster").css("display","none");
			$("#popupContenMember").css("display","none");
		}else{
			$("#popupContentInvite").css("display","none");
			$("#popupContentMaster").css("display","inline");
		}
		
		if($("#popupContenMember").css("display")!="none"){
			$("#groupBg").css("display","none");
			$("#popupContenMember").css("display","none");
			$("#popupContentMaster").css("display","none");
		}

	})
	
	
	//그룹정보 호출
	function groupInfoLoad() {
		obj.url=loaction+"./groupDetail";
		obj.data={};
		obj.data={groupIdx:groupIdx};
		obj.success = function(data){
			console.log(data.groupInfo);
			groupName = data.groupInfo.group_name;
			//그룹관리
			$("#groupInfoMasterName").html(data.groupInfo.member_id);
			$("#groupInfoIdx").val(data.groupInfo.group_idx);
			$("#groupInfoName").val(data.groupInfo.group_name);
			$("#groupInfoStartDate").val(data.groupInfo.group_StrartDay);
			$("#groupInfoEndDate").val(data.groupInfo.group_EndDay);
			
			//그룹정보
			$("#groupInfoInquiryMasterName").html(data.groupInfo.member_id);
			$("#groupInfoInquiryIdx").val(data.groupInfo.group_idx);
			$("#groupInfoInquiryName").html(data.groupInfo.group_name);
			$("#groupInfoInquiryStartDate").val(data.groupInfo.group_StrartDay);
			$("#groupInfoInquiryEndDate").val(data.groupInfo.group_EndDay);
			//그룹 멤버 리스트
			groupMemberListCall();
			
		};
		ajaxCall(obj);
	}
	
	//그룹 정보 수정
	$("#changeGroupInfo").click(function name() {
		var planDateChkArr=[];
		var planDateChkResult=true;
		var startDay = new Date($("#groupInfoStartDate").val());
		var endDay = new Date($("#groupInfoEndDate").val());
		
		obj.url=loaction+"./planlist";
		obj.data={};
		obj.success = function(data){
			data.list.forEach(function(item,index){
				planDateChkArr.push(compare_Date($("#groupInfoStartDate").val(), $("#groupInfoEndDate").val(), item.plan_startDay, item.plan_endDay));
		    });
			for(var i=0; i<planDateChkArr.length; i++){
				if(planDateChkArr[i]==false){
					planDateChkResult=false;
				}
			}

			if($("#groupInfoName").val()==""){
				alert("그룹명을 입력해주세요.")
				$("#groupInfoName").focus();
			}else if($("#groupInfoStartDate").val()==""){
				alert("프로젝트 시작일을 입력해주세요.")
				$("#groupInfoStartDate").focus();			
			}else if($("#groupInfoEndDate").val()==""){
				alert("프로젝트 종료일을 입력해주세요.")
				$("#groupInfoEndDate").focus();			
			}else if(startDay>endDay){
				alert("프로젝트 시작일을 재입력해주세요.")
				$("#groupInfoStartDate").focus();
			}else if(!planDateChkResult){
				alert("진행해야하는 일정이 존재합니다.")
				$("#groupInfoStartDate").focus();
			}else{
				obj.url=loaction+"./groupInfoUpdate";
				obj.data={};
				obj.data={
						groupInfoIdx:$('#groupInfoIdx').val(),
						groupInfoName:$('#groupInfoName').val(),
						groupInfoStartDate:$('#groupInfoStartDate').val(),
						groupInfoEndDate:$('#groupInfoEndDate').val()
						};
				obj.success = function(data){
					if(data.success){
						alert("그룹 정보을 완료했습니다. :)");
						if('${sessionScope.menuName}'!=""){
							switch ('${sessionScope.menuName}') {
							case "main":
								location.href="main_Group.jsp";
								break;
							case "myInfo":
								location.href="memberInfoForm.jsp";
								break;
							case "notice":
								location.href="/SemiProject_TeamP/adminList";
								break;
							case "plan":
								location.href="/SemiProject_TeamP/plan.jsp";
								break;
							case "fileBbs":
								location.href="/SemiProject_TeamP/fileList";
								break;
							case "groupBbs":
								location.href="/SemiProject_TeamP/groupList";
								break;	
							case "comunityBbs":
								location.href="/SemiProject_TeamP/comunityList?";
								break;					
							}
						}
					}else{
						alert("그룹 정보수정을 완료하지 못 했습니다. 다시 시도해주세요 :(");
					}
				};
				ajaxCall(obj);
			}
		};
		ajaxCall(obj);
	})
	
	
	//회원추방
	$(document).on('click','#out', function() {
		var con = confirm("회원님을 정말 그룹에서 추방 하시겠습니까?");
		if(con){
			var groupMemberId = $(this).attr("value");
			passCheckCss();
			obj.url=loaction+"./memberOut";
			obj.data = {groupMemberId:groupMemberId};
			obj.success = function(data){
				if(data.success){
					alert(groupMemberId+"님을 추방했습니다.");
					groupMemberListCall();
				}else{
					alert("멤버 추방에 실패했습니다. 다시 시도해주세요 :(");
				}
			};
			ajaxCall(obj);
		}
	});
	
	
	//그룹탈퇴
	$("#withdrawal").click(function() {
		var con = confirm("회원님 정말 그룹에서 탈퇴 하시겠습니까?");
		if(con){
			obj.url=loaction+"./groupWithdrawal";
			obj.data = {groupIdx:groupIdx};
			obj.success = function(data){
				if(data.success){
					alert("그룹에서 탈퇴하셨습니다. 새로운 그룹을 생성하거나 멋진 그룹에 참여해주세요 :)");
					location.href="main_nonGroup.jsp";
				}else{
					alert("그룹탈퇴를 실패했습니다 다시 시도해주세요 :(");
				}
			};
			ajaxCall(obj);
		}
	})
	
	//그룹 멤버조회
	function groupMemberListCall(){
		obj.url=loaction+"./groupMemberList";
		obj.data={groupIdx:groupIdx};
		obj.success = function(data) {
			console.log("멤버 그룹 조회");
			 $("#groupMemberList").empty();
			 $("#groupInquiryMemberList").empty();
			 
			 //그룹장
			 data.groupMember.forEach(function(item,index){
				 groupMemberContent += "<tr>";
				 groupMemberContent += "<td><div id='groupMemberId' value="+item.groupMember_id+">"+item.groupMember_id+"</div></td>";
				 groupMemberContent += "<td><div id='out' value="+item.groupMember_id+">강퇴</div></td>";
				 groupMemberContent += "</tr>";
				 
				 $("#groupMemberList").append(groupMemberContent);
				
				 groupMemberContent="";
			 })
			 
			 //그룹원
			 data.groupMember.forEach(function(item,index){
				 groupMemberContent += "<tr>";
				 groupMemberContent += "<td><div id='groupMemberId' value="+item.groupMember_id+">"+item.groupMember_id+"</div></td>";
				 groupMemberContent += "</tr>";
				 
				 $("#groupInquiryMemberList").append(groupMemberContent);
				
				 groupMemberContent="";
			 })
		}

		ajaxCall(obj);
	}
	
	$("#groupDel").click(function() {
		var con = confirm("정말 그룹을 삭제 하시겠습니까?");
		if(con){
			//오늘
			obj.url=loaction+"./groupDelete";
			obj.data={};
			obj.data={groupInfoIdx:$('#groupInfoIdx').val()};
			obj.success = function(data){
				if(data.success){
					location.href="main_nonGroup.jsp"
					alert("새로운 그룹을 생성하거나 멋진 그룹에 참여해주세요 :)");
				}else{
					alert("그룹 삭제를 실패 했습니다. 다시 시도해주세요 :(");
				}
			};
			ajaxCall(obj);
		}
	})
	
	$("#groupfinish").click(function() {
		var con = confirm("프로젝트를 완료하시겠습니까?");
		if(con){
			obj.url=loaction+"./groupDelete";
			obj.data={};
			obj.data={groupInfoIdx:$('#groupInfoIdx').val()};
			obj.success = function(data){
				if(data.success){
					if(data.groupIdx!=0){
						location.href="main_Group.jsp"
					}else{
						location.href="main_nonGroup.jsp"
					}
					alert("프로젝트를 성공적으로 끝낸 것을 TeamP에서 축하드립니다 :)");
				}else{
					alert("프로젝트 완료를 실패했습니다. 다시 시도해주세요 :(");
				}
			};
			ajaxCall(obj);
		}
		
	})

	
	function BetweenDate(currentDay,endDay) {
		var currentDayInfo = currentDay.split("-");
		var endDayInfo = endDay.split("-");

		var currentDayDate = new Date(currentDayInfo[0], currentDayInfo[1]-1, currentDayInfo[2]);//시작일 Date
		var endDayDate = new Date(endDayInfo[0], endDayInfo[1]-1, endDayInfo[2]);//종료일 Date
		
		var btMs = endDayDate.getTime() - currentDayDate.getTime();
		var btDay = btMs / (1000*60*60*24);
		
		return btDay;
	}
	
	function compare_Date(groupStartDate, groupEndDate, planStartDate, planEndDate){
		var compareResult = false;	

		var groupStartDateArr = groupStartDate.split('-'); 
		var groupEndDateArr = groupEndDate.split('-');
		var planStartDateArr = planStartDate.split('-');
		var planEndDateArr =  planEndDate.split('-');
		
		var dateGroupStartDate = new Date(groupStartDateArr[0],groupStartDateArr[1],groupStartDateArr[2]);
		var dateGroupEndDate = new Date(groupEndDateArr[0],groupEndDateArr[1],groupEndDateArr[2]);
		var datePlanStartDate = new Date(planStartDateArr[0],planStartDateArr[1],planStartDateArr[2]);
		var datePlanEndDate =  new Date(planEndDateArr[0],planEndDateArr[1],planEndDateArr[2]);
		
		if(dateGroupStartDate<=datePlanStartDate & datePlanStartDate<=datePlanEndDate & dateGroupEndDate>=datePlanStartDate & dateGroupEndDate>=datePlanEndDate){
			compareResult = true;
		}else{
			compareResult = false;
		}
		
		return compareResult;
	}
	
	function ajaxCall(param){
		$.ajax(param);
	}
</script>
</html>
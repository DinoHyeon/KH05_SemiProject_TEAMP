<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			    left: 18%;
			    width: 60%;
			    height: 75%;
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
				z-index: 6
			}
	            
        </style>
</head>
<body>
	<%@include file="passCheck.jsp"%>

	 <div id="header">
	 		<div id="TeamPTitle">TeamP</div>
            <div id="navi">
           		 <button class="menu" id="main">메인</button>
                <button class="menu" onclick="location.href='memberInfoForm.jsp'" id="myInfo">내정보</button>
                <button class="menu" onclick="location.href='/SemiProject_TeamP/adminList'" id="notice">공지사항</button>
                <button class="menu" id="plan">일정</button>
                <button class="menu" id="fileBbs">파일게시판</button>
                <button class="menu" onclick="location.href ='/SemiProject_TeamP/groupList'" id="groupBbs">그룹게시판</button>
                 <button class="menu" onclick="location.href ='/SemiProject_TeamP/comunityList'" id="comunityBbs">의견나눔게시판</button>
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
        </div>
        
        
       	<div id="groupBg"></div><!-- 팝업이 띄워졌을 때 홈페이지에 깔리는 불투명한 배경 -->
       	
       	
       	<div id="popupContentMaster"><!-- 그룹장일 때 나오는 팝업 창 -->
			<div class="headerPopupClose">X</div>
			<h2>그룹 관리</h2>
			<table id="groupInfoManage">
				<tr>
					<td>그룹장 <span id="groupInfoMasterName"></span></td>
				</tr>
				<tr>
					<td>그룹명</td>
				</tr>
				<tr>
					<td><input type='hidden' id="groupInfoIdx"><input id="groupInfoName" type="text"/></td>
				</tr>
				<tr>
					<td>프로젝트 기간 - 시작</td>
				</tr>	
				<tr>
					<td><input id="groupInfoStartDate" type="date"/></td>
				</tr>
				<tr>
					<td>프로젝트 기간 - 종료</td>
				</tr>						
				<tr>
					<td><input id="groupInfoEndDate" type="date"/></td>
				</tr>					
			</table>
			<div id="groupmemberName">그룹원</div>
			<table id="groupMemberList">
			</table>
			<div id="invite">초대</div>
			<div id="changeGroupInfo">그룹정보 수정</div>
		</div>
		
		
		<!-- 그룹 초대 팝업 -->
		<div id="popupContentInvite">
			<div class="headerPopupClose">X</div>
			<h2>그룹원 초대</h2>
			<table>
				<tr>
					<td>그룹명</td>
					<td><span id="inviteGroupName"></span></td>
				</tr>
				<tr>
					<td>아이디</td>
					<td><input id="inviteMember" type="text"/>    <input type="button" onclick="inviteMemberChk()" value="중복확인"/><span id="inviteMemberChkMsg"></span></td>
				</tr>
				<tr>
					<td>초대 내용</td>
					<td>
						<textarea id="inviteMsg" rows="5" cols="28" style="resize: none"></textarea>
					</td>
				</tr>
			</table>
			<input type="button" value="초대" onclick="groupInvite()">
			<div id="groupDel">그룹 삭제</div>
		</div>
        
        <!-- 그룹원일 때 나오는 창 -->
        <div id="popupContenMember"><!-- 그룹장일 때 나오는 팝업 창 -->
			<div class="headerPopupClose">X</div>
			<h2>그룹 정보</h2>
			<table id="groupInfoInquiry">
				<tr>
					<td>그룹장 <span id="groupInfoInquiryMasterName"></span></td>
				</tr>
				<tr>
					<td>그룹명</td>
				</tr>
				<tr>
					<td><input type='hidden' id="groupInfoIdx"><span id="groupInfoInquiryName"></span></td>
				</tr>
				<tr>
					<td>프로젝트 기간 - 시작</td>
				</tr>	
				<tr>
					<td><input id="groupInfoInquiryStartDate" type="date"/></td>
				</tr>
				<tr>
					<td>프로젝트 기간 - 종료</td>
				</tr>						
				<tr>
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
	var groupIdx = '${sessionScope.groupNum}';
	var groupName = "";
	var groupMemberContent = "";
	
	var obj = {};
	var idx;//idex값을 저장할 전역 변수
	obj.type="POST";
	obj.dataType="JSON";
	obj.error=function(e){console.log(e)};


	$(document).ready(function() {
		
		
		//그룹가입 여부에 따른 header
		if(groupIdx!=0){
			console.log("그룹 있음");
			//그룹이 있을 경우 nongroup를 none으로
			$("#Nongroup").css("display","none");
		}else{
			console.log("그룹 없음");
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
		obj.url="./createMenuSession";
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
			obj.url="./inviteMemberIdChk";
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
			obj.url="./groupInvite";
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
		}else{
			$("#popupContentInvite").css("display","none");
			$("#popupContentMaster").css("display","inline");
		}
		
		if($("#popupContenMember").css("display")!="none"){
			$("#groupBg").css("display","none");
			$("#popupContentMember").css("display","none");
		}

	})
	
	
	//그룹정보 호출
	function groupInfoLoad() {
		obj.url="./groupDetail";
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
		var startDay = new Date($("#groupInfoStartDate").val());
		var endDay = new Date($("#groupInfoEndDate").val());

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
		}else{
			obj.url="./groupInfoUpdate";
			obj.data={};
			obj.data={
					groupInfoIdx:$('#groupInfoIdx').val(),
					groupInfoName:$('#groupInfoName').val(),
					groupInfoStartDate:$('#groupInfoStartDate').val(),
					groupInfoEndDate:$('#groupInfoEndDate').val()
					};
			obj.success = function(data){
				if(data.success){
					groupInfoLoad();
					alert("그룹 정보수정을 완료했습니다.");
				}else{
					alert("그룹 정보수정을 완료하지 못 했습니다.");
				}
			};
			ajaxCall(obj);
		}
	})
	
	
	//회원추방
	$(document).on('click','#out', function() {
		var groupMemberId = $(this).attr("value");
		passCheckCss();
		obj.url="./memberOut";
		obj.data = {groupMemberId:groupMemberId};
		obj.success = function(data){
			if(data.success){
				alert(groupMemberId+"님을 추방했습니다.");
				groupMemberListCall();
			}else{
				alert("멤버 추방에 실패했습니다 TT..");
			}
		};
		ajaxCall(obj);
	});
	
	
	//그룹탈퇴
	$("#withdrawal").click(function() {
		obj.url="./groupWithdrawal";
		obj.data = {groupIdx:groupIdx};
		obj.success = function(data){
			if(data.success){
				alert("그룹에서 탈퇴하셨습니다.");
				location.href="main_nonGroup.jsp";
			}else{
				alert("그룹탈퇴를 실패했습니다 ㅠㅠ");
			}
		};
		ajaxCall(obj);
	})
	
	//그룹 멤버조회
	function groupMemberListCall(){
		obj.url="./groupMemberList";
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
	
	
	function groupDel() {
		//그룹 삭제 전 회원 비밀번호로 체크
		passCheckCss();
		//오늘
		obj.url="./groupDelete";
		obj.data={};
		obj.data={groupInfoIdx:$('#groupInfoIdx').val()};
		obj.success = function(data){
			if(data.success){
				if(data.groupIdx!=0){
					location.href="main_Group.jsp"
				}else{
					location.href="main_nonGroup.jsp"
				}
				alert("그룹을 삭제했습니다.");
			}else{
				alert("그룹 삭제를 못 했습니다.");
			}
		};
		ajaxCall(obj);
	};
	
	function ajaxCall(param){
		console.log(param);
		$.ajax(param);
	}
</script>
</html>
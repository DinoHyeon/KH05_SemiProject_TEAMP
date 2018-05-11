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
            
            #navi{
                position: absolute;
                background-color: none;
                left : 61%;
                top : 15.7%;
                width: 45%;
            }
            
            #navi button{
                border: none;
                background-color: white;
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
			.close{
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
	 <div id="header">
            <div id="navi">
                <button onclick="location.href='memberInfoAccess.jsp'" id="myInfo">내정보</button>
                <button id="notice">공지사항</button>
                <button id="plan">일정</button>
                <button id="fileBbs">파일게시판</button>
                <button id="groupBbs">그룹게시판</button>
                <button id="comunityBbs">의견나눔게시판</button>
            </div>
        </div>
        
        
        <!-- 가입한 그룹이 없을 경우 나오는 header -->
      	<div id="Nongroup">
			<h3 style="color: white;">가입하신 그룹이 없습니다.</h3>
	 	</div>
        <!-- 가입한 그룹이 있을 경우 나오는 header -->
        <div id="group">
            <div id="groupInfo">그룹 정보</div><!-- 현재 로그인한 회원의 레벨이 member인 경우 -->
            <div id="groupManage">그룹 관리</div><!-- 현재 로그인한 회원의 레벨이 master인 경우 -->
        </div>
        
        
       	<div id="groupBg"></div><!-- 팝업이 띄워졌을 때 홈페이지에 깔리는 불투명한 배경 -->
       	
       	<div id="popupContentMaster"><!-- 그룹장일 때 나오는 팝업 창 -->
			<div class="close">X</div>
			<h2>그룹 관리</h2>
			<table id="groupInfoManage">
				<tr>
					<td>그룹장 <span id="groupInfoMasterName"></span></td>
				</tr>
				<tr>
					<td>그룹명</td>
				</tr>
				<tr>
					<td><input id="groupInfoName" type="text"/></td>
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
				<tr>
					<td></td>
					<td></td>
				</tr>
			</table>
			<div id="invite">초대</div>
		</div>
		
		<!-- 그룹 초대 팝업 -->
		<div id="popupContentInvite">
			<div class="close">X</div>
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
			<input type="button" value="초대" onclick="changeGroupInfo()">
			<div id="groupDel">그룹 삭제</div>
		</div>
        
</body>
<script>
	var groupIdx = '${sessionScope.groupNum}';
	var groupName = "";
	
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
	})
	
	//그룹원)그룹정보 버튼을 클릭했을 경우
	$("#groupInfo").click(function() {
		$("#groupBg").css("display","inline");
		$("#close").css("display","inline");
	})
	
	//그룹장)그룹관리 버튼을 클릭했을 경우
	$("#groupManage").click(function() {

		//그룹정보 호출 함수
		groupInfoLoad();
		
		$("#groupBg").css("display","inline");
		$("#popupContentMaster").css("display","inline");
		$(".close").css("display","inline")
		
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
					$("#inviteMember").val("");
					$("#inviteGroupName").val("");
					$("#inviteMsg").val("");
					$("#inviteMemberChkMsg").html("");
					alert("초대를 성공했습니다.");
					$("#popupContentInvite").css("display","none");
					$("#popupContentMaster").css("display","inline");
				}
			}
			ajaxCall(obj);
		}
	}
	
	//닫기
	$(".close").click(function() {
		if($("#popupContentMaster").css("display")!="none"){
			$("#groupBg").css("display","none");
			$("#popupContentMaster").css("display","none");
		}else{
			$("#popupContentInvite").css("display","none");
			$("#popupContentMaster").css("display","inline");
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
			$("#groupInfoMasterName").html(data.groupInfo.member_id);
			$("#groupInfoName").val(data.groupInfo.group_name);
			$("#groupInfoStartDate").val(data.groupInfo.group_StrartDay);
			$("#groupInfoEndDate").val(data.groupInfo.group_EndDay);
			
 			//그룹 멤버조회
			obj.url="./groupMemberList";
			obj.data={};
			obj.data={groupIdx:groupIdx};
			obj.success = function(data) {
				 console.log(data.list);
			}
			ajaxCall(obj);
			
		};
		ajaxCall(obj);
	}
	
	//그룹 정보 수정
	function changeGroupInfo() {
		//오늘
	}
	
	//그룹 삭제
	$("#groupDel").click(function() {
		//그룹 삭제 전 회원 비밀번호로 체크
		//오늘
		
	});
	
	function ajaxCall(param){
		console.log(param);
		$.ajax(param);
	}
</script>
</html>
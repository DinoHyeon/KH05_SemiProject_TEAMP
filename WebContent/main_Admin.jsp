<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <title>Team P ::관리자 페이지</title>
        <style>
            body{
                background-color: #004C63;
                margin: 0;
            }
            
            h1{
                position: absolute;
                left: 44%;
                top: 10%;
                color: #FFD724;
                font-size: 57px;
                font-weight: 900;
                text-align: center;
            }
            
            h2{
                position: absolute;
                left: 43.8%;
                top: 21%;
                color: #FFD724;
                font-size: 23px;
                font-weight: 600;
                text-align: center;
            }
            
            #bg{
                position: absolute;
                width: 100%;
                height: 100%;
                background-color: black;
                opacity: 0.6;
                z-index: 1;
                display: none;
            }
            
            #memberList{
                position: absolute;
                width: 15%;
                height: 30%;
                left: 13%;
                top: 43%;
                background-color: #FFD724;
                border-radius: 100%;
            }
            
            #memberList span{
                position: absolute;
                left: 20%;
                top: 39%;
                font-size: 32px;
                font-weight: 900;
                color: #004C63;
            }
            
            #groupList{
                position: absolute;
                width: 15%;
                height: 30%;
                left: 42.5%;
                top: 43%;
                background-color: #FFD724;
                border-radius: 100%;
            }
        
            #groupList span{
                position: absolute;
                left: 20%;
                top: 39%;
                font-size: 32px;
                font-weight: 900;
                color: #004C63;
            }
            
            #TeampBbs{
                position: absolute;
                width: 15%;
                height: 30%;
                left: 72%;
                top: 43%;
                background-color: #FFD724;
                border-radius: 100%;
            }
            
            #TeampBbs span{
                position: absolute;
                left: 11%;
                top: 39%;
                font-size: 29px;
                font-weight: 900;
                color: #004C63;
            } 
            
            #contentPopup{
                position: absolute;
                width: 60%;
                height: 65%;
                left: 20%;
                top: 17%;
                background-color: #004C63;
                z-index: 2;
                display: none;
            }
            
            #contentPopup #close{
                position: absolute;
                left: 97%;
                top: 0%;
                font-size: 24px;
                font-weight: 900;
                color: #FFD724;
            }
            
            #contentPopup #groupSelectList{
                position: absolute;
                width: 95%;
                height: 75%;
                left: 2.5%;
                top: 21%;
                background: white;
             	overflow-y: scroll;
            }
            
            #contentPopup #popupTitle{
                position: absolute;
                left: 44.5%;
                top: 6%;
                font-size: 24px;
                font-weight: 900;                
                color: #FFD724;
            }
            
            #contentPopup #adminPageList{
                position: absolute;
                left: 3%;
                top: 1%;
            	width: 94%;
            	font-size: 15px;
            	text-align: center;
            }
            
            #memberId{
                position: absolute;
                left: 10%;
                top: 16%;
                text-align: center;
                font-weight: 700; 
                color: #FFD724;
            }
            
            #memberName{
                position: absolute;
                left: 25.2%;
                top: 16%;
                text-align: center;
                font-weight: 700; 
                color: #FFD724;
            }
            
            #groupName{
                position: absolute;
                left: 44.5%;
                top: 16%;
                text-align: center;
                font-weight: 700; 
                color: #FFD724;
            }
            
            #memberLv{
                position: absolute;
                left: 65.5%;
                top: 16%;
                text-align: center;
                font-weight: 700; 
                color: #FFD724;
            }            
            
			/*스크롤바 css */
			::-webkit-scrollbar{
			width: 11px;
			}
			::-webkit-scrollbar-track{
			background: #c4c6c8;
			}
			::-webkit-scrollbar-thumb{
			background: #105B74;
			border-radius: 10px;
			-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.4);
			}
			::-webkit-scrollbar-thumb:vertical:hover,
			::-webkit-scrollbar-thumb:horizontal:hover{ 
			background: #08A67C;
			}
            
            
        </style>
    </head>
    
    <body>
        <h1>TeamP</h1>
        <h2>[ 관리자 페이지 ]</h2>
        <div id="contentPopup">
            <div id="popupTitle"></div>
            <div id="memberId">아이디</div>
            <div id="memberName">회원명</div>
            <div id="groupName">그룹명</div>
            <div id="memberLv">회원등급</div>
            <div id="close">X</div>
            <div id="groupSelectList">
            	<table id="adminPageList">
            	</table>
            </div>
        </div>
        <div id="bg"></div>
        <div id="memberList"><span>회원 관리</span></div>
        <div id="groupList"><span>그룹 관리</span></div>
        <div id="TeampBbs"><span>홈페이지 관리</span></div>
    </body>
    <script>
    	var content = "";
		var obj = {};	
		obj.type="post";
		obj.dataType="json";
		obj.error=function(e){console.log("요청 실패")};
    
        $("#memberList").hover(function(){//mouseenter
            $(this).css("background-color","lightslategray");
        },function(){
            $(this).css("background-color","#FFD724");
        })
        
        $("#groupList").hover(function(){//mouseenter
            $(this).css("background-color","lightslategray");
        },function(){
            $(this).css("background-color","#FFD724");
        })
        
        $("#TeampBbs").hover(function(){//mouseenter
            $(this).css("background-color","lightslategray");
        },function(){
            $(this).css("background-color","#FFD724");
        })
        
        $("#close").click(function() {
            $("#bg").css("display","none");
            $("#contentPopup").css("display","none");
		})
        
        $("#memberList").click(function(){
            $("#bg").css("display","inline");
            $("#contentPopup").css("display","inline");
            $("#memberId").html("아이디");
            $("#memberName").html("회원명");
            $("#memberName").css("left","25.2%");
            $("#groupName").html("그룹명");
            $("#groupName").css("left","44.5%");
            $("#memberLv").html("회원등급");
            $("#memberLv").css("left","65.5%");
            $("#popupTitle").html("회원 관리")
            memberList();
        })
        
        $(document).on('click','.memberDrop_out', function() {
				var member_Id = $(this).attr("id");
				var con = confirm(member_Id+"님을 정말 탈퇴 시키겠습니까?");
				if(con){
					obj.url="./adMemberDel";
					obj.data = {member_Id:member_Id};
					obj.success = function(data){
						if(data.success){
							alert("'"+member_Id+"' 님을 TeamP에서 탈퇴 시켰습니다.")
							memberList();
						}else{
							alert("'"+member_Id+"' 님을 TeamP에서 탈퇴 시키는 것을 실패했습니다.")
						}
					};
					ajaxCall(obj);
				}
		});
        
        $("#groupList").click(function(){
            $("#bg").css("display","inline");
            $("#contentPopup").css("display","inline");
            $("#popupTitle").html("그룹 관리")
            $("#memberId").html("아이디");
            $("#memberName").html("그룹명");
            $("#memberName").css("left","21.2%");
            $("#groupName").html("시작 기간");
            $("#groupName").css("left","35%");
            $("#memberLv").html("종료 기간");
            $("#memberLv").css("left","60.8%");

            groupList();
       	})
   
        $(document).on('click','.groupDel', function() {
        		var str = ""
                var tdArr = new Array();
                var checkBtn = $(this);
                
                var tr = checkBtn.parent().parent();
                var td = tr.children();
                
                var groupName = td.eq(0).text();
				var groupIdx = $(this).attr("id");
				
				var con = confirm("'"+groupName+"' 그룹을 정말 삭제 시키겠습니까?");
				if(con){
					obj.url="./adGroupDel";
					obj.data = {groupIdx:groupIdx};
					obj.success = function(data){
						if(data.success){
							alert("'"+groupName+"' 그룹을 TeamP에서 삭제 시켰습니다.")
							groupList()
						}else{
							alert("'"+groupName+"' 그룹을 TeamP에서 삭제하는 것을 실패했습니다.")
						}
					};
					ajaxCall(obj);
				}
		});
       	
        $("#TeampBbs").click(function(){
            $("#bg").css("display","inline");
            $("#contentPopup").css("display","inline");
            $("#popupTitle").html("페이지 관리")
            $("#memberId").html("아이디");
            $("#memberName").html("그룹명");
            $("#memberName").css("left","21.2%");
            $("#groupName").html("시작 기간");
            $("#groupName").css("left","35%");
            $("#memberLv").html("종료 기간");
            $("#memberLv").css("left","60.8%");
            
            obj.url="./adGroupList";
            obj.data={};
			obj.success=function(data){
				$("#adminPageList").empty();
				console.log(data);
				data.groupList.forEach(function(item,index){
					 content += "<tr>";
					 content += "<td>"+item.group_masterId+"</td>";
					 content += "<td>"+item.group_name+"</td>";
					 content += "<td>"+item.group_StrartDay+"</td>";
					 content += "<td>"+item.group_EndDay+"</td>";
					 content += "<td>"+"<input class='getGroupSession' type='button' id="+item.group_idx+" value='권한'></td>";//수락 거절
					 content += "</tr>";
					 $("#adminPageList").append(content);
					 content="";
			      });   
			}
			
			ajaxCall(obj);
			
        })
        
        $(document).on('click','.getGroupSession', function() {
    			var str = ""
                var tdArr = new Array();
                var checkBtn = $(this);
                
                var tr = checkBtn.parent().parent();
                var td = tr.children();
                
                var groupName = td.eq(0).text();
				var groupIdx = $(this).attr("id");
				
				var con = confirm("'"+groupName+"' 그룹의 권한을 갖고 홈페이지를 관리하시겠습니까?");
				if(con){
					obj.url="./adGroupSession";
					obj.data = {groupIdx:groupIdx};
					obj.success = function(data){
						if(data.success){
							alert("'"+groupName+"' 그룹의 session이 생성되었습니다. 해당 그룹의 게시글과 관리자 영역 페이지의 관리가 가능합니다.");
							location.href="main_Group.jsp";
						}else{
							alert("'"+groupName+"' 그룹의 session 생성을 실패했습니다.")
						}
					};
					ajaxCall(obj);
				}
		});
        
		
        
        /* 서버요청 함수 */
		function ajaxCall(obj){
			$.ajax(obj);
		}
        
        function memberList() {
        	obj.url="./adMemberList";
            obj.data={};
			obj.success=function(data){
				$("#adminPageList").empty();
				data.memberList.forEach(function(item,index){
					 content += "<tr>";
					 content +=	"<td>"+item.member_Id+"</td>";
					 content += "<td>"+item.member_name+"</td>";
					 content += "<td>"+item.group_name+"</td>";
					 content += "<td>"+item.member_lv+"</td>";
					 content += "<td>"+"<input class='memberDrop_out' type='button' id="+item.member_Id+" value='탈퇴'></td>";//수락 거절
					 content += "</tr>";
					 $("#adminPageList").append(content);
					 content="";
			      });   
			}
			
			ajaxCall(obj);
		}
        
        function groupList() {
        	obj.url="./adGroupList";
            obj.data={};
			obj.success=function(data){
				$("#adminPageList").empty();
				data.groupList.forEach(function(item,index){
					 content += "<tr>";
					 content += "<td>"+item.group_masterId+"</td>";
					 content += "<td>"+item.group_name+"</td>";
					 content += "<td>"+item.group_StrartDay+"</td>";
					 content += "<td>"+item.group_EndDay+"</td>";
					 content += "<td>"+"<input class='groupDel' type='button' id="+item.group_idx+" value='삭제'></td>";//수락 거절
					 content += "</tr>";
					 $("#adminPageList").append(content);
					 content="";
			      });   
			}
			
			ajaxCall(obj);
		}
        
    </script>
</html>
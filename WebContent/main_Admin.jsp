<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <title>Insert title here</title>
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
                font-size: 29px;
                font-weight: 900;
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
            }
            
            #contentPopup #popupTitle{
                position: absolute;
                left: 44.5%;
                top: 9%;
                font-size: 24px;
                font-weight: 900;                
                color: #FFD724;
            }
            
            #contentPopup #adminPageList{
            	width: 90%;
            	border: 1px solid black;
            }
        </style>
    </head>
    
    <body>
        <h1>TeamP</h1>
        <h2>[ 관리자 페이지 ]</h2>
        <div id="contentPopup">
            <div id="popupTitle"></div>
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
        
        
        $("#memberList").click(function(){
            $("#bg").css("display","inline");
            $("#contentPopup").css("display","inline");
            $("#popupTitle").html("회원 관리")
            obj.url="./adMemberList";
            obj.data={};
			obj.success=function(data){
				$("#adminPageList").empty();
				
				 content +="<tr>";
				 content +="<td>아이디</td>";
				 content +="<td>이름</td>";
				 content +="<td>그룹</td>";
				 content +="<td>회원등급</td>";
				 content +="</tr>";
				 $("#adminPageList").append(content);
				 
				 content="";
				 
				data.memberList.forEach(function(item,index){
					 content += "<tr>";
					 content +=	"<td>"+item.member_Id+"</td>";
					 content += "<td>"+item.member_name+"</td>";
					 content += "<td>"+item.member_groupNum+"</td>";
					 content += "<td>"+item.member_lv+"</td>";
					 content += "<td>"+"<input class='accept' type='button' id="+item.group_idx+" value='수락'></td>";//수락 거절
					 content += "</tr>";
					 $("#adminPageList").append(content);
					 content="";
			      });   
			}
			
			ajaxCall(obj);
        })
        
        $("#groupList").click(function(){
            $("#bg").css("display","inline");
            $("#contentPopup").css("display","inline");
            $("#popupTitle").html("그룹 관리")
            obj.url="./emailOverlay";
			obj.data={email:$("#email").val()};
			obj.success=function(d){
				
			}

       	})
        
        $("#TeampBbs").click(function(){

        })
        
        $("#close").click(function(){
            $("#bg").css("display","none");
            $("#contentPopup").css("display","none");
        })
        
        /* 서버요청 함수 */
		function ajaxCall(obj){
			$.ajax(obj);
		}
    </script>
</html>
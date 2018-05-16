<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet"/>
<link href="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print"/>
<script type="text/javascript" src="http://fullcalendar.io/js/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript" src="http://fullcalendar.io/js/fullcalendar-3.9.0/lib/jquery.min.js"></script>
<script type="text/javascript" src="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.js"></script>
<script src='http://fullcalendar.io/js/fullcalendar-3.9.0/locale/ko.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
     
         
            #mainInfo{
                position: fixed;
                left: 82.5%;
                width: 17.5%;
                height: 100%;
                background-color: #004C63;
            }

            #TeamP{
               position: absolute;
               color: #FFD724;
               left: 74%;
               top: 1%;
               font-weight: 900;
               font-size: 16px;
            }
            
            #userName{
                position: absolute;
               color: #FFD724;
               width: 100%;
                text-align: center;
               top: 8%;
               font-weight: 900;
               font-size: 20px;
            }
            
            
            #groupName{
                position: absolute;
               color: #FFD724;
                width: 83%;
               top: 10.5%;
               font-weight: 900;
               font-size: 16px;
                text-align: center;
            }
          
             #Todo{
                position: absolute;
            	color: white;
                width: 83%;
            	top: 25%;
            	font-weight: 500;
            	font-size: 16px;
                text-align: center;
            }
            #content{
                background-color: #004D65;
                border: 1px solid white;
                width: 225px;
                border-style: none none solid none;
                color: white;
                margin:10;
            }
             .tododel{
                border: none;
                margin-bottom: 10px;
                background-color: #004D65;
                font-size: 20px;
                color: white;  
            } 
            
            button{
                margin-left: -20px;
                border: none;
                margin-bottom: 10px;
                background-color: #004D65;
                font-size: 20px;
                color: white;   
            }
      
            #TodoList{
            width:80%;
            height:40%;
            
            }
            #TodoList
			{
				float: left;
				height: 450px;
				width: 265px;
				font-weight: 900;
                font-size: 14px;
                text-align: left;
				background-color: #004C63;
				overflow : auto;
				margin-bottom: 25px;
			}
			#TodoList::-webkit-scrollbar-track
			{
				-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
				border-radius: 10px;
				background-color: #F5F5F5;
			}
			
			#TodoList::-webkit-scrollbar
			{
				width: 12px;
				background-color: #F5F5F5;
			}
			
			#TodoList::-webkit-scrollbar-thumb
			{
				border-radius: 10px;
				-webkit-box-shadow: inset 0 0 6px rgba(0,0,0,.3);
				background-color: #555;
			}
      
</style>
</head>
<body>
        <div id="mainInfo">
           <div id="TeamP">Team P</div>
            <div id="userName"></div>
            <div id="groupName">현재 그룹이 없어요:(</div>
            <div id="Todo">할일 입력란
            <input id="content" type="text" maxlength="15"/><button id="insert">+</button> 
            <P>
             <div>할일 리스트<button id="slide">▲</button></div>
           <div class="scrollbar" id="TodoList">
            <table id="TodoTable">
            	<!-- <tr>
            		<th>할일 내용</th>
            	</tr> -->
            	
            </table>
            </div>
            </div>
           </div>
</body>
<script>
var obj = {};		
obj.type="post";
obj.dataType="json";
obj.error=function(e){console.log(e)};

//페이지가 로드되었을 때 session에 그룹번호가 없는 경우 화면을 다르게 보여줘야한다.
$(document).ready(function() {

	 $("#content").keyup(function(){
	        if ($(this).val().length > $(this).attr('maxlength')) {
	            alert('제한길이 초과');
	            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
	        }
	    });


 	$("#TodoList").scroll(function(){
		var scrollHeight=$("#scrolltest").scrollTop()+$(window).height();
		var documentHeight=$("#scrolltest").height;
		if(scrollHeight==documentHeight){
			$("#TodoTable").appendTo('content');
		}
	}); 
	
	//로그인상태인지 확인
	if('${sessionScope.loginId}'==""){
		alert("로그인이 필요한 서비스입니다.");
		location.href="index.jsp";
		//로그인상태면 할일 리스트 뽑아오는todoDetail실행
	}else if('${sessionScope.loginId}'!==""){
		obj.url="./todoDetail"
		obj.success = function(data){
			if(data.login){ //true이면
				//리스트 보여주기
				listPrint(data.list);
			}
		}
		ajaxCall(obj);
	}
	//세션에 저장되어 있는 groupNum이 0이라면(*0은 현재 가입되어 있는 그룹이 없는 것을 의미)
	if('${sessionScope.groupNum}'==0){
		//button의 css속성 값을 변경
		$("input[type='button']").css("display","inline");
	}else{
		$("#groupName").html("현재 가입된 그룹명은"+'${sessionScope.groupname}');
	}
})
    	$("button").click(function(){
		$("button").css("font-weight","normal");
		$(this).css("font-weight","900");
	})
 $("#insert").click(function(){
        	$.ajax({
    			type:"post",
    			url:"./todoWrite",
    			data:{
    				content:$("#content").val()
    			},
    			dataType:"json",
    			success:function(data){//인자 값은 서버에서 주는 메세지
    				console.log(data);
    				if(data.success){
    					location.reload();
    				}else{
    					alert("할일 등록실패")
    				}

    			}
    		});
        	ajaxCall(obj);
        });
				var content ="";
			function listPrint(list){
				console.log(list);
				//var content ="";
				//idx, user_name, subject, reg_date, bHit
				list.forEach(function(item, idx){
					content += "<tr>";					
					//content +="<td><div class='tododel' id="+item.to_do_idx+">삭제</div></td>";//삭제div
					content +="<td><input onclick='del()' class='tododel' value='-' type='button' id="+item.to_do_idx+"></td>";
					content +="<td>"+item.todo_content+"</td>";
					content += "</tr>"; 
				});		
				
				$("#TodoTable").append(content);
			}
			
			
			
	        function del(){
				console.log("삭제");
				
	        	$.ajax({
	    			type:"post",
	    			url:"./todoDelete",
	    			data:{
	    				delcontent:$(".tododel").attr('id')
	    				
	    			},
	    			dataType:"json",
	    			success:function(data){//인자 값은 서버에서 주는 메세지
	    				console.log(data);
	    				if(data.success){
	    					location.reload();
	    				}else{
	    					alert("삭제 실패")
	    				}

	    			}
	    		});
	        	ajaxCall(obj);
	        }; 

	     $("#slide").click(function(){
	            $("#TodoList").slideToggle("slow");
	            
	        })
		
	    	
        function ajaxCall(param){
    		$.ajax(param);
    	}
        
</script>
</html>
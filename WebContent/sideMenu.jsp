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
                border-style: none none solid none;
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
		
</style>
</head>
<body>
        <div id="mainInfo">
           <div id="TeamP">Team P</div>
            <div id="userName"></div>
            <div id="groupName">현재 그룹이 없어요:(</div>
            <div id="Todo">할일
            <input id="content" type="text"/><button id="insert">+</button> <button id="del">-</button> 
            <div id="TodoList">
            <table id="TodoTable">
            	<tr>
            		<th>할일 내용</th>
            	</tr>
            	
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
	//이건 ajax로 처리
	if('${sessionScope.loginId}'==""){
		alert("로그인이 필요한 서비스입니다.");
		location.href="index.jsp";
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
    					alert("할일 등록완료")
    					location.reload();
    				}else{
    					alert("할일 등록실패")
    				}

    			}
    		});
        	ajaxCall(obj);
        });
        
			function listPrint(list){
				console.log(list);
				var content ="";
				//idx, user_name, subject, reg_date, bHit
				list.forEach(function(item, idx){
					content += "<tr>";
					content +="<td>"+item.todo_content+"</td>";
					content +="<td><div class='tododel' id='+item.idx+'>-</div></td>";//삭제div
					content += "</tr>";
				});		
				$("#TodoTable").append(content);
			}
			/*  //삭제
			$(".tododel").click(function(){//삭제 div클릭시
				obj.url="./todoDelete";
				var val=$(this).attr('id');
				//$(elem).each() == elem.forEach()
				console.log(checked);		
				obj.data = {val};//delList변수에 체크된값 넣기
				obj.success = function(data){
					if(data.success){
						alert("삭제성공");
						location.reload();
					}else{
						alert("삭제실패");
					}
				}
				console.log(obj);
				ajaxCall(obj);
			});  */
			$(".tododel").click(function(){
	        	$.ajax({
	    			type:"post",
	    			url:"./tododel",
	    			data:{
	    				delcontent:$(this).attr('id');
	    			},
	    			dataType:"json",
	    			success:function(data){//인자 값은 서버에서 주는 메세지
	    				console.log(data);
	    				if(data.success){
	    					alert("삭제 완료")
	    					location.reload();
	    				}else{
	    					alert("삭제 실패")
	    				}

	    			}
	    		});
	        	ajaxCall(obj);
	        });
			
        function ajaxCall(param){
    		$.ajax(param);
    	}
        
</script>
</html>
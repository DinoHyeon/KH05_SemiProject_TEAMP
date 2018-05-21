<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	/* 페이지 영역을 잡기 위한 css 설정입니다. */
    #page{
        position: absolute;
        top: 15.9%;
	    width: 82.5%;
	    height: 84.1%;
		background-color: white;
   	}
    
    #page #calender{
        position: absolute;
        top: 6.5%;
        left: 1%;
        width: 50%;
        height: 60%;
        background-color: white;
    }
    
    #page #todayPlan{
        position: absolute;
        top: 74%;
        left: 1.6%;
        width: 48%;
        height: 24%;
        background-color: white;
        border: 3px solid #004D65;
    }
    
    #page #todayPlanDetail{        
        position: absolute;
        top: 0%;
        left: 55%;
        width: 45%;
        height: 100%;
		background-color: white;
    }   
    
    #page #sectionDivisionLine{      
        position: absolute;
        top: 0%;
        left: 52%;
        width: 0%;
        height: 100%;
		border-right: 2px solid #004D65;
        z-index: 2;
    }
    
    .fc-today {
	    background: #8EC7D0 !important;
	    border: none !important;
	    border-top: 1px solid #ddd !important;
	    font-weight: bold;
	} 
    
    .fc-sun {color:#e31b23}
    .fc-sat {color:#007dc3}
    
    #todayPlan{
    	height: 450px;
		width: 265px;
    	overflow : auto;
    }
   #todayPlanDetail{
		display:none;
	}
	#select{
		display:none;
	}
	#changesuc{
		display:none;
	}
	#changeplan{
	left:45%;
		width:70px;
		height:30px;
	}
	#detailTable{
	width:300px;
	height:250px;
	}
	
	input[type='text']{
		width:100%;
		border-width : 0;
	}
    
</style>
<link href="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.css" rel="stylesheet"/>
<link href="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.print.css" rel="stylesheet" media="print"/>
<script type="text/javascript" src="http://fullcalendar.io/js/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript" src="http://fullcalendar.io/js/fullcalendar-3.9.0/lib/jquery.min.js"></script>
<script type="text/javascript" src="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.js"></script>
<script src='http://fullcalendar.io/js/fullcalendar-3.9.0/locale/ko.js'></script>
<script type="text/javascript">

var obj = {};		
obj.type="post";
obj.dataType="json";
obj.error=function(e){console.log(e)};

$(document).ready(function(){
	
    $("#calender").fullCalendar({
          defaultDate : new Date()
        , lang : "ko"
        , height : 393
        , editable : true
        , eventLimit : true
        , header : {
            left: 'title',
            right: 'today prev,next'
        }
     ,events: function (start, end, timezone, callback) {
    	   $.ajax({
    	      type :"POST" //"POST", "GET"
    	     ,url :"./planlist" //Request URL
    	     ,dataType :"json"//jSonCalList에 json정보 담기
    	     ,success : function(data) {
    	    var json = data.list;
    	    var events = [];
    	      $.each(json,function(obj){
    	    events.push(
    	    		{
    	    			title: json.plan_title,
    	    			start: json.plan_startDay,
    	    			end: json.plan_endDay
    	      }); 
    	    console.log(json.plan_title);
    	    console.log(json.plan_startDay);
    	    console.log(json.plan_endDay);
    	      ajaxCall(obj);
    	      });
    }})}
   
         ,dayClick: function(date, allDay, jsEvent, view) {
        	$("#todayPlanDetail").css("display","none");
           var yy=date.format("YYYY");
           var mm=date.format("MM");
           var dd=date.format("DD");
           var date = yy+"/"+mm+"/"+dd;
           
           $("#planFinishDate").val(date);
           
           $(this).css('background-color', '#FFD724');
           $("td.fc-day.fc-widget-content").not($(this)).css('background-color', 'white')
	   		obj.url="./planDayList";
	   		obj.data={date:date};
	   		obj.success = function(data) {console.log(data);
	   			listPrint(data.list);
	   		}
	   		ajaxCall(obj); 
         }
    });
    var content ="";
	function listPrint(list){
		console.log(list);
		var content ="";
		//idx, user_name, subject, reg_date, bHit
		list.forEach(function(item, idx){
			content += "<tr>";	
			content +="<td>"+item.member_id+"</td>";
			content +="<td>"+item.plan_title+"</td>";
			content +="<td>"+item.plan_state+"</td>";
			content +="<td><input onclick='detail()' class='plandetail' value='상세보기' type='button' id="+item.plan_idx+"></td>";
			content += "</tr>"; 
		});		
		$("#PlanTable").empty();
		$("#PlanTable").append(content);
	}
});

function detail(){
	var content = "";
	//ex)1일 일정 상세보기 수정상태에서 3일 일정 상세보기 클릭시 수정상태로 데이터 보여주는 것을 방지
	console.log("일정 상세보기 호출");
	$("#planState").css("display", "inline");
	$("#select").css("display","none");
	$("#changeplan").css("display","inline");
	$("#changesuc").css("display","none");
	$(".edit").css("border-width","0px");
	$(".edit").attr("readonly",true);
	$("#todayPlanDetail").css("display","inline");

	$.ajax({
		type:"post",
		url:"./planDetail",
		data:{
			detail:$(".plandetail").attr('id')
		},
		dataType:"json",
		success:function(data){//인자 값은 서버에서 주는 메세지
			$("#planIdx").val(data.plandetail.plan_idx);
			$("#planMember").val(data.plandetail.member_id);
			$("#planTitle").val(data.plandetail.plan_title);
			$("#planContent").val(data.plandetail.plan_content);
			$("#planStart").val(data.plandetail.plan_startDay);
			$("#planEnd").val(data.plandetail.plan_endDay);
			$("#select").val(data.plandetail.plan_state);	
			$("#planState").val(data.plandetail.plan_state);
		}
	});
	ajaxCall(obj);
}; 

function ajaxCall(param){
	console.log(param);
	$.ajax(param);
}
</script>
</head>
<body>
	<%@include file="headerMenu.jsp"%>
	<%@include file="sideMenu.jsp"%>
    <div id="page">
		<div id="calender">
        
        </div>
        <div id="todayPlan">
         <table id="PlanTable">
            <tr>
            	<th>수행자</th>
            	<th>타이틀</th>
            	<th>상태</th>
            </tr> 
            </table>
        </div>
        <div id="sectionDivisionLine"></div>
        <div id="todayPlanDetail">
        	<h3>세부일정</h3>
			<table id="detailTable">
				<input type="hidden" id="planIdx">
				<input type="hidden" id="planFinishDate">
				<tr>
					<td><b>수행자</b></td>
					<td><input type="text" maxlength="15" class="edit" id="planMember" readonly value=${dto.member_id}></td>
				</tr>			
				<tr>
					<td><b>타이틀</b></td>
					<td><input type="text" maxlength="15" class="edit" id="planTitle" readonly value=${dto.plan_title}></td>
				</tr>			
				<tr>
					<td><b>일정내용</b></td>
					<td><input type="text" maxlength="20" class="edit" id="planContent" readonly value=${dto.plan_content}></td>
				</tr>			
				<tr>
					<td><b>시작날짜</b></td>
				    <td><input type="date" class="edit" id="planStart" readonly value=${dto.plan_startDay}></td>

				</tr>							
				<tr>
					<td><b>종료예정날짜</b></td>
					<td><input type="date" class="edit" id="planEnd" readonly value=${dto.plan_endDay}></td>
				</tr>
				<tr>
					<td><b>상태</b></td>
					<td>
						<input type="text" id="planState" readonly value=${dto.plan_state}> 
						<select id="select" name="job">
							    <option value="준비중">준비중</option>
							    <option value="진행중">진행중</option>
							    <option value="완료">완료</option>
						</select>
					</td> 
				</tr>
			</table>
				<div id="changeplan">일정 수정</div>
				<div id="changesuc">수정 완료</div>
        </div>
    </div>
</body>
<script>
	$(document).ready(function() {
		if('${sessionScope.loginId}'==""||'${sessionScope.groupNum}'==0){
			alert("로그인이 필요한 서비스입니다.");
			location.href="index.jsp";
		}
		obj.url="./headerMenuInfo";
		obj.data={};
		obj.success = function(data){
			groupStartDay=data.groupInfo.group_StrartDay;//시작일
			groupEndDay=data.groupInfo.group_EndDay;//종료일
			console.log(groupStartDay);
			console.log(groupEndDay);
		}
		ajaxCall(obj);
	});
	$("#changeplan").click(function(){
		$("#planState").css("display", "none");
		$("#select").css("display","inline");
		$("#changesuc").css("display","inline");
		$(".edit").css("border-width","1px");
		$(".edit").attr("readonly",false);
		$("#changeplan").css("display","none");
	});
	
	$("#changesuc").click(function(){
		/* $("#planState").css("display", "inline");
		$("#select").css("display","none");
		$("#changeplan").css("display","inline");
		$("#changesuc").css("display","none");
		$(".edit").css("border-width","0px");
		$(".edit").attr("readonly",true); */
	});
	
	
	
	 $("#changeplan").mouseenter(function(){
	        $("#changeplan").css("background","#00455A");
	        $("#changeplan").css("color","#FFD724")
	        $("#changeplan").mouseleave(function(){
	            $("#changeplan").css("background","white");
	            $("#changeplan").css("color","black")
	        })
	    })    
	    $("#changesuc").mouseenter(function(){
	        $("#changesuc").css("background","#00455A");
	        $("#changesuc").css("color","#FFD724")
	        $("#changesuc").mouseleave(function(){
	            $("#changesuc").css("background","white");
	            $("#changesuc").css("color","black")
	        })
	    })    
	    
	    //일정 수정
	    $("#changesuc").click(function() {
		
		
		if( $("#planStart").val()<groupStartDay){
			alert("일정 시작날짜가 그룹시작 날짜보다 작습니다.");
			$("#planStart").focus();
			}else if($("#planStart").val()>groupEndDay){
				alert("일정 시작날짜가 그룹종료 날짜보다 큽니다.")
				$("#planStart").focus();	
			}else if($("#planEnd").val()<groupStartDay){
					alert("일정 종료날짜가 그룹시작 날짜보다 작습니다.")
					$("#planEnd").focus();	
				}else if($("#planEnd").val()>groupEndDay){
					alert("일정 종료날짜가 그룹종료 날짜보다 큽니다.")
					$("#planEnd").focus();
				}else if($("#planEnd").val()<$("#planStart").val()){	
					alert("일정 시작날짜가 일정 종료날짜보다 큽니다")
	    }else{
			$.ajax({
				type : "post",
				url : "./planChange",
				data : {
					planIdx : $("#planIdx").val(),
		 			planMember : $("#planMember").val(),
					planTitle : $("#planTitle").val(),
					planContent : $("#planContent").val(),
					planStartDay : $("#planStart").val(),
					planEndDay : $("#planEnd").val(),
					planState : $("#select option:selected").val(),
					planFinishDate : $("#planFinishDate").val()
				},
				dataType : "json",
				success : function(data) {//인자 값은 서버에서 주는 메세지
					if (data.success) {
						$("#planState").val()=="";
						alert("일정이 변경되었습니다.")
						$("#planState").css("display", "inline");
						$("#select").css("display","none");
						$("#changeplan").css("display","inline");
						$("#changesuc").css("display","none");
						$(".edit").css("border-width","0px");
						$(".edit").attr("readonly",true);
					} else {
						alert("일정 변경을 실패했습니다.")
					}
				}
			});
			ajaxCall(obj);
		}
	});
	    
	//그룹 삭제 *그룹관리가 있는 페이지에는 모두 입력해야합니다.
	$("#groupDel").click(function() {
		//그룹 삭제 함수 호출
		groupDel();
	});
    
</script>
</html>


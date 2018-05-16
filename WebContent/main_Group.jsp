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
        , events: [
               {
                  title : "data.title"
                , start : "2018-05-01"
                , end : "2018-05-13"
            },
        ]
        , dayClick: function(date, allDay, jsEvent, view) {
        	
           var yy=date.format("YYYY");
           var mm=date.format("MM");
           var dd=date.format("DD");
           var date = yy+"/"+mm+"/"+dd;
           
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
			content += "</tr>"; 
		});		
		$("#PlanTable").empty();
		$("#PlanTable").append(content);
	}
});

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
			<table>
				<tr>
					<td>일정번호</td>
					<td><span id="planIdx"></span></td>
				</tr>
				<tr>
					<td>수행자</td>
					<td><span id="planMember"></span></td>
				</tr>			
				<tr>
					<td>타이틀</td>
					<td><span id="planTitle"></span></td>
				</tr>			
				<tr>
					<td>일정내용</td>
					<td><span id="planContent"></span></td>
				</tr>			
				<tr>
					<td>시작날짜</td>
				<td><span id="planStart"></span></td>
				</tr>							
				<tr>
					<td>종료예정날짜</td>
					<td><span id="planEnd"></span></td>
				</tr>
			</table>
        </div>
    </div>
</body>
<script>
	$(document).ready(function() {
		if('${sessionScope.loginId}'==""||'${sessionScope.groupNum}'==0){
			alert("로그인이 필요한 서비스입니다.");
			location.href="index.jsp";
		}
	});
	
	//그룹 삭제 *그룹관리가 있는 페이지에는 모두 입력해야합니다.
	$("#groupDel").click(function() {
		//그룹 삭제 함수 호출
		groupDel();
	});
    
</script>
</html>
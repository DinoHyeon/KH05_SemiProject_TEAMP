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
        left: 51%;
        width: 49%;
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
/*                {
                  title : "All Day Event"
                , start : "2016-05-01"
            },*/
        ]
        , dayClick: function(date, allDay, jsEvent, view) {
           var yy=date.format("YYYY");
           var mm=date.format("MM");
           var dd=date.format("DD");
           var date = yy+"/"+mm+"/"+dd;
           $(this).css('background-color', '#FFD724');
           $("td.fc-day.fc-widget-content").not($(this)).css('background-color', 'white')
/* 	   		obj.url="./todatPlanList";
	   		obj.data={};
	   		obj.data={menuName:$(this).attr("id")};
	   		obj.success = function(data) {
	   			
	   		}
	   		ajaxCall(obj); */
         }
    });
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
        
        </div>
        <div id="sectionDivisionLine"></div>
        <div id="todayPlanDetail">
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
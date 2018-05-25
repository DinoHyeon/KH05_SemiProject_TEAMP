<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link
	href="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.css"
	rel="stylesheet" />
<link
	href="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.print.css"
	rel="stylesheet" media="print" />
<script type="text/javascript"
	src="http://fullcalendar.io/js/fullcalendar-3.9.0/lib/moment.min.js"></script>
<script type="text/javascript"
	src="http://fullcalendar.io/js/fullcalendar-3.9.0/lib/jquery.min.js"></script>
<script type="text/javascript"
	src="http://fullcalendar.io/js/fullcalendar-3.9.0/fullcalendar.js"></script>
<script src='http://fullcalendar.io/js/fullcalendar-3.9.0/locale/ko.js'></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
body {
	margin: 0%;
}

#mainInfo {
	position: fixed;
	left: 82.5%;
	width: 17.5%;
	height: 100%;
	background-color: #004C63;
}

#logout {
	position: absolute;
	color: #004C63;
	left: 66%;
	top: 1.5%;
	width: 28%;
	height: 4%;
	font-weight: 900;
	font-size: 14px;
	background-color: #FFD724;
	text-align: center;
	line-height: 30px;
	border-radius: 8px;
}

#userName {
	position: absolute;
	color: #FFD724;
	width: 100%;
	text-align: center;
	top: 8%;
	font-weight: 900;
	font-size: 20px;
}

#groupState {
	position: absolute;
	color: #FFD724;
	width: 83%;
	top: 10.5%;
	font-weight: 900;
	font-size: 16px;
	text-align: center;
}

#groupName {
	position: absolute;
	color: #FFD724;
	width: 83%;
	top: 10.5%;
	left: 8%;
	font-weight: 900;
	font-size: 28px;
	text-align: center;
}

#Todo {
	position: absolute;
	color: white;
	width: 83%;
	top: 16%;
	font-weight: 500;
	font-size: 16px;
	text-align: center;
	backgour-color: "black";
	left: 2%;
}

#content {
	background-color: #004D65;
	border: 1px solid white;
	width: 225px;
	border-style: none none solid none;
	color: white;
	margin: 10;
}

.tododel {
	border: none;
	margin-bottom: 10px;
	background-color: #004D65;
	font-size: 20px;
	color: white;
}

button {
	margin-left: -20px;
	border: none;
	margin-bottom: 10px;
	background-color: #004D65;
	font-size: 20px;
	color: white;
}

#planList {
	position: absolute;
	float: left;
	height: 210%;
	width: 115%;
	top: 360%;
	font-weight: 500;
	font-size: 14px;
	text-align: left;
	background-color: #004C63;
	overflow: auto;
	border: 1px solid #FFD724;
}

#TodoList {
	position: absolute;
	float: left;
	height: 180%;
	width: 115%;
	top: 130%;
	font-weight: 500;
	font-size: 15px;
	text-align: left;
	background-color: #004C63;
	overflow: auto;
	border: 1px solid #FFD724;
}

#myPlan {
	position: absolute;
	top: 330%;
}

#myTodo {
	position: absolute;
	top: 100%;
}

#bordernone, #planTable, #TodoTable {
	border: none;
}

#TodoList::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #F5F5F5;
}

#TodoList::-webkit-scrollbar {
	width: 12px;
	background-color: #F5F5F5;
}

#TodoList::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #555;
}

#planList::-webkit-scrollbar-track {
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3);
	border-radius: 10px;
	background-color: #F5F5F5;
}

#planList::-webkit-scrollbar {
	width: 12px;
	background-color: #F5F5F5;
}

#planList::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #555;
}

.divnamecolor {
	color: #FFD724;
}

#logout {
	cursor: pointer;
}
</style>
</head>
<body>
	<div id="mainInfo">
		<div id="logout">로그아웃</div>
		<div id="userName"></div>
		<div id="groupState">현재 그룹이 없어요:(</div>
		<span id="groupName"></span>
		<div class="divnamecolor" id="Todo">
			<h3>
				<b>할일 입력란</b>
			</h3>
			<input id="content" type="text" maxlength="15" />
			<button id="insert">+</button>
			<div class="divnamecolor" id="myTodo">
				할일 리스트 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button id="slide">↕</button>
			</div>
			<div class="scrollbar" id="TodoList">
				<table id="TodoTable">
				</table>
			</div>

			<div class="divnamecolor" id="myPlan">
				나의 일정 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<button id="planslide">↕</button>
			</div>
			<div class="scrollbar" id="planList">
				<table id="planTable">
				</table>
			</div>
		</div>
	</div>
</body>
<script>
	var path = window.location.pathname;
	var loaction = "";
	if(path.indexOf('WriteForm')>-1||path.indexOf('writeForm')>-1){
		loaction= ".";
	}
	console.log(loaction);
	
	var content = "";
	var obj = {};
	obj.type = "post";
	obj.dataType = "json";
	obj.error = function(e) {
		console.log(e)
	};

	$("#logout").mouseenter(function() {
		$("#logout").css("background", "#00455A");
		$("#logout").css("color", "#FFD724")
		$("#logout").mouseleave(function() {
			$("#logout").css("background", "#FFD724");
			$("#logout").css("color", "#004D65")
		})
	})
	
	$("#logout").click(function() {
		$.ajax({
			type:"post",
			url:"./logout",
			success:function(data){//인자 값은 서버에서 주는 메세지
					alert("다음에도 방문해주세요.");	
					location.href="index.jsp";
			},
			error:function(err){//인자 값은 서버에서 주는 메세지
				console.log(err)
			}
		});
	})

	//페이지가 로드되었을 때 session에 그룹번호가 없는 경우 화면을 다르게 보여줘야한다.
	$(document).ready(function() {
		console.log(loaction);
		obj.url = loaction+"./planToday";
		obj.success = function(data) {
			console.log(data.groupName.group_name);
			$("#groupName").html(data.groupName.group_name	);
			data.list.forEach(function(item, idx) {
				content += "<tr id='bordernone'>";
				content += "<td id='bordernone'> -  " + item.plan_title + "</td>";
				content += "<td id='bordernone'>―</td>";
				content += "<td id='bordernone'>" + item.plan_state + "</td>";
				content += "</tr id='bordernone'>";
			});
			$("#planTable").empty();
			$("#planTable").append(content);
			content = "";
		};
		ajaxCall(obj);
	});

	if ('${sessionScope.loginId}' == "") {
		alert("로그인이 필요한 서비스입니다.");
		location.href = "index.jsp";
		//로그인상태면 할일 리스트 뽑아오는todoDetail실행
	} else if ('${sessionScope.loginId}' !== "") {
		$("#TodoTable").empty();
		listPrint();
	}

	//세션에 저장되어 있는 groupNum이 0이라면(*0은 현재 가입되어 있는 그룹이 없는 것을 의미)
	if ('${sessionScope.groupNum}' == 0) {
		//button의 css속성 값을 변경
		$("input[type='button']").css("display", "inline");
	} else {
		$("#groupState").html('');
	}

	$("button").click(function() {
		$("button").css("font-weight", "normal");
		$(this).css("font-weight", "900");
	})

	$("#insert").click(function() {
		if ($("#content").val() == "") {
			alert("내용을 입력해주세요.");
			$("#content").focus();
		} else {
			$.ajax({
				type : "post",
				url : loaction+"./todoWrite",
				data : {
					content : $("#content").val()
				},
				dataType : "json",
				success : function(data) {//인자 값은 서버에서 주는 메세지
					if (data.success) {
						$("#TodoTable").empty();
						listPrint();
						$("#content").val("");
					} else {
						alert("할일 등록실패")
					}
				}
			});
			ajaxCall(obj);
		}
	});

	function listPrint() {
		obj.url = loaction+"./todoDetail"
		obj.success = function(data) {
			data.list
					.forEach(function(item, idx) {
						content += "<tr id='bordernone'>";
						content += "<td id='bordernone'><input class='tododel' value='-' type='button' id="+ item.to_do_idx + "></td>";
						content += "<td id='bordernone'>" + item.todo_content + "</td>";
						content += "</tr id='bordernone'>";
					});
			$("#TodoTable").empty();
			$("#TodoTable").append(content);
			content = "";
		}
		ajaxCall(obj);
	}

	$(document).on('click','.tododel', function() {
		$.ajax({
			type : "post",
			url : loaction+"./todoDelete",
			data : {
				delcontent : $(this).attr('id')
			},
			dataType : "json",
			success : function(data) {//인자 값은 서버에서 주는 메세지
				if (data.success) {
					//listPrint(data.list)
					$("#TodoTable").empty();
					listPrint();
					$("#content").val("");
				} else {
					alert("삭제 실패")
				}
			}
		});
		ajaxCall(obj);
	});

	$("#slide").click(function() {
		$("#TodoList").slideToggle("slow")
	})

	
	$("#planslide").click(function() {
		$("#planList").slideToggle("slow");
	});

	function ajaxCall(param) {
		$.ajax(param);
	}
</script>
</html>
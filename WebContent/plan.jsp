<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
/* 페이지 영역을 잡기 위한 css 설정입니다. */
#page {
	position: absolute;
	top: 22.9%;
	width: 82.5%;
	height: 77.1%;
	background-color: "white";
}

#plusplan {
	border-radius: 8px;
	border: none;
	width: 20%;
	top: 10%;
	height: 7%;
}

#navitwo {
	position: absolute;
	width: 82.5%;
	height: 8%;
	top: 15%;
	background-color: #CEFBC9;
}

#navithree {
	position: absolute;
	background-color: none;
	left: 91%;
	top: 15.7%;
	width: 35%;
}

#navithree button {
	border: none;
	background-color: #566A70;
	font-size: 14px;
	margin: 2%;
	padding: 2%;
	color: white;
	border: none;
}

/* 팝업 내용 */
#popupContent {
	position: absolute;
	display: none;
	z-index: 3;
	top: 13%;
	left: 18%;
	width: 60%;
	height: 75%;
	background-color: #004C63;
}

/* 일정 수정,삭제 팝업 내용 */
#Infopopup {
	position: absolute;
	display: none;
	z-index: 3;
	top: 13%;
	left: 18%;
	width: 60%;
	height: 75%;
	background-color: #004C63;
}

.mainPopupClose {
	position: absolute;
	font-size: 18px;
	font-weight: 900;
	color: white;
	left: 97%;
	top: 2%;
	display: inline;
}

#planinfo {
	margin-left: 26%;
	padding: 10 10;
	margin-top: 5%;
}
#planinfo:hover{
	background-color: gray;
}

#g {
	color: white;
	margin-left: 42%;
}

#plusplus {
	color: white;
	margin-left: 47%;
	margin-top: 1.5%;
	position: absolute;
	background-color: #FFD724;
	color: #004C63;
	text-align: center;
	line-height: 33px;
	font-weight: 900;
	border-radius: 8px;
	display: block;
}

#delp {
	color: white;
	margin-left: 59%;
	margin-top: 3.5%;
	position: absolute;
	background-color: #FFD724;
	color: #004C63;
	text-align: center;
	line-height: 33px;
	font-weight: 900;
	border-radius: 8px;
	display: block;
}

#PlanPlusBnt {
	background-color: #FFD724;
	color: #004C63;
	position: absolute;
	text-align: center;
	line-height: 33px;
	font-weight: 900;
	border-radius: 8px;
	display: block;
	border: none;
}

#PlanPlusBnt:hover {
	cursor: pointer;
	background-color: #004C63;
	color: #FFD724;
}

#PlandelBnt {
	color: white;
	position: absolute;
	background-color: #FFD724;
	color: #004C63;
	text-align: center;
	line-height: 33px;
	font-weight: 900;
	border-radius: 8px;
	display: block;
	border: none;
}

#PlandelBnt:hover {
	cursor: pointer;
	background-color: #004C63;
	color: #FFD724;
}

#changeplan {
	margin-left: 35%;
	margin-top: 3.5%;
	position: absolute;
	background-color: #FFD724;
	color: #004C63;
	text-align: center;
	line-height: 33px;
	
	border-radius: 8px;
	display: block;
}

#PlaneditBnt {
	color: white;
	margin-left: 35%;
	margin-top: 3.5%;
	position: absolute;
	background-color: #FFD724;
	color: #004C63;
	text-align: center;
	line-height: 33px;

	border-radius: 8px;
	display: block;
	display: none;
	margin-top: 3.5%;
}

#planedit {
	margin-left: 26%;
	padding: 10 10;
	margin-top: 0%;
}

table, td, th {
	border: 1px solid #004C63;
	border-collapse: collapse;
	padding: 10 5;
	text-align: center;
}

#popupContent table td input[type='text'], input[type='date'] {
	width: 99%;
	height: 70%;
	text-align: center;
}

#Infopopup table td input[type='text'] {
	width: 99%;
	height: 70%;
	text-align: center;
}


/* 팝업배경 */
#groupBg {
	position: absolute;
	display: none;
	background-color: black;
	opacity: 0.7;
	z-index: 3;
	width: 100%;
	height: 100%;
}
.plan_title:hover{
	background-color: yellow;
	cursor: pointer;
}


</style>
</head>
<body>
	<%@include file="../headerMenu.jsp"%>
	<%@include file="../sideMenu.jsp"%>

	<c:if test="${sessionScope.memberLv == 'master'}">
		<div id="navitwo">
			<div id="navithree">
				<button id="plusplan">일정추가</button>

			</div>
		</div>
	</c:if>

<!--일정 정보(추가) 팝업  -->
	<div id="popupContent">
		<div class="mainPopupClose">X</div>
		<form action="./planWrite" method="post">
			<h2 id="g">[ 일정 정보 ]</h2>
			<table id="planinfo">
				<tr>
					<td id="g">수행자</td>
					<td id="g"><div id="MemberList"></div></td>

				</tr>

				<tr>
					<td id="g">일정 - 시작</td>

					<td id="g"><input name="startDate" type="date" /></td>
				</tr>
				<tr>
					<td id="g">일정 - 종료</td>

					<td id="g"><input name="endDate" type="date" /></td>
				</tr>
				<tr>
					<td id="g">제목</td>
					<td><input name="plantitle" type="text" /></td>
				</tr>
				<tr>
					<td id="g">내용</td>
					<td><textarea id="plancontent" rows="20" cols="50"
							style="resize: none"></textarea></td>
				</tr>




			</table>

			<div id="plusplus">
				<input id="PlanPlusBnt" type="button" value="일정추가">
			</div>
		</form>
	</div>


	<div id="groupBg"></div>
	<!-- 팝업이 띄워졌을 때 홈페이지에 깔리는 불투명한 배경 -->

	<!--  일정상세보기팝업 수정/삭제 -->
	<div id="Infopopup">
		<div class="mainPopupClose">X</div>

		<h2 id="g">[ 일정 수정,삭제 ]</h2>
		<table id="planedit">

			<input type="hidden" id="planIdx">
			<input type="hidden" id="planFinishDate">
			<tr>
				<td id="g">수행자</td>
				<td id="g"><input type="text" id="planMember" readonly></td>

			</tr>
			<tr>
				<td id="g">일정 시작</td>
				<td id="g"><input type="date" class="edit" id="planStart"
					readonly></td>
			</tr>
			<tr>
				<td id="g">일정 종료</td>
				<td id="g"><input type="date" class="edit" id="planEnd"
					readonly></td>
			</tr>
			<tr>
				<td id="g">제목</td>
				<td id="g"><input type="text" class="edit" id="planTitle"
					readonly></td>
			</tr>
			<tr>
				<td id="g">내용</td>
				<td><textarea id="planContent" class="edit" rows="20" cols="50"
						style="resize: none" readonly></textarea></td>
			<tr>
				<td id="g">상태</td>
				<td><select id="select" name="job">
						<option value="준비중">준비중</option>
						<option value="진행중">진행중</option>
						<option value="완료">완료</option>
				</select></td>
			</tr>

			<tr>

			</tr>

		</table>
		<div id="delp">
			<input id="PlandelBnt" type="button" value="일정 삭제">
		</div>
		<div id="changeplan">일정 수정</div>
		<div id="PlaneditBnt">일정 등록</div>
	</div>

	<div id="page">
		<table id="1115" style="width: 100%;">
		</table>
	</div>


</body>
<script>
	var groupStartDay = "";
	var groupEndDay = "";
	var obj = {};
	var idx;
	obj.type = "POST";
	obj.dataType = "JSON";

	obj.error = function(e) {
		console.log(e)
	};

	var date = [];
	var day = [];
	var content = "";

	/* 현재 날짜를 구함  */	
	$(document).ready(
			function() {

				var dt;
				dt = new Date();
				dt = dt.getFullYear() + "/0" + (dt.getMonth() + 1) + "/"
						+ dt.getDate();
				console.log("오늘날짜" + dt);

				$("#planFinishDate").val(dt);

				planListCall();
			});

	
	
	/*일정페이지의 wbs의 일정 이름 부분 클릭시 일정 수정,삭제 팝업  */
	$(document).on('click', '.plan_title', function() {
		var tr = $(this);

		var detail = tr[0].id;
		Clicklist(detail);

		$("#groupBg").css("display", "inline");
		$("#Infopopup").css("display", "inline");
	})
	/*일정페이지의 wbs의 수행자부분 클릭시 일정 수정,삭제 팝업  */

	$(document).on('click', '.member_id', function() {
		var tr = $(this);

		var detail = tr[0].id;
		Clicklist(detail);
		$("#groupBg").css("display", "inline");
		$("#Infopopup").css("display", "inline");
	})
	/*일정페이지의 wbs의 상태 부분 클릭시 일정 수정,삭제 팝업  */

	$(document).on('click', '.plan_state', function() {
		var tr = $(this);

		var detail = tr[0].id;
		Clicklist(detail);

		$("#groupBg").css("display", "inline");
		$("#Infopopup").css("display", "inline");
	})


	
	//일정 삭제 버튼
	$("#PlandelBnt").click(function() {
		var detail = $("#planIdx").val();
		console.log(detail);
		//var detail=
		obj.url = "./planDelete";
		obj.date = {
			detail : detail
		};
		obj.success = function(data) {
			console.log("성공");
			if (data.success > 0) {
				alert("삭제에 성공하였습니다.")
				planListCall();
				$("#groupBg").css("display", "none");
				$("#Infopopup").css("display", "none");
			} else {
				alert("삭제 실패")
			}
		}
		ajaxCall(obj);
	})

	
	/* 일정 수정 버튼  */
	$("#changeplan").click(function() {

		$(".edit").css("border-width", "1px");
		$(".edit").attr("readonly", false);

	});
   /*  일정 수정 버튼 */
	$("#changeplan").click(function() {
		$("#planState").css("display", "none");
		$("#select").css("display", "inline");
		$("#PlaneditBnt").css("display", "inline");
		$(".edit").css("border-width", "1px");
		$(".edit").attr("readonly", false);
		$("#changeplan").css("display", "none");
	});

	//일정 등록 버튼 클릭시 
	$("#PlaneditBnt").click(function() {
	


		var startDay = $("#planStart").val();

		var endDay = $("#planEnd").val();

        /* 프로젝트의 시작 날짜와 종료 날짜 */

		console.log("시작 설정일" + startDay);
		console.log("종료 설정일" + endDay);
		if ($("#planTitle").val() == "") {
			alert("제목을 입력해주세요")
		} else if (startDay > endDay) {
			alert("일정 시작일이 종료일보다 빠를 수 없습니다.");
		} else if (groupStartDay > startDay) {
			alert("일정시작일이 프로젝트 시작일보다 빠를 수 없습니다. ");
		} else if (endDay > groupEndDay) {
			alert("일정 종료일이 프로젝트 종료일을 초과할 수 없습니다.");
		}

		else {
			$.ajax({
				type : "post",
				url : "./planChange",
				data : {
					planIdx : $("#planIdx").val(),
					planMember : $("#planMember").val(),
					planStartDay : $("#planStart").val(),
					planEndDay : $("#planEnd").val(),
					planTitle : $("#planTitle").val(),
					planContent : $("#planContent").val(),
					planState : $("#select option:selected").val(),
					planFinishDate : $("#planFinishDate").val()
				},
				dataType : "json",
				success : function(data) {//인자 값은 서버에서 주는 메세지
					if (data.success) {
						alert("일정이 변경되었습니다.")
						planListCall();
						$("#groupBg").css("display", "none");

						$("#Infopopup").css("display", "none");
						$("#select").css("display", "none");
						$("#changeplan").css("display", "inline");
						$("#PlaneditBnt").css("display", "none");
						$(".edit").css("border-width", "0px");
						$(".edit").attr("readonly", true);
					} else {
						alert("일정 변경을 실패했습니다.")
					}
				}
			});

		}
		console.log(planIdx)
		ajaxCall(obj);
	})

	/* 일정 디테일 */
	function Clicklist(detail) {
		obj.url = "./planDetail";
		obj.data = {
			detail : detail
		};
		obj.success = function(data) {
			if (data.success) {
				$("#planIdx").val(data.plandetail.plan_idx);
				$("#planMember").val(data.plandetail.member_id);
				$("#planStart").val(data.plandetail.plan_startDay);
				$("#planEnd").val(data.plandetail.plan_endDay);
				$("#planTitle").val(data.plandetail.plan_title);
				$("#planContent").val(data.plandetail.plan_content);
			} else {
				alert("실패");
			}
		}
		ajaxCall(obj);
	}

	/* wbs 테이블 */
	function planListCall() {
		obj.url = "./planTableList";
		obj.data = {};
		obj.success = function(data) {
			console.log(data);
			var dayNum = 0;
			var DupleMonthNum_key = [];
			var DupleMonthNum_value = [];
			var DupleMonthNum;
			date = data.date;
			day = data.day;
			dayNum = data.day.length;
			DupleMonthNum = DuplicatesChk(data.month);

			console.log(DupleMonthNum);

			//중복 월(key)과 중복 갯수(value)를 각각 배열에 담음
			$.each(DupleMonthNum, function(key, value) {
				DupleMonthNum_key.push(key);
				DupleMonthNum_value.push(value);
			});

			/* 테이블 생성 apeend */
			content += "<tr id='title'>";
			content += "<td  class='plan_title' rowspan='2'>일정</td>";
			content += "<td class='member_id' rowspan='2'>수행자</td>";
			content += "<td class='plan_state' rowspan='2'>상태</td>";
			content += "<td class='plan_startDay' rowspan='2'>시작일</td>";
			content += "<td class='plan_endDay' rowspan='2'>종료일</td>";

			for (var i = 0; i < DupleMonthNum_key.length; i++) {//달 td생성을 위한 for
				content += "<td colspan="+DupleMonthNum_value[i]+">"
						+ DupleMonthNum_key[i] + "</td>";
			}
			content += "</tr>";
			content += "<tr>";
			for (var i = 0; i < day.length; i++) {
				content += "<td>" + day[i] + "</td>";
			}
			content += "</tr>";

			//<td><a href="detail?idx=${bbs.bbs_idx}">${bbs.bbs_subject }</a></td>

			data.planList
					.forEach(function(item, index) {
						content += "<tr class="+item.plan_idx+">";
						// content +="<td class='plan_title' rowspan='2'><a href='planlist?idx="+item.plan_idx+"'>"+item.plan_title+"</a></td>";//일정
						content += "<td class='plan_title' rowspan='2' id="+item.plan_idx+">"
								+ item.plan_title + "</a></td>";//일정
						content += "<td class='member_id' rowspan='2' id="+item.plan_idx+" vlaue="+item.member_id+">"
								+ item.member_id + "</td>";//수행자
						content += "<td class='plan_state' rowspan='2' id="+item.plan_idx+">"
								+ item.plan_state + "</td>";//상태
						content += "<td class='plan_startDay' id="+item.plan_startDay+" rowspan='2'>"
								+ item.plan_startDay + "</td>";//시작일
						content += "<td class='plan_endDay' id="+item.plan_endDay+" rowspan='2'>"
								+ item.plan_endDay + "</td>";//종료일
						content += "</tr>";

						for (var i = 0; i < day.length; i++) {
							content += "<td class="+item.plan_idx+" id="+date[i]+">　</td>";
						}
					});

			$("#1115").empty();
			$("#1115").append(content);

			data.planList
					.forEach(function(item, index) {
						var betweenDateArr = betweenDate(item.plan_startDay,
								item.plan_endDay);
						for (var j = 0; j < betweenDateArr.length; j++) {
							for (var i = 0; i < day.length; i++) {
								if ($("td[class=" + item.plan_idx + "]")[i].id == betweenDateArr[j]) {
									$("td[class=" + item.plan_idx + "]")[i].style.backgroundColor = 'yellow';
								}
							}
							if (item.plan_state == '완료') {
								for (var i = 0; i < day.length; i++) {
									if ($("td[class=" + item.plan_idx + "]")[i].id == item.plan_plan_finishDate) {
										$("td[class=" + item.plan_idx + "]")[i].style.backgroundColor = 'red';
									}
								}
							}
						}

					});

			/* 			$("td[class='9']").each(function(idx){
							console.log($(this)[0].id)
						});
			 */

			content = "";
		}
		ajaxCall(obj);
	}

	/* 중복값의 개수를 반환해주는 함수 */
	function DuplicatesChk(arr) {
		var results = {};
		var over = 0;
		for (var i = 0; i < arr.length; i++) {
			for (var j = 0; j < arr.length; j++) {
				if (arr[i] == arr[j]) {
					over++;
					results[arr[i]] = over;
				}
			}
			over = 0;
		}
		return results;
	}

	//시작 날짜와 종료 날짜 사이에 있는 날짜를 구하여 배열에 담는 함수
	function betweenDate(startDay, endDay) {
		var startDayInfo = startDay.split("-");
		var endDayInfo = endDay.split("-");
		var betweenDate = []; //날짜 사이에 있는 값을 저장할 배열
		//시작날짜
		var betweenDay = new Date(startDayInfo[0], startDayInfo[1] - 1,
				startDayInfo[2]);//계산 결과 값을 담을 변수

		var startDayDate = new Date(startDayInfo[0], startDayInfo[1] - 1,
				startDayInfo[2]);//시작일 Date
		var endDayDate = new Date(endDayInfo[0], endDayInfo[1] - 1,
				endDayInfo[2]);//종료일 Date

		/* 결과 값을 담을 배열에 미리 담아놓을 시작일 */
		var startYear = startDayDate.getFullYear();
		var startMonth = startDayDate.getMonth() + 1;
		if (startMonth < 10) {
			startMonth = "0" + startMonth
		}
		;
		var startDate = startDayDate.getDate()
		if (startDate < 10) {
			startDate = "0" + startDate
		}
		;
		betweenDate.push(startYear + "-" + startMonth + "-" + startDate);

		/* 시작일과 종료일의 차이 */
		var btMs = endDayDate.getTime() - startDayDate.getTime();
		var btDay = btMs / (1000 * 60 * 60 * 24);

		/* 시작일과 종료일 사이에 있는 날짜를 구하기 */
		for (var i = 0; i < btDay; i++) {
			betweenDay.setDate(betweenDay.getDate() + 1);

			var year = betweenDay.getFullYear();
			var month = betweenDay.getMonth() + 1;
			if (month < 10) {
				month = "0" + month
			}
			;
			var date = betweenDay.getDate()
			if (date < 10) {
				date = "0" + date
			}
			;
			betweenDate.push(year + "-" + month + "-" + date);
		}
		return betweenDate;
	}

	/*  */

	var groupidx = '${sessionScope.groupNum}';

	$("#plusplan").click(function() {
		$("#groupBg").css("display", "inline");

		$("#popupContent").css("display", "inline");
		InfoLoad();
	})

	$("#changeplan").click(function() {
		$("#Infopopup").css("display", "inline");
	})

	$(".mainPopupClose").click(function() {
		if ($("#popupContent").css("display") != "none") {
			$("#groupBg").css("display", "none");
			$("#popupContentMaster").css("display", "none");
		}

	})

		//팝업창의 닫기 부분 클릭시 
	$(".mainPopupClose").click(function() {
		if ($("#popupContent").css("display") != "none") {
			$("#groupBg").css("display", "none");
			$("#popupContent").css("display", "none");
			//$("#popupContenMember").css("display","none");
		}

		if ($("#Infopopup").css("display") != "none") {
			$("#groupBg").css("display", "none");

			$("#Infopopup").css("display", "none");
		}

	})
	//일정 추가버튼을 누를때 
	$("#PlanPlusBnt").click(
			function() {

				InfoLoad();
				console.log("시작일 " + groupStartDay);

				var startDay = $("#planStart").val();
				var endDay = $("#planEnd").val();
				;
				var groupstartDay = new Date(groupStartDay);

				if ($("input[name='plantitle']").val() == "") {
					alert("제목을 입력해주세요")
				} else if ($("input[name='startDate']").val() > $(
						"input[name='endDate']").val()) {
					alert("일정 시작일이 종료일보다 빠를 수 없습니다.");
				} else if (groupStartDay > $("input[name='startDate']").val()) {
					alert("일정시작일이 프로젝트 시작일보다 빠를 수 없습니다. ");
				} else if ($("input[name='endDate']").val() > groupEndDay) {
					alert("일정 종료일이 프로젝트 종료일을 초과할 수 없습니다.");
				} else {
					obj.url = "./planWrite";
					obj.data = {
						groupidx : groupidx,
						member : $("#memberid").val(),
						StartDay : $("input[name='startDate']").val(),
						endDay : $("input[name='endDate']").val(),
						content : $("#plancontent").val(),
						title : $("input[name='plantitle']").val()

					};
					obj.success = function(data) {
						console.log(data.success)
						if (data.success > 0) {
							alert("일정 추가성공");
							planListCall();
							$("#popupContent").css("display", "none");
							$("#groupBg").css("display", "none");

						} else {
							alert("일정 추가실패");
							planListCall();
						}
					}
				}
				ajaxCall(obj);

			})

	function InfoLoad() {
		obj.url = "./groupDetail";
		obj.data = {};
		obj.data = {
			groupIdx : groupIdx
		};
		obj.success = function(data) {
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
			MemberListCall();

		};
		ajaxCall(obj);
	}

	function MemberListCall() {
		obj.url = "./groupMemberList";
		obj.data = {
			groupIdx : groupIdx
		};
		obj.success = function(data) {
			console.log("멤버 그룹 조회");
			$("#MemberList").empty();
			// $("#groupInquiryMemberList").empty();
			groupMemberContent = "";
			groupMemberContent += "<select id='memberid'>";
			//그룹장
			data.groupMember.forEach(function(item, index) {
				groupMemberContent += "<option value="+item.groupMember_id+">"
						+ item.groupMember_id + "</option>";
				// groupMemberContent="";
			})
			$("#MemberList").append(groupMemberContent);
			groupMemberContent += "</select>";
		}

		ajaxCall(obj);
	}

	function ajaxCall(param) {
		$.ajax(param);
	}
</script>
</html>
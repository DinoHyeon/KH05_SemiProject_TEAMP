<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<button>버튼</button>
	<table id="1115">
	
	</table>
</body>
<script>
	var day = {};
	var dayNum = 0;
	var nonDupleMonth = {};
	var nonDupleMonthNum = 0;
	var DupleMonthNum = 0;
	var obj = {};
	var content = "";
	
	obj.type="POST";
	obj.dataType="JSON";
	obj.error=function(e){console.log(e)};		

	$("button").click(function() {
		obj.url="./planTableList";
		obj.data={};
		obj.success=function(data){
				console.log(data);
				day = data.day;
				dayNum = data.day.length;
				nonDupleMonth=removeDuplicatesArray(data.month);
				nonDupleMonthNum=nonDupleMonth.length;
				DupleMonthNum=DuplicatesChk(data.month);
				console.log(day);//일
				console.log(nonDupleMonth);//중복을 제거한 달이 담긴 배열
				console.log(nonDupleMonthNum);//중복을 제거한 달의 개수
				console.log(DupleMonthNum);
				var keyName=Object.keys(DupleMonthNum)[0];//05
	
				
	 			/* 테이블 생성 apeend */
	 			/* content += "<tr>";
				content += "<td rowspan='2'>일정</td>";
				content += "<td rowspan='2'>수행자</td>";
				content += "<td rowspan='2'>상태</td>";
				content += "<td rowspan='2'>시작일</td>";
				content += "<td rowspan='2'>종료일</td>";
				
				for(var i=0; i<nonDupleMonthNum.length; i++){//달 td생성을 위한 for
					var colspan = 0;
					
				}
					content += "<td colspan="+colspan+">일정</td>";
			}
			content += "</tr>";  */
			
		}
		ajaxCall(obj);
	});
	
	
	/* colspan에 들어갈 숫자를 구하는 함수 */
	function getColspan(DupleMonthNum) {
		var colspan=0;
	}
	
	/* 중복값을 제거하여 리턴해주는 함수 */
	function removeDuplicatesArray(arr) {//arr은 중복제거를 할 배열
		var tempArr = [];
		for(var i=0; i<arr.length; i++){//arr의 크기만큼 반복
			if(tempArr.length==0){//tempArr의 크기가 0이면
				tempArr.push(arr[i]);//arr의 i번째 값을 tempArr에 넣는다.
			}else{//0이 아니라면
				var duplicatesFlag=true;
				for(var j=0; j< tempArr.length; j++){//tempArr에 크기만큼 반복한다
					if(tempArr[j]==arr[i]){//tempArr j번째의 값과 arr i번째의 값이 같으면
						duplicatesFlag = false;
						break;//반복문 정지 40번째
					}
				}
			}
		
			if (duplicatesFlag){//true라면
				tempArr.push(arr[i]);
			}
		}
		return tempArr;
	}
	
	
	/* 중복값의 개수를 반환해주는 함수 */
	function DuplicatesChk(arr) {
		var results = new Array();
		for(var j=0; j<arr.length; j++){
			var key = arr[j].toString();//오브젝트 관련인거같음...
			if(!results[key]){
				results[key] = 1;
			}else{
				results[key]=results[key] + 1;
			}
		}
		var str = "";
		for (var j in results) {
			   str += j + ": " + results[j];
			}
		alert(str);
		return results;
	}
	
	
	/* ajax실행 호출 함수 */
	function ajaxCall(param){
		$.ajax(param);
	}	
</script>
</html>
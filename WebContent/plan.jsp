<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		      top: 22.9%;
		      width: 82.5%;
		       height: 77.1%;
		      background-color: "white";
		      }
		     table,td,th{
		         border: 1px solid black;
		         border-collapse: collapse;
		         padding: 10 5;
		         text-align: center;
		      }
			#navitwo{
			    position: absolute;
			    width: 82.5%;
			    height: 8%;
			    top:15%;
			    background-color: black;
		    }
			#navithree{
				position: absolute;
				background-color: none;
				left : 81%;
				top : 15.7%;
				width: 35%;           
		    }      
			            
		 	#navithree button{
				border: none;
				background-color: black;
				font-size: 14px;
				
				padding : 3%;
				color : white;
				border : 1px solid black;
			}       
			            
		     /* 팝업 내용 */
		   #popupContent{
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
		   #Infopopup{
		      position: absolute;
		       display: none;
		       z-index: 3;
		       top: 13%;
		       left: 18%;
		       width: 60%;
		       height: 75%;
		       background-color: #004C63;
		   }  
		   
		   .mainPopupClose{
		      position: absolute;
		      font-size: 18px;
		      font-weight: 900;
		      color: white;
		      left: 97%;
		      top: 2%;
		      display: inline;
		   }                     
		          
		
		         
		</style>
	</head>
	<body>
	   <%@include file="../headerMenu.jsp"%>
	   <%@include file="../sideMenu.jsp"%>
	   
	   <c:if test="${sessionScope.memberLv == 'master'}">
		   <div id="navitwo">
		   <div id="navithree">
		   <button id="plusplan">일정추가 </button>
		   <button id="changeplan"> 일정 수정,삭제</button>
		   </div>
		   </div>
	   </c:if>
	   
	   
	    <div id="popupContent">
	      <div class="mainPopupClose">X</div>
	      <form action="./planWrite" method="post">
	      <h2>일정 정보</h2>
	         <table>
	               <tr>
	               <td>수행자</td>
	              <td><div id="MemberList"></div></td>   
	                  
	                  </tr>         
	                                       
	               <tr>
	                  <td>일정 - 시작</td>
	               
	                  <td><input name="startDate" type="date"/></td>
	               </tr>
	            <tr>
	               <td>일정 - 종료</td>
	               
	                  <td><input name="endDate" type="date"/></td>
	               </tr>      
	            <tr>
	               <td>제목</td>
	               <td><input name="plantitle" type="text"/></td>
	            </tr>
	            <tr>
	               <td>내용</td>
	               <td>
	                  <textarea id="plancontent" rows="20" cols="50" style="resize: none"></textarea>
	               </td>
	            </tr>
	            
	            <tr>
	                  <td><input id="PlanPlusBnt" type="button" value="일정추가"></td>
	               </tr>      
	               
	            
	               
	         </table>
	         <div id="groupmemberName">그룹원</div>
	         
	      </form>
	         </div>   
	         
	   
	       <div id="Infopopup">
	             <div class="mainPopupClose">X</div>
	       
	         <h2>일정 </h2>
	         <table>
	            <tr>
	               <td>수행자</td>
	              <td><div id="person"></div></td>   
	            </tr>
	            <tr>
	               <td>일정기간</td>
	               <td><span></span></td>
	            </tr>
	            <tr>
	               <td>제목</td>
	               <td><span></span></td>
	            </tr>
	            <tr>
	               <td>내용</td>
	               <td>
	                  <textarea id="inviteMsg" rows="20" cols="50" style="resize: none"></textarea>
	               </td>
	               
	            </tr>
	               <tr>
	                  <td><input id="PlanPlusBnt" type="button" value="일정삭제"></td>
	               </tr>   
	                  <tr>
	                  <td><input id="PlanPlusBnt" type="button" value="일정수정"></td>
	               </tr>   
	         </table>
	      
	         </div>            
	   	
	   		<div id="page">
	   			<table id="1115" style="width:100%;">
				</table>
	   		</div>
	   
	   
	</body>
	<script>
		var date = [];
		var day = [];
		var content = "";
	
		$(document).ready(function(){
			planListCall();
		});
		
		
		function planListCall(){
			obj.url="./planTableList";
			obj.data={};
			obj.success=function(data){
				console.log(data);
				var dayNum = 0;
				var DupleMonthNum_key=[];
				var DupleMonthNum_value=[];
				var DupleMonthNum;
				date = data.date;
				day = data.day;
				dayNum = data.day.length;
				DupleMonthNum=DuplicatesChk(data.month);
				
				console.log(DupleMonthNum);
				
				//중복 월(key)과 중복 갯수(value)를 각각 배열에 담음
				$.each(DupleMonthNum, function(key, value){
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
				
				for(var i=0; i<DupleMonthNum_key.length; i++){//달 td생성을 위한 for
					content += "<td colspan="+DupleMonthNum_value[i]+">"+DupleMonthNum_key[i]+"</td>";
				}
				content += "</tr>";
				content += "<tr>";
				for(var i=0; i<day.length; i++){
					content += "<td>"+day[i]+"</td>";
				}
				content += "</tr>"; 
				
				data.planList.forEach(function(item,index){
					 content +="<tr class="+item.plan_idx+">";
					 content +="<td class='plan_title' rowspan='2'>"+item.plan_title+"</td>";//일정
					 content +="<td class='member_id' rowspan='2'>"+item.member_id+"</td>";//수행자
					 content +="<td class='plan_state' rowspan='2'>"+item.plan_state+"</td>";//상태
					 content +="<td class='plan_startDay' id="+item.plan_startDay+" rowspan='2'>"+item.plan_startDay+"</td>";//시작일
					 content +="<td class='plan_endDay' id="+item.plan_endDay+" rowspan='2'>"+item.plan_endDay+"</td>";//종료일
					 content +="</tr>";
					 
					for(var i=0; i<day.length; i++){
						content += "<td class="+item.plan_idx+" id="+date[i]+">　</td>";
					}
			      });   
				
				$("#1115").empty();
				$("#1115").append(content);
				
				
				data.planList.forEach(function(item,index){
					var betweenDateArr = betweenDate(item.plan_startDay, item.plan_endDay);
					for(var j=0; j<betweenDateArr.length; j++){
						for(var i=0; i<day.length; i++){
							if($("td[class="+item.plan_idx+"]")[i].id==betweenDateArr[j]){
								$("td[class="+item.plan_idx+"]")[i].style.backgroundColor = 'yellow';
							}
		   				}
						if(item.plan_state=='완료'){
							for(var i=0; i<day.length; i++){
								if($("td[class="+item.plan_idx+"]")[i].id==item.plan_plan_finishDate){
									$("td[class="+item.plan_idx+"]")[i+1].style.backgroundColor = 'red';
								}
			   				}
						}
					} 
	
			    });   
				
	
	/* 			$("td[class='9']").each(function(idx){
					console.log($(this)[0].id)
				});
				 */
				
				
				content="";
			} 
			ajaxCall(obj);
		}
		
		/* 중복값의 개수를 반환해주는 함수 */
		function DuplicatesChk(arr) {
			var results = {};
			var over = 0;
			for(var i=0; i<arr.length; i++){
				for(var j=0; j<arr.length; j++){
					if(arr[i]==arr[j]){
						over++;
						results[arr[i]]=over;
					}
				}
				over=0;
			}
			return results;
		}
		
		
		//시작 날짜와 종료 날짜 사이에 있는 날짜를 구하여 배열에 담는 함수
		function betweenDate(startDay, endDay){
			var startDayInfo = startDay.split("-");
			var endDayInfo = endDay.split("-");
			var betweenDate = []; //날짜 사이에 있는 값을 저장할 배열
			//시작날짜
			var betweenDay = new Date(startDayInfo[0], startDayInfo[1]-1, startDayInfo[2]);//계산 결과 값을 담을 변수
			
			var startDayDate = new Date(startDayInfo[0], startDayInfo[1]-1, startDayInfo[2]);//시작일 Date
			var endDayDate = new Date(endDayInfo[0], endDayInfo[1]-1, endDayInfo[2]);//종료일 Date
			
			/* 결과 값을 담을 배열에 미리 담아놓을 시작일 */
			var startYear = startDayDate.getFullYear();
			var startMonth = startDayDate.getMonth()+1;
			if(startMonth<10){startMonth = "0" + startMonth};
			var startDate = startDayDate.getDate()
			if(startDate<10){startDate = "0" + startDate};
			betweenDate.push(startYear+"-"+startMonth+"-"+startDate);
			
			/* 시작일과 종료일의 차이 */
			var btMs = endDayDate.getTime() - startDayDate.getTime();
			var btDay = btMs / (1000*60*60*24);
			
			
			/* 시작일과 종료일 사이에 있는 날짜를 구하기 */
			for(var i=0; i<btDay; i++){
				betweenDay.setDate(betweenDay.getDate()+1);
			
				var year = betweenDay.getFullYear();
				var month = betweenDay.getMonth()+1;
				if(month<10){month = "0" + month};
				var date = betweenDay.getDate()
				if(date<10){date = "0" + date};	
				betweenDate.push(year+"-"+month+"-"+date);
			}
			return betweenDate;
		}
		
		
		
		/*  */
		
		var groupidx = '${sessionScope.groupNum}';
		
		$("#plusplan").click(function() {
		   $("#popupContent").css("display","inline");
		   InfoLoad();		   
		})
		
		$("#changeplan").click(function() {
		   $("#Infopopup").css("display","inline");
		})
		
		$(".mainPopupClose").click(function() {
		      $("#bg").css("display","none");
		      $("#inviteListBody").empty();
		      $("#Infopopup").css("display","none");
		      $("#popupContent").css("display","none");
		   })
		   
		$("#PlanPlusBnt").click(function(){
		//    $("#PlanPlusBtn").attr("type","submit");   
		   
		
		   obj.url = "./planWrite";
		   obj.data={ 
		               groupidx:groupidx,  
		               member:$("#memberid").val(),
		               StartDay:$("input[name='startDate']").val(),
		               endDay: $("input[name='endDate']").val(),
		               content:$("#plancontent").val(),
		               title:$("input[name='plantitle']").val()         
		            
		      };
		   obj.success = function(data){
		   console.log(data.success)   
		   if(data.success>0){
		         alert("일정 추가성공");
		         planListCall();
		      }else{
		         alert("일정 추가실패");
		         planListCall();
		      }
		   }
		   ajaxCall(obj);
		   
		   
		})
		function InfoLoad() {
		      obj.url="./groupDetail";
		      obj.data={};
		      obj.data={groupIdx:groupIdx};
		      obj.success = function(data){
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
		   
		function MemberListCall(){
		      obj.url="./groupMemberList";
		      obj.data={groupIdx:groupIdx};
		      obj.success = function(data) {
		         console.log("멤버 그룹 조회");
		          $("#MemberList").empty();
		         // $("#groupInquiryMemberList").empty();
		          groupMemberContent="";
		           groupMemberContent += "<select id='memberid'>";
		          //그룹장
		          data.groupMember.forEach(function(item,index){
		          groupMemberContent += "<option value="+item.groupMember_id+">"+item.groupMember_id+"</option>";
		         // groupMemberContent="";
		          })
		          $("#MemberList").append(groupMemberContent);
		          groupMemberContent += "</select>";
		}
		
		      ajaxCall(obj);
		   }
		
		function ajaxCall(param){
		   $.ajax(param);
		}
		   
	</script>
</html>
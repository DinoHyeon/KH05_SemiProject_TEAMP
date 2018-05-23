<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.paginate{
		margin-left: 40%;		
	}
	#k{
		color: black;
		text-decoration: none;		
	}
	#k:hover {
		background-color: #F6F6F6;
	}
</style>
<div class="paginate">
	    <a id="k" href="groupList?pageNo=${param.firstPageNo}" class="first">≪첫 페이지</a>
	    <a id="k" href="groupList?pageNo=${param.prevPageNo}" class="prev">＜이전</a>
	    <span>
	        <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
	            <c:choose>
	                <c:when test="${i eq param.pageNo}"><a id="k" href="groupList?pageNo=${i}" class="choice">${i}</a></c:when>
	                <c:otherwise><a href="groupList?pageNo=${i}">${i}</a></c:otherwise>
	            </c:choose>
	        </c:forEach>
	    </span>
	    <a id="k" href="groupList?pageNo=${param.nextPageNo}" class="next">다음＞</a>
	    <a id="k" href="groupList?pageNo=${param.finalPageNo}" class="last">마지막페이지≫</a>
	</div>
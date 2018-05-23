<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.paginate{
		margin-left: 40%;		
	}
	a{
		color: black;
		text-decoration: none;		
	}
	a:hover {
		background-color: #F6F6F6;
	}
</style>
<div class="paginate">
	    <a href="fileList?pageNo=${param.firstPageNo}" class="first">≪첫 페이지</a>
	    <a href="fileList?pageNo=${param.prevPageNo}" class="prev">＜이전</a>
	    <span>
	        <c:forEach var="i" begin="${param.startPageNo}" end="${param.endPageNo}" step="1">
	            <c:choose>
	                <c:when test="${i eq param.pageNo}"><a href="fileList?pageNo=${i}" class="choice">${i}</a></c:when>
	                <c:otherwise><a href="fileList?pageNo=${i}">${i}</a></c:otherwise>
	            </c:choose>
	        </c:forEach>
	    </span>
	    <a href="fileList?pageNo=${param.nextPageNo}" class="next">다음＞</a>
	    <a href="fileList?pageNo=${param.finalPageNo}" class="last">마지막페이지≫</a>
	</div>
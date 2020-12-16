<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<style>
	#board-nav{width: 200px; min-width:200px;}
	#board-nav a{color:black; font-weight:bolder;}
	#board-nav a:hover{color: #45A663;}
</style>
	<!-- 좌측메뉴 -->
	<div id="board-nav">
	  <ul class="nav flex-column">
	    <li class="nav-item">
	      <a class="nav-link" href="${path }/notice/noticeList">공지사항</a>
	    </li>
	    <li class="nav-item">
	      <a class="nav-link " href="${path }/faq/faqList">자주묻는질문</a>
	    </li>
	  </ul>
	</div> 

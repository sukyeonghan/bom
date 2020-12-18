<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<style>
	#admin-nav{width: 200px; min-width:200px;}
	#admin-nav a{color:black; font-weight:bolder;}
	#admin-nav a:hover{color: #45A663;}
</style>
<!-- 좌측메뉴 -->

	<div id="admin-nav">
	  <ul class="nav flex-column">
	    <li class="nav-item">
     		<a class="nav-link" href="${path }/admin/memberList">회원관리</a> 
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/admin/moveProduct">제품관리</a>
	    </li>
	    <li class="nav-item">
	     	 <a class="nav-link" href="${path }/admin/order">주문관리</a> 
	    </li>
	    <li class="nav-item">
	     	 <a class="nav-link" href="${path }/admin/qnaList">1:1문의 관리</a> 
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/admin/moveEvent">이벤트관리</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/admin/moveMainBanners">메인관리</a>
	    </li>

	  </ul>
	</div> 


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

	<div id="" class=" mr-3 admin-nav">
	  <ul class="nav flex-column">
	    <li class="nav-item">
	    	<a class="nav-link non-select" href="${path }/admin/memberList">회원관리</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link select" href="${path }/admin/moveProduct">제품관리</a>
	    </li>
	    <li class="nav-item">
	     	 <a class="nav-link non-select" href="${path }/">주문관리</a>
	    </li>
	    <li class="nav-item">
	     	 <a class="nav-link non-select" href="${path }/">1:1문의관리</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link non-select" href="${path }/admin/moveEvent">이벤트관리</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link non-select" href="${path }/">커뮤니티관리</a>
	    </li>
	  </ul>
	</div>
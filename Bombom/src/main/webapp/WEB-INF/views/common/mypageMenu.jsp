<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<style>
	#mypage-nav{padding-right:100px;}
	#mypage-nav a{color:black;font-weight:bolder;}
	#mypage-nav a:hover{color: #45A663;}
</style>
<!-- 좌측메뉴 -->
	<div id="mypage-nav" class=" mr-3">
	  <ul class="nav flex-column">
	    <li class="nav-item">
     		<a class="nav-link" href="${path }/mypage/orderStatus">주문내역</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/mypage/qna">1:1문의</a>
	    </li>
	    <li class="nav-item">
	     	 <a class="nav-link" href="${path }/mypage/myActivity">나의 활동</a>
	    </li>
	    <li class="nav-item">
	     	 <a class="nav-link" href="${path }/mypage/stamp">스탬프</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/mypage/zzimList">찜목록</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/mypage/updateMember">회원정보수정</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/mypage/shipList">배송지관리</a>
	    </li>
	    <li class="nav-item">
	      	<a class="nav-link" href="${path }/mypage/myPointList">적립금</a>
	    </li>
	  </ul>
	</div>

</nav>
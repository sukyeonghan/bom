<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	



    
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container" class="container">
	<div class="media">
	
		<!--관리자 내비게이션바 -->
		<jsp:include page="/WEB-INF/views/admin/product/productNav.jsp"/>
		
		<div id="admin-container" class="media-body">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">제품수정</h3> 
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
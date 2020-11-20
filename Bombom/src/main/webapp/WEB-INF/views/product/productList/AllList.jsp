<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
	/*내비바*/
	#product-nav{padding-right:100px;}
	#product-nav ul{list-style:none;}
	#product-nav a{color:black;font-weight:bolder;}
	#product-nav a:hover{color: #45A663;}
	
	/*최소 컨텐츠 크기*/
   .media{min-width: 768px;} 
	
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container">
	<div class="media">
		<!-- 내비게이션바 -->
		<div id="product-nav" class=" mr-3">
			<ul class="">
        		<li><a class="" href="${path }/product/productAll">전체보기</a></li>
	        	<li><a class="" href="#">식품</a></li>
          	 	<li><a class="" href="#">잡화</a></li>
            	<li><a class="" href="#">주방</a></li>
            	<li><a class="" href="#">욕실</a></li>
            	<li><a class="" href="#">여성</a></li>
            	<li><a class="" href="#">반려동물</a></li>
            	<li><a class="" href="#">할인상품</a></li>
        	</ul>
		</div>
		
		<div class="media-body">
			
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
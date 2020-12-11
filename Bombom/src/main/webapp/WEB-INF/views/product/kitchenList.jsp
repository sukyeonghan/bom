<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${path }/resources/css/product/productList.css">


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container">

	<div class="flexDiv">
		<!-- 상품 내비게이션바 -->
		<div class="product-nav">
			<ul>
        		<li><a href="${path }/product/productAll" style="${category.equals('전체제품')?'color:#45A663;':'color:black;' }">전체제품</a></li>
	        	<li><a href="${path }/product/food" style="${category.equals('식품')?'color:#45A663;':'color:black;' }">식품</a></li>
          	 	<li><a href="${path }/product/stuff" style="${category.equals('잡화')?'color:#45A663;':'color:black;' }">잡화</a></li>
            	<li><a href="${path }/product/kitchen" style="${category.equals('주방')?'color:#45A663;':'color:black;' }">주방</a></li>
            	<li><a href="${path }/product/bathroom" style="${category.equals('욕실')?'color:#45A663;':'color:black;' }">욕실</a></li>
            	<li><a href="${path }/product/woman" style="${category.equals('여성용품')?'color:#45A663;':'color:black;' }">여성용품</a></li>
            	<li><a href="${path }/product/pet" style="${category.equals('반려동물')?'color:#45A663;':'color:black;' }">반려동물</a></li>
            	<li><a href="${path }/product/sale" style="${category.equals('할인상품')?'color:#45A663;':'color:black;' }">할인상품</a></li>
        	</ul>
		</div>

				
<jsp:include page="/WEB-INF/views/product/commonList.jsp" />				
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${path}/resources/js/productList.js"></script>
<script>
	//분류 ajax
	$(".sort").on("change",e=>{
		console.log($(e.target).val());
		$.ajax({
			
			url:"${path}/product/productListAjax",
			data:{"category":${category},"sort":$(e.target).val()},
			type:"get",
			dataType:"html",
			success:data=>{
				console.log(data);
				$("#result").html(data);
			}
		});
		
	})

</script>
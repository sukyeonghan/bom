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

<section id="container" >

	<div class="flexDiv">
		
		<!-- 상품 내비게이션바 -->
		<div class="product-nav">
			<ul>
        		<li><a class="select" href="${path }/product/productAll">전체제품</a></li>
	        	<li><a class="non-select" href="${path }/product/food">식품</a></li>
          	 	<li><a class="non-select" href="${path }/product/stuff">잡화</a></li>
            	<li><a class="non-select" href="${path }/product/kitchen">주방</a></li>
            	<li><a class="non-select" href="${path }/product/bathroom">욕실</a></li>
            	<li><a class="non-select" href="${path }/product/woman">여성용품</a></li>
            	<li><a class="non-select" href="${path }/product/pet">반려동물</a></li>
            	<li><a class="non-select" href="${path }/product/sale">할인상품</a></li>
        	</ul>
		</div>
		
		<div class="product-container">
			<!-- 카테고리 및 정렬 -->
			<div class="category-sort">
				<div class="item-count">
					<p class="category">전체제품 &nbsp </p>
					<p class="count"><c:out value="${count}"/></p>
				</div>
				<div class="select-box">
					<select class="sort">
						<option value="등록일순">등록일순</option>
						<option value="인기순">인기순</option>
						<option value="낮은가격순">낮은 가격순</option>
						<option value="높은가격순">높은 가격순</option>
					</select>
				</div>
			</div>
		  	
		  	<!-- 상품목록 -->
		  	<div id="result" class="all-item-wrap">
		  		<div class="all-item-wrap">
		  			<!-- 제품없으면 없다고 알리는 사진뜸 / 있으면 제품들 출력 -->
			  		<c:choose>
			  			<c:when test="${empty list }">
			  				<img class="noItem" alt="" src="${path }/resources/images/product/noItem2.png" >
			  			</c:when>
			  			
			  			<c:otherwise>
			  				<c:forEach var="p" items="${list }" >
			  					<div class="item-wrap">
			  						<!-- 썸네일 사진 -->
					                <div>
					                    <a href="#">
					                    	
					                    	<c:choose>
					                    		<c:when test="${fn:contains(p.thumbs,',') }">
					                    			<c:set var="thumbs" value="${fn:split(p.thumbs,',') }"/> 
					                    			<c:forEach begin="0" end="0" var="th" items="${thumbs }" varStatus="v">
								                    	<img alt="" src="${path}/resources/upload/product/<c:if test='${v.count==1 }'>${th }</c:if>" class="item-img hover" style="display: inline;"
								                         >
								                         <input type="hidden" class="firstPic" value="<c:if test='${v.count==1 }'>${th }</c:if>">
								                    </c:forEach>
								                    <c:forEach begin="1" end="1" var="th" items="${thumbs }" varStatus="v">
								                         <input type="hidden" class="secondPic" value="<c:if test='${v.count==1 }'>${th }</c:if>">
								                    </c:forEach>
								                  	
					                    		</c:when>
					                    		<c:otherwise>
					                    			<c:forEach begin="0" end="0" var="th" items="${p.thumbs }" varStatus="v">
								                    	<img alt="" src="${path}/resources/upload/product/${th }" class="item-img" style="display: inline;">
								                    </c:forEach>
					                    		</c:otherwise>
					                    	</c:choose>
						                    
					                   	</a>
					                </div>
					                <!-- 사진 밑에 부가 사항들 -->
					                <div class="item-intro">
					                    <p class="item-title">
					                        <a class="title-link" href=""><c:out value="${p.pdtName }"/></a>
					                    </p>
					                    <div class="item-price">
					                    	<c:choose>
					                    		<c:when test="${not empty p.eventNoRef } and ${p.salePer!=0 }">
					                    			<p class="ori-price sale"><c:out value="${p.pdtPrice }"/>원</p>
					                    			<p class="sale-price"><c:out value="${p.pdtPrice(1-p.salePer) }"/>원</p>
					                    		</c:when>
					                    		<c:otherwise>
					                    			<p class="ori-price"><c:out value="${p.pdtPrice }"/>원</p>
					                    		</c:otherwise>
					                        </c:choose>			
					                    </div>
					                    <!-- 조건에 따라 뜨는 아이콘들 -->
					                    <div class="item-icon">
					                    	<!-- 등록한 날짜로 부터 7일 -->
					                    	<c:forEach var="n" items="${newList }">
					                    		<c:if test="${n.pdtNo==p.pdtNo }">
					                    			<div class="new-icon">NEW</div>
					                    		</c:if>
					                    	</c:forEach>
					                        <!-- 세일하면 (이벤트 )-->
					                        <c:if test="${not empty p.eventNoRef } and ${p.salePer!=0 }">
					                        	<div class="sale-icon">SALE</div> 
					                        </c:if>
					                        <!-- 판매상태가 N으로 바뀌면 -->	
					                      	<c:if test="${p.pdtStatus=='N'}">
					                        	<div class="soldout-icon">SOLDOUT</div>
					                        </c:if>			
					                    </div>
					                    
					                </div>
	           					 </div>
			  				</c:forEach>
			  			</c:otherwise>
			  		</c:choose>
			  	</div>
			  		
				<!-- 페이징 -->
	          	<div class="pagebar">	
	          		${pageBar }
	          	</div>
	           	
			</div>
		</div>
	</div> 

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script src="${path}/resources/js/productList.js"></script>
<script>
	//분류 ajax
	$(".sort").on("change",e=>{
		console.log($(e.target).val());
		$.ajax({
			
			url:"${path}/product/productListAjax",
			data:{"category":"전체","sort":$(e.target).val()},
			type:"get",
			dataType:"html",
			success:data=>{
				console.log(data);
				$("#result").html(data);
			}
		});
		
	})

</script>

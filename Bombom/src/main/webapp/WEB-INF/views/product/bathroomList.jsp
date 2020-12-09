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

<section id="container" class="container-fluid">

	<div class="media">
		<!-- 상품 내비게이션바 -->
		<div class="product-nav mr-3" style="min-width: 210px;">
			<ul>
        		<li><a class="non-select" href="${path }/product/productAll">전체제품</a></li>
	        	<li><a class="non-select" href="${path }/product/food">식품</a></li>
          	 	<li><a class="non-select" href="${path }/product/stuff">잡화</a></li>
            	<li><a class="non-select" href="${path }/product/kitchen">주방</a></li>
            	<li><a class="select" href="${path }/product/bathroom">욕실</a></li>
            	<li><a class="non-select" href="${path }/product/woman">여성용품</a></li>
            	<li><a class="non-select" href="${path }/product/pet">반려동물</a></li>
            	<li><a class="non-select" href="${path }/product/sale">할인상품</a></li>
        	</ul>
		</div>
		
		<div class="media-body" style="max-width: 80%;">
			<!-- 카테고리 및 정렬 -->
			<div class="category-sort">
				<div class="item-count">
					<p class="category">욕실 &nbsp </p>
					<p class="count"><c:out value="${count}"/></p>
				</div>
				<div class="select-box">
					<select class="sort">
						<option>등록순</option>
						<option>인기순</option>
						<option>낮은 가격순</option>
						<option>높은 가격순</option>
					</select>
				</div>
			</div>
		  	
		  	<!-- 상품목록 -->
		  	<div class="all-item-wrap"  style="display: flex;min-width: 80%;flex-wrap: wrap;">
		  		<c:choose>
		  			<c:when test="${empty list }">
		  				<img class="noItem" alt="" src="${path }/resources/images/product/noItem2.png" >
		  			</c:when>
		  			<c:otherwise>
		  				<c:forEach var="p" items="${list }" >
		  					<div class="item-wrap">
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
				                <div class="item-intro">
				                    
				                    <p class="item-title">
				                        <a class="title-link" href=""><c:out value="${p.pdtName }"/></a>
				                    </p>
				                    <div class="item-price">
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
				                    </div>
				                    <div class="item-icon">
				                    	<!-- 등록한 날짜로 부터 7일 -->
				                    	<c:forEach var="n" items="${newList }">
				                    		<c:if test="${n.pdtNo==p.pdtNo }">
				                    			<div class="new-icon">NEW</div>
				                    		</c:if>
				                    	</c:forEach>
				                        <!-- 세일하면 (이벤트)-->
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
           
		  </div>
		  
		  <!-- 페이징바 -->
		 <!-- <div class="w3-center pagebar">	
			<div class="w3-bar">
				<a href="#" class="w3-button w3-hover-black"> < </a>
				<a href="#" class="w3-button w3-hover-black">1</a>
				<a href="#" class="w3-button w3-hover-black">2</a>
				<a href="#" class="w3-button w3-hover-black">3</a>
				<a href="#" class="w3-button w3-hover-black">4</a>
				<a href="#" class="w3-button w3-hover-black"> > </a>
			</div>
		</div> -->
	</div>
</div>
		

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>

	//호버 시 메인 이미지 변경 
	$(function() { 
		
		$(".hover").hover(function(){ 
			// console.log("올림");
			$(this).attr("src", $(this).attr("src").replace($(this).next().val(), $(this).next().next().val())); 
	
		}, function(){ 
			//console.log("내림");
			$(this).attr("src", $(this).attr("src").replace($(this).next().next().val(), $(this).next().val())); 
		}); 
	});
</script>
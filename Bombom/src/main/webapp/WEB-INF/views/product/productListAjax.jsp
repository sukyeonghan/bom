<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${path }/resources/css/product/productList.css">

	  	
	 	<!-- 상품목록 -->
	 	<div>
		 	<div class="all-item-wrap">
		 		<!-- 제품없으면 없다고 알리는 사진뜸 / 있으면 제품들 출력 -->
		 		<c:choose>
		 			<c:when test="${empty list }">
		 				<img class="noItem" alt="" src="${path }/resources/images/product/noItem.png" >
		 			</c:when>
		 			<c:otherwise>
		 				<input type="hidden" name="count" value="${count}">
		 				<c:forEach var="p" items="${list }" >
		 					<div class="item-wrap">
				                <div>
				                      <a href="${path }/product/productOne?pdtNo=${p.pdtNo}">
				                    	
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
				                    	<c:choose>
				                    		<c:when test="${not empty p.eventNoRef and p.salePer!=0 }">
				                    			<p class="ori-price sale">
				                    				<fmt:formatNumber value="${p.pdtPrice }" />원
				                    			</p>
								                <fmt:parseNumber var="i" integerOnly="true" type="number" value="${p.pdtPrice*(1-(p.salePer/100))}"/>
								                <p class="sale-price">
								                   <fmt:formatNumber value="${i}" />원
								                </p>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<p class="ori-price"><c:out value="${p.pdtPrice }"/>원</p>
				                    		</c:otherwise>
				                        </c:choose>			
				                    </div>
				                    
		                   			<!-- 찜횟수,후기 개수,미리보기 페이지 -->
				                    <div>
				                    	<!-- 찜횟수 -->
				                    	<img class="icon" alt="" src="${path}/resources/images/product/heart.png">
				                    	<c:out value="${p.zzimCount }"/>
				                    	<!-- 후기 개수 -->
				                    	<img class="icon" alt="" src="${path}/resources/images/product/message.png">
				                    	<c:out value="${p.reviewCount }"/>
				                  	</div>
				                  	
				                    <div class="item-icon">
				                    	<!-- 등록한 날짜로 부터 7일 -->
										<c:if test="${p.newYn=='Y' }">
				                    		<div class="new-icon">NEW</div>
				                    	</c:if>
				                        <!-- 세일하면 (이벤트 )-->
				                        <c:if test="${not empty p.eventNoRef and p.salePer!=0 }">
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
	        
		    <div class="pagebar">
		    	${pageBar }
		    </div>
	    </div>


<script>
	//호버 시 메인 이미지 변경 
	$(function() { 
		
		$(".hover").hover(function(){ 
			$(this).attr("src", $(this).attr("src").replace($(this).next().val(), $(this).next().next().val())); 
	
		}, function(){ 
			$(this).attr("src", $(this).attr("src").replace($(this).next().next().val(), $(this).next().val())); 
		}); 
	});

</script>
    

	
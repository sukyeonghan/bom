<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${path }/resources/css/product/productList.css">

	<div id="result" class="product-container">
		<!-- 카테고리 및 정렬 -->
		<div class="category-sort">
			<div class="item-count">
				<p class="category"><c:out value="${category}"/> &nbsp </p>
				<p class="count"><c:out value="${count}"/></p>
			</div>
			<div class="select-box">
				<!-- 품절 포함 선택 -->
				<select class="sort" id="soldout">
					<option value="품절포함" ${soldout=='품절포함'?"selected":"" }>품절 포함</option>
					<option value="품절제외" ${soldout=='품절제외'?"selected":"" }>품절 제외</option>
				</select>
				<!-- 분류 필터 -->
				<select class="sort" id="sort">
					<option value="등록일순" ${sort=='등록일순'?"selected":"" }>등록일순</option>
					<option value="인기순" ${sort=='인기순'?"selected":"" }>인기순</option>
					<option value="리뷰순" ${sort=='리뷰순'?"selected":"" }>리뷰순</option>
					<option value="할인율순" ${sort=='할인율순'?"selected":"" }>할인율순</option>
					<option value="낮은가격순" ${sort=='낮은가격순'?"selected":"" }>낮은 가격순</option>
					<option value="높은가격순" ${sort=='높은가격순'?"selected":"" }>높은 가격순</option>
				</select>
			</div>
		</div>
			  	
	 	<!-- 상품목록 -->
	 	<div>
		 	<div class="all-item-wrap">
		 		<!-- 제품없으면 없다고 알리는 사진뜸 / 있으면 제품들 출력 -->
		 		<c:choose>
		 			<c:when test="${empty list }">
		 				<img class="noItem" alt="" src="${path }/resources/images/product/noItem.png" >
		 			</c:when>
		 			<c:otherwise>
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
				                    	<!-- 미리보기페이지 -->
				                    	<a>
				                    		<img class="icon" alt="" src="${path}/resources/images/product/cart.png">
				                    	</a>
				                    	
				                  	</div>
				                  	
				                    <div class="item-icon">
				                    	<!-- 등록한 날짜로 부터 7일 -->
				                    	<c:forEach var="n" items="${newList }">
				                    		<c:if test="${n.pdtNo==p.pdtNo }">
				                    			<div class="new-icon">NEW</div>
				                    		</c:if>
				                    	</c:forEach>
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

	//분류 ajax
	$(".sort").on("change",e=>{

		$.ajax({			
			url:"${path}/product/productListAjax",
			data:{"category":"${category}","sort":$("#sort").val(),"soldout":$("#soldout").val()},
			type:"get",
			dataType:"html",
			success:data=>{
				$("#result").html(data);
			}
		});
		
	})

</script>
    

	
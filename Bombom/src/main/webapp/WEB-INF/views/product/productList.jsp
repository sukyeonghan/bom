<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${path }/resources/css/product/productList.css">
<!-- 범위슬라이더 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.1/css/ion.rangeSlider.min.css"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>
<!-- 범위슬라이더 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/ion-rangeslider/2.3.1/js/ion.rangeSlider.min.js"></script>


<section id="container">

	<div class="flexDiv">
		<!-- 상품 내비게이션바 -->
		<div class="product-nav">
			<ul>
        		<li><a href="${path }/product/productAll" style="${category.equals('전체제품')?'color:#45A663;':'' }">전체제품</a></li>
	        	<li><a href="${path }/product/food" style="${category.equals('식품')?'color:#45A663;':'' }">식품</a></li>
          	 	<li><a href="${path }/product/stuff" style="${category.equals('잡화')?'color:#45A663;':'' }">잡화</a></li>
            	<li><a href="${path }/product/kitchen" style="${category.equals('주방')?'color:#45A663;':'' }">주방</a></li>
            	<li><a href="${path }/product/bathroom" style="${category.equals('욕실')?'color:#45A663;':'' }">욕실</a></li>
            	<li><a href="${path }/product/woman" style="${category.equals('여성용품')?'color:#45A663;':'' }">여성용품</a></li>
            	<li><a href="${path }/product/pet" style="${category.equals('반려동물')?'color:#45A663;':'' }">반려동물</a></li>
            	<li><a href="${path }/product/sale" style="${category.equals('할인제품')?'color:#45A663;':'' }">할인제품</a></li>
        	</ul>
		</div>

		<div class="product-container">
			<!-- 카테고리 및 정렬 -->
			<div class="category-sort">
				<div class="item-count">
					<p class="category"><c:out value="${category}"/> &nbsp </p>
					<p class="count" id="count"><c:out value="${count}"/></p>
				</div>
				<button type="button" id="filter" class="btn btn-outline-success" data-toggle="collapse" data-target="#form">검색 필터</button>
			</div>
			<!-- 검색 필터 -->
			<form id="form" class="collapse">
				<div id="sort-wrap">
					<input type="hidden" name="pdtcategory" value="${category}">
					<ul>
						<li>
							<span class="sort-title">정렬</span>
							<input type="radio" class="sort default" name="sort" value="등록일순" checked>  등록일순
							<input type="radio" class="sort" name="sort" value="인기순">  인기순
							<input type="radio" class="sort" name="sort" value="리뷰순">  리뷰순
							<input type="radio" class="sort" name="sort" value="평점순">  평점순
							<input type="radio" class="sort" name="sort" value="할인율순">  할인율순
							<input type="radio" class="sort" name="sort" value="낮은가격순">  낮은 가격순
							<input type="radio" class="sort" name="sort" value="높은가격순">  높은 가격순
						</li>
						<c:if test="${category eq '전체제품'}">
							<li>
								<span class="sort-title">분류</span>
								<input type="checkbox" class="sort default" id="cate-all" name="category" value="전체제품" checked>  전체
								<input type="checkbox" class="sort cate" name="category" value="식품">  식품 
								<input type="checkbox" class="sort cate" name="category" value="잡화">  잡화
								<input type="checkbox" class="sort cate" name="category" value="주방">  주방
								<input type="checkbox" class="sort cate" name="category" value="욕실">  욕실
								<input type="checkbox" class="sort cate" name="category" value="여성용품">  여성용품
								<input type="checkbox" class="sort cate" name="category" value="반려동물">  반려동물
							</li>
						</c:if>
						<li class="slider">
							<span class="sort-title">가격</span>
							<input type="text" class="js-range-slider" id="price-range-slider" name="price" value="" 
							   data-type="double"
						        data-min="0"
						        data-max="${maxPrice }"
						        data-from="0"
						        data-to="${maxPrice }"
						        data-grid="true"/>
						</li>
						<li >
							<span class="sort-title">평점</span>
							<input type="checkbox" class="sort" name="star1" value="1">  ★
							<input type="checkbox" class="sort" name="star2" value="1">  ★★
							<input type="checkbox" class="sort" name="star3" value="1">  ★★★
							<input type="checkbox" class="sort" name="star4" value="1">  ★★★★
							<input type="checkbox" class="sort" name="star5" value="1">  ★★★★★ 
						</li>
						<li>
							<span class="sort-title">품절</span>
							<input type="radio" class="sort default" name="soldout" value="품절포함" checked>  품절 포함
							<input type="radio" class="sort" name="soldout" value="품절제외">  품절 제외
						</li>
					</ul>
					<div id="sort-btns">
						<input type="button" id="reset" class="btn btn-outline-success" value="초기화">
						<input type="button" id="search" class="btn btn-success" value="검색" data-toggle="collapse" data-target="#form" onclick="searchBtn()">
					</div>
				</div>
			</form>
		  	
		  	<!-- 상품목록 -->
		  	<div  id="result">
		  		<div class="all-item-wrap">
					<!-- 제품없으면 없다고 알리는 사진뜸 / 있으면 제품들 출력 -->
			  		<c:choose>
			  			<c:when test="${empty list }">
			  				<img class="noItem" alt="" src="${path }/resources/images/product/noItem.png" >
			  			</c:when>
			  			
			  			<c:otherwise>
			  				<c:forEach var="p" items="${list }" >
			  					<div class="item-wrap">
			  						<!-- 썸네일 사진 -->
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
					                <!-- 사진 밑에 부가 사항들 -->
					                <div class="item-intro">
					                	<!-- 상품명 -->
					                    <p class="item-title">
					                        <a class="title-link" href="${path }/product/productOne?pdtNo=${p.pdtNo}"><c:out value="${p.pdtName }"/></a>
					                    </p>
					                    <!-- 상품 가격 -->
					                    <div class="item-price">
					                    	<c:choose>
					                    		<c:when test="${not empty p.eventNoRef  and p.salePer!=0 }">
													<!-- 할인 가격 -->
					                    			<fmt:parseNumber var="i" integerOnly="true" type="number" value="${p.pdtPrice*(1-(p.salePer/100))}"/>
					                    			<p class="sale-price">
					                    				<fmt:formatNumber value="${i}" />원
					                    			</p>
					                    			<!-- 기본 가격 -->
					                    			<p class="ori-price sale">
					                    				<fmt:formatNumber value="${p.pdtPrice }" />원
					                    			</p>
					                    		</c:when>
					                    		<c:otherwise>
					                    			<p class="ori-price">
					                    				<fmt:formatNumber value="${p.pdtPrice }" />원
					                    			</p>
					                    		</c:otherwise>
					                        </c:choose>			
					                    </div>
					                    <!-- 찜횟수,후기 개수,미리보기 페이지 -->
					                    <div>
					                    	<!-- 찜횟수 -->
					                    	<img class="icon" alt="" src="${path}/resources/images/product/heart.png">
					                    	<c:out value="${p.zzimCount }"/>
					                    	<!-- 후기 개수 -->
					                    	<img class="icon margin" alt="" src="${path}/resources/images/product/message.png">
					                    	<c:out value="${p.reviewCount }"/>
					                  	</div>
					                  	
					                    <!-- 조건에 따라 뜨는 아이콘들 -->
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
			  		
				<!-- 페이징 -->
	          	<div class="pagebar">	
	          		${pageBar }
	          	</div>
	           	
			</div>
		</div>
	</div> 
</section>
								
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	//카테고리 선택하면 전체선택 못하게 막기
	$(".cate").on("change", function () {
		//$("#cate-all").prop("checked", false);//체크 취소
		$("#cate-all").prop("disabled", true);//아예 비활성화
	});
	
	//가격 슬라이더 설정
	$("#price-range-slider").ionRangeSlider({
		skin: "round",
	    type: "double",
	    min: 0,
	    max: "${maxPrice }",
	    from: 0,
	    to: "${maxPrice }",
	    step:1000,
	    grid_num:5,
	    grid: true
	});
	//가격 슬라이더 값 넣기
	$("#price-range-slider").on("change", function () {
        var $inp = $(this);
        var v = $inp.prop("value");     // input value in format FROM;TO
        var priceArr=v.split(";")
        $("input[name=price]").attr("value",priceArr);//자른 값 넣기
    });

	let my_range=$("#price-range-slider").data("ionRangeSlider");
	//초기화 버튼
	//html 어트리뷰트가 아닌 javascript의 속성변경 위해 prop사용
	$("#reset").on("click",e=>{
		$(".sort").prop("checked", false);
		$(".default").prop("checked",true);
		$("#cate-all").prop("disabled", false);//분류
		my_range.reset();//가격
	});
	
	//검색 버튼 누르면
	function searchBtn(){
		var formData=$("#form").serialize();
		$.ajax({
			cache:false,
			url:"${path}/product/productListAjax",
			type:"post",
			data:formData,
			success:function(data){
				$("#result").html(data);
				//검색 결과 개수 출력
				let count=$("#result").html(data).find('input[name=count]').val();
				$("#count").text(count);
			}
		})
	}
	
	//호버 시 메인 이미지 변경 
	$(function() { 
		
		$(".hover").hover(function(){ 
			$(this).attr("src", $(this).attr("src").replace($(this).next().val(), $(this).next().next().val())); 
	
		}, function(){ 
			$(this).attr("src", $(this).attr("src").replace($(this).next().next().val(), $(this).next().val())); 
		}); 
	});

	
</script>
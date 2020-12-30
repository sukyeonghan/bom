<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="${path }/resources/css/product/productList.css">

<style>
  /*스와이퍼*/
  
  	.mySlides {display:none;}
	.w3-badge {height:13px;width:13px;padding:0}
	.w3-left, .w3-right, .w3-badge {cursor:pointer}
	/*검색필터버튼*/
	#test{height:35px;}
	/*전체*/
	#form{	
		border: 1px solid #45A663;
		border-radius: 10px;
	    padding: 2%;
	}
	.sort-title{font-weight:bold;}
	/*초기화,검색버튼*/
	#sort-btns{display:flex;justify-content: center;}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

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
					<p class="count"><c:out value="${count}"/></p>
				</div>
<!-- 				<div class="select-box">
					품절 포함 선택
					<select class="sort" id="soldout">
						<option value="품절포함">품절 포함</option>
						<option value="품절제외">품절 제외</option>
					</select>
					분류 필터
					<select class="sort" id="sort">
						<option value="등록일순">등록일순</option>
						<option value="인기순">인기순</option>
						<option value="리뷰순">리뷰순</option>
						<option value="할인율순">할인율순</option>
						<option value="낮은가격순">낮은 가격순</option>
						<option value="높은가격순">높은 가격순</option>
					</select>
				</div> -->
				<button type="button" id="test" class="btn btn-outline-success" data-toggle="collapse" data-target="#form">검색 필터</button>

			</div>
			<form id="form" class="collapse">
				<input type="hidden" name="pdtcategory" value="${category}">
				<c:if test="${category eq '전체제품'}">
					<span class="sort-title">분류</span>
					<input type="checkbox" class="sort default" name="category" value="전체제품" checked> 전체
					<input type="checkbox" class="sort" name="category" value="식품"> 식품 
					<input type="checkbox" class="sort" name="category" value="잡화"> 잡화
					<input type="checkbox" class="sort" name="category" value="주방"> 주방
					<input type="checkbox" class="sort" name="category" value="욕실"> 욕실
					<input type="checkbox" class="sort" name="category" value="여성용품"> 여성용품
					<input type="checkbox" class="sort" name="category" value="반려동물"> 반려동물
					<br>
				</c:if>
				<span class="sort-title">정렬</span>
				<input type="radio" class="sort default" name="sort" value="등록일순" checked> 등록일순
					<input type="radio" class="sort" name="sort" value="인기순"> 인기순
					<input type="radio" class="sort" name="sort" value="리뷰순"> 리뷰순
					<input type="radio" class="sort" name="sort" value="평점순"> 평점순
					<input type="radio" class="sort" name="sort" value="할인율순"> 할인율순
					<input type="radio" class="sort" name="sort" value="낮은가격순"> 낮은 가격순
					<input type="radio" class="sort" name="sort" value="높은가격순"> 높은 가격순
				<br>
				<span class="sort-title">품절</span>
				<input type="radio" class="sort default" name="soldout" value="품절포함" checked> 품절 포함
				<input type="radio" class="sort" name="soldout" value="품절제외"> 품절 제외
				<br>
				<span class="sort-title">가격</span>
				<input type="radio" class="sort" name="price" value="10000"> 만원 이하
				<input type="radio" class="sort" name="price" value="30000"> 3만원 이하
				<input type="radio" class="sort" name="price" value="50000"> 5만원 이하
				<input type="radio" class="sort" name="price" value="50000이상"> 5만원 이상
				<br>
				<span class="sort-title">평점</span>
				<input type="checkbox" class="sort" name="star" value="1"> ★
				<input type="checkbox" class="sort" name="star" value="2"> ★★
				<input type="checkbox" class="sort" name="star" value="3"> ★★★
				<input type="checkbox" class="sort" name="star" value="4"> ★★★★
				<input type="checkbox" class="sort" name="star" value="5"> ★★★★★
				<div id="sort-btns">
					<input type="button" id="reset" value="초기화">
					<input type="button" id="search" value="검색" onclick="searchBtn()">
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
					                    	<!-- 미리보기페이지 -->
					                    	<%-- <img class="test icon margin" alt="" src="${path}/resources/images/product/search.png" > --%>
					                    	<%-- <img class="test icon margin" alt="" src="${path}/resources/images/product/cart.png" >
											<input type="hidden" name="pdtNo" value="${p.pdtNo}"> --%>
					                  	</div>
					                  	<!-- 상품 미리보기 -->
					                  	<div class="previewDivShow previewDivNone" id="${p.pdtNo}">
					                  		<div class="popupContent" >
					                  			
					                  			<input type="button" class="delBtn" value="X">
					                  			
					                  			<!-- 스와이퍼 -->
					                  			<div class="w3-content w3-display-container swiper " style="position:absolute">
													<img class="mySlides" src="${path}/resources/images/product/noItem.png" style="width:100%">
													<img class="mySlides" src="${path}/resources/images/product/heart.png" style="width:100%">
													<img class="mySlides" src="${path}/resources/images/product/cart.png" style="width:100%">
													
	  												<div class="w3-center w3-container w3-section w3-large w3-text-black w3-display-middle" style="width:100%">
												    	<div class="w3-left " onclick="plusDivs(-1)">&#10094;</div>
												    	<div class="w3-right " onclick="plusDivs(1)">&#10095;</div>
												    </div>
												</div>
												
												
												
					                  		</div>
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
	//분류 초기화 버튼
	//html 어트리뷰트가 아닌 javascript의 속성변경 위해 prop사용
	//초기화 되면서 원래 처음 페이지로 되돌아가야할듯
	$("#reset").on("click",e=>{
		console.log($("input[name=category]").val());
		console.log($("input[name=sort]").val());
		//$(".sort").prop("checked", false);
		//$(".default").prop("checked",true);
	});
	
	//분류 ajax
/* 	$(".sort").on("change",e=>{
		$.ajax({			
			url:"${path}/product/productListAjax",
			data:{"category":"${category}","sort":$("#sort").val(),"soldout":$("#soldout").val()},
			type:"get",
			dataType:"html",
			success:data=>{
				$("#result").html(data);
			}
		});
		
	}); */
	/* $("#search").on("click",e=>{
		//,star:$("input[name=star]").val(),price:$("input[name=price]").val()
		$.ajax({			
			url:"${path}/product/productListAjax",
			data:{category:$("input[name=category]").val(),sort:$("input[name=sort]").val(),soldout:$("input[name=soldout]").val()},
			type:"get",
			dataType:"html",
			success:data=>{
				$("#result").html(data);
			}
		});
		
	}); */
	function searchBtn(){
		var formData=$("#form").serialize();
		$.ajax({
			cache:false,
			url:"${path}/product/productListAjaxTest",
			type:"post",
			data:formData,
			success:function(data){
				$("#result").html(data);
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

	//상품 미리보기 div
	$(document).ready(function () {
	 	$(".test").on("click",e=>{
			var pdtNo=$(e.target).next().val();
			console.log(pdtNo);
			var div=document.getElementById(pdtNo).getAttribute('id');
			console.log(div);
			if(pdtNo==div){
				$("#"+div).removeClass("previewDivNone");
			}
			
		}); 
	 	$(".delBtn").on("click",e=>{
			$(".previewDivShow").addClass("previewDivNone");
		}) 
	});
	

	//스와이퍼
	var slideIndex = 1;
	showDivs(slideIndex);
	
	function plusDivs(n) {
	  showDivs(slideIndex += n);
	}
	
	
	function showDivs(n) {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  var dots = document.getElementsByClassName("demo");
	  if (n > x.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = x.length}
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	  }
	  for (i = 0; i < dots.length; i++) {
	    dots[i].className = dots[i].className.replace(" w3-white", "");
	  }
	  x[slideIndex-1].style.display = "block";  
	  //dots[slideIndex-1].className += " w3-white";
	}
	
</script>
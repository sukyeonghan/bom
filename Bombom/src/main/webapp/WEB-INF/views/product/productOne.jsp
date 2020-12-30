<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- 찜하기 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
 <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp" >
   <jsp:param name="title" value="" />
</jsp:include>

<style>
/* 바로가기 이동 */
a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: #45A663;
	text-decoration: none;
}
/* 글씨크기 조정 스타일 */
.information {
	padding: 4px;
	font-size: 15px;
}

.size-up {
	font-size: 23px;
}

.size-mid {
	font-size: 17px;
}
/* 썸네일 이미지 */
.goods_thumbs_image ul {
	padding: 0;
	list-style: none;
	margin-bottom: 0;
}

.goods_thumbs_image ul li {
	float: left;
	/* padding-right: 7px; */
	padding: 0 4px 0 0px;
	/* width: 100%;
        height: 100%; */
	display: inline-block;
	cursor: pointer;
	margin: 0;
}

.goods_thumbs_image ul li img {
	width: 100%;
	/*  height:100%; */
	object-fit: contain;
}
/* 세일아이콘 */
.sale-icon {
	background-color: #e04545;
	color: white;
	padding: 1px 5px;
	width: 60px;
}
/* NEW 아이콘 */
.new-icon {
	background-color: #45A663;
	color: white;
	padding: 1px 5px;
	width: 58px;
}
/* soldout 아이콘 */
.soldout-icon {
	background-color: gray;
	color: white;
	padding: 1px 5px;
	width: 110px;
}
/*셀렉트박스 디자인*/
.form-control {
	margin: 0 0 5px 0;
}

/*수량 스타일*/
#info_count {
	border: #28a745 1px solid;
	width: 100%;
	height: 100px;
}

.input_count {
	border: none;
	background-color: #fff;
	color: 00000;
	width: 26px;
	font-size: 13px;
	display: table-cell;
	vertical-align: middle;
	text-align: center;
}

.input_count:focus {
	border: none;
	outline: none;
}

/* 버튼 크기 조절 */
.custom {
	width: 32.8% !important;
}

/* 네비바 스타일 */
button {
	background: none;
	border: 0;
	outline: 0;
	cursor: pointer;
}

button:focus {
	border: none;
	outline: none;
}

.tab_menu_container {
	text-align: center;
	padding-top: 80px;
}

.tab_menu_btn {
	width: 200px;
	height: 40px;
	transition: 0.3s all;
}

.tab_menu_btn.on {
	border-bottom: 1px solid #45A663;
	color: #45A663;
}

.tab_menu_btn:hover {
	color: #45A663;
}

.tab_box {
	display: none;
	padding: 25px;
}

.tab_box.on {
	display: block;
}

.tab_box img {
	width: 80%;
}
/* 배송 안내사항 */
#information p {
	font-size: 12px;
}
/* 연관상품 스와이프 css */
.swiper-container {
	/* width:1100px; */
	width: 100%;
	height: 300px;
}

.swiper-slide {
	font-size: 13px;
	background: #fff;
	/* Center slide text vertically */
	display: -webkit-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-webkit-align-items: center;
	align-items: center;
}

.slideImg img {
	/* 이미지 최대너비 제한 */
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
}

.slidePrice {
	padding-top: 10px;
}
/* 슬라이드 이미지 변경 */
.slideImg img#secondImg {
	display: none;
}

.slideImg:hover img#firstImg {
	display: none;
}

.slideImg:hover img#secondImg {
	display: block;
}

/* 위로가기 버튼 */
.scrollTop {
	width: 50px;
	height: 50px;
	position: fixed;
	z-index: 9999;
	right: 50px;
	bottom: 40px;
	display: none;
}

/* 찜하기 모달창 */
.modal{
	text-align:center;
}
    
.modal-dialog {
	display: inline-block;
	text-align:left;
	vertical-align: middle;
}

@media screen and (min-width: 768px) {
	.modal:before {
		display: inline-block;
		vertical-align: middle;
		content: " ";
		height: 100%;
	}
}
.modal .zzim-size{
	width:70%;
}

/* 찜하기 */
.heart {
  /* width: 20px;
  height: 20px; */
  font-size:20px;
  margin: auto;
  transform: translateZ(0);
  color: #aaa;
  cursor: pointer;
  position: relative;
  transition: all .3s ease;
}
.heart:hover {
  animation: pulse .6s linear;
}
.heart:before {
  content: "❤";
  position: absolute;
  color: #A12B2B;
  opacity: 0;
}
.heart.happy {
  color: #A12B2B;
}
.heart.happy:before {
  opacity: 0;
  transform: translateY(-30px) rotateZ(5deg);
  animation: fly 1s ease;
}
.heart.broken {
  color: #aaa;
  position: relative;
  transition: all .3s ease;
}
.heart.broken:before, .heart.broken:after {
  content: "❤";
  opacity: 1;
  color: #ccc;
  position: absolute;
  top: -150px;
  transform: scale(3) rotateZ(0);
}
.heart.broken:before {
  clip: rect(0, 20px, 200px, 0);
  animation: break-left 1s ease forwards;
}
.heart.broken:after {
  clip: rect(0, 50px, 200px, 25px);
  animation: break-right 1s ease forwards;
}

@keyframes pulse {
  50% {
    transform: scale(1.1);
  }
}
@keyframes fly {
  0% {
    opacity: 0;
    transform: translateY(-20px) rotateZ(15deg);
  }
  50% {
    opacity: .75;
    transform: scale(4) translateY(-30px) rotateZ(-15deg);
  }
  100% {
    opacity: 0;
    transform: scale(4) translateY(-50px) rotateZ(15deg);
  }
}
@keyframes break-left {
  0% {
    opacity: 1;
    transform: scale(3) rotateZ(0);
  }
  20% {
    opacity: .5;
    transform: scale(3) translateX(-10px) rotateZ(-20deg) translateY(0);
  }
  50% {
    opacity: .5;
    transform: scale(3) translateX(-10px) rotateZ(-20deg) translateY(0);
  }
  100% {
    opacity: 0;
    transform: scale(3) translateX(-30px) rotateZ(-25deg) translateY(50px);
  }
}
@keyframes break-right {
  0% {
    opacity: 1;
    transform: scale(3) rotateZ(0);
  }
  20% {
    opacity: .5;
    transform: scale(3) translateX(10px) rotateZ(20deg) translateY(0);
  }
  50% {
    opacity: .5;
    transform: scale(3) translateX(10px) rotateZ(20deg) translateY(0);
  }
  100% {
    opacity: 0;
    transform: scale(3) translateX(30px) rotateZ(25deg) translateY(50px);
  }
}
</style>

<section id="container" style="margin:0 5% 0 5%;">

    <h5><small><a href="${path}">홈</a> > <a href="${path}/product/productAll">제품</a> > 
    <c:choose>
    	<c:when test="${product.pdtCategory eq '식품'}">
    		<a href="${path}/product/food">식품</a></small></h5>
    	</c:when>
    	<c:when test="${product.pdtCategory eq '잡화'}">
    		<a href="${path}/product/stuff">잡화</a></small></h5>
    	</c:when>
    	<c:when test="${product.pdtCategory eq '주방'}">
    		<a href="${path}/product/kitchen">주방</a></small></h5>
    	</c:when>
    	<c:when test="${product.pdtCategory eq '욕실'}">
    		<a href="${path}/product/bathroom">욕실</a></small></h5>
    	</c:when>
    	<c:when test="${product.pdtCategory eq '여성용품'}">
    		<a href="${path}/product/woman">여성용품</a></small></h5>
    	</c:when>
    	<c:when test="${product.pdtCategory eq '반려동물'}">
    		<a href="${path}/product/pet">반려동물</a></small></h5>
    	</c:when>
    </c:choose>
    <input type="hidden" name="pdtNo" id="pdtNo" value="${product.pdtNo}"/>
    <div class="row" >
    	<!-- 썸네일 -->
        <div class="col-6" >
        	<c:forTokens items="${product.thumbs}" var="th" delims="," varStatus="vs">
        	<!-- 큰사진 -->
        	<c:if test="${vs.first }">
            	<img alt="" class="img-fluid" id="main_image" style="padding-bottom:7px;" src="${path}/resources/upload/product/${th}"/>
            </c:if>
            </c:forTokens>
            <!-- 작은사진 여러개 -->
            <div class="goods_thumbs_image">
                <ul class="clearfix">
                <c:forTokens items="${product.thumbs}" var="th" delims="," varStatus="vs">
	                <li class="col-2 small_image"><a href="${path }/resources/upload/product/${th}"><img src="${path }/resources/upload/product/${th}"></a></li>
                </c:forTokens>
                </ul>
            </div>
        </div>
        <!-- 제품 info -->
        <div class="col-6 info-container" style="display:flex;flex-wrap:wrap;">
        	<div class="inner_goods_form container">
        		<div class="head" style="margin-top:0px;">
        			<div class="information size-up" style="padding-top:10px;">${product.pdtName }&nbsp;&nbsp;
        			<!-- 등록한 날짜로부터 7일이면 NEW -->
	        			<c:if test="${dateResult.pdtDate==product.pdtDate}">
	        				<div class="new-icon" style="display:inline-block;">NEW</div>
	        			</c:if>
	        			<!-- 세일하면 배너 -->
	        			<c:if test="${not empty product.eventNoRef and product.salePer!=0}">
	        				<div class="sale-icon" style="display:inline-block;">SALE</div>
	        			</c:if>
	        			<!-- soldout 배너 -->
	        			<c:if test="${product.pdtStatus=='N' }">
	        				<div class="soldout-icon" style="display:inline-block;">SOLDOUT</div>
	        			</c:if>
        			</div>
        			<!-- 세일가격 -->
					<div class="information size-up">
						<fmt:parseNumber var="i" integerOnly="true" type="number" value="${product.pdtPrice*(1-(product.salePer/100))}"/><fmt:formatNumber value="${i}"/>원&nbsp;
	        			<!-- 원래가격 -->
	        			<c:if test="${not empty product.eventNoRef and product.salePer!=0}">
	        				<span id="sale_price" value="" style="text-decoration:line-through; font-size:18px; color:dimgray;"><fmt:formatNumber value="${product.pdtPrice }" pattern="#,###"/>원</span>
	        			</c:if>
        			</div>
        			<!-- 별점 -->
                    <div class="information size-mid row">
                    	<c:if test="${reviewAvg==null }">
                    		<div class="col-10" style="visibility:hidden">별점 <c:out value="${reviewAvg}"/></div>
                    	</c:if>
                    	<c:if test="${reviewAvg!=null }">
	                    	<div class="col-10">별점 <c:out value="${reviewAvg}"/></div>
	                    </c:if>
	                    <div class="col-2"><a href=""><img src="${path}/resources/images/product/SNS.png" width="35px" style="right:0;"></a></div>
                    </div>
                    <hr>
                    <div class="information size-mid">${product.pdtIntro }</div>
                    <!-- 적립금 : 옵션이 없을경우에만 표시 -->
                    <c:if test="${empty optionlist}">
                    	<c:if test="${not empty product.eventNoRef and product.salePer!=0}">
                    		<div class="information size-mid">구매 시 <fmt:formatNumber value="${(product.pdtPrice*(1-(product.salePer/100)))*0.05}" pattern="#,###"/>봄 적립</div>
                    	</c:if>
                    	<c:if test="${empty product.eventNoRef}">
                    		<div class="information size-mid">구매 시 <fmt:formatNumber value="${product.pdtPrice*0.05 }" pattern="#,###"/>봄 적립</div>
                    	</c:if>
                    </c:if>
                    <div class="information size-mid">배송비 2,500원(50,000원이상 무료배송) | 도서산간 배송비 추가</div>
                    ${optionlist}
                    <hr>
                    
                    <!-- 1.기본선택창:옵션이 없을 경우 나올 화면 -->
                    <c:if test="${empty optionlist}">
	                   <div class="" style="padding-bottom:10px;">
	                    	<div id="info_count" style="border-radius:4px;">
	                    		<div class="information" style="margin:10px;visibility:hidden;">옵션선택확인</div>
	                    		<div class="inforamtion row">
	                    			<div class="col" style="margin-left:10px;">
	                    				<input type="button" class="input_count" value="-" id="minus" onclick="minus();">
	                    				<input type="text" class="input_count2" value="1" id="count" style="width:40px; text-align:center;">
	                    				<input type="button" class="input_count" value="+" id="plus" onclick="plus();">
	                    			</div>
	                    			<div class="col-3">
	                    			<!-- 원래가격 -->
	                    				<c:if test="${empty product.eventNoRef}">
		                    				<input type="text" value="${product.pdtPrice}" id="oriPrice" hidden="hidden"/>
		                    				<input type="text" value="${product.pdtPrice}" id="totalPrice" hidden="hidden"/>
		                    				<span id="viewPrice" style="width:60px;text-align:right; border:none;">${product.pdtPrice}</span>원
	                    				</c:if>
	                    			<!-- 세일가격 -->
	                    				<c:if test="${not empty product.eventNoRef and product.salePer!=0}">
	                    					<input type="text" value="${product.pdtPrice*(1-(product.salePer/100))}" id="oriPrice" hidden="hidden"/>
	                    					<input type="text" value="${product.pdtPrice*(1-(product.salePer/100))}" id="totalPrice" hidden="hidden"/>
	                    					<span id="viewPrice" style="width:60px;text- align:right; border:none;"><fmt:formatNumber value="${product.pdtPrice*(1-(product.salePer/100))}" pattern="###"/></span>원
	                    				</c:if>
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
                    </c:if>
                    <!-- 2.옵션선택창:옵션이 있을 경우 반드시 선택해야함 -->
                    <c:if test="${not empty optionlist }">
                    <div class="">
                    	<select class="form-control" id="optionSelect">
                    		<option readonly>옵션선택</option>
                    		<c:forEach items="${optionlist}" var="opt" varStatus="vs">
                    			<option value="${opt.pdtOptionAddprice}">${opt.pdtOptionContent}&nbsp;&nbsp;+<fmt:formatNumber value="${opt.pdtOptionAddprice}" pattern="#,###"/></option>
                    		</c:forEach>
                    	</select>	
                    </div>
                    <div class="" id="optionView" style="padding-bottom:10px;display:none;">
	                    	<div id="info_count" style="border-radius:4px;">
	                    		<div class="information" id="optionCheck" style="margin:10px;">
	                    			<span id="optionCheck">옵션확인란</span>
	                    			<span id="optionClose" style="float:right;cursor:pointer">X</span>
	                    		</div>
	                    		<div class="inforamtion row">
	                    			<div class="col" style="margin-left:10px;">
	                    				<input type="button" class="input_count" value="-" id="minus" onclick="minus();">
	                    				<input type="text" class="input_count2" value="1" id="count" style="width:40px; text-align:center;">
	                    				<input type="button" class="input_count" value="+" id="plus" onclick="plus();">
	                    			</div>
	                    			<div class="col-3">
	                    			<!-- 원래가격 -->
	                    				<c:if test="${empty product.eventNoRef}">
		                    				<input type="text" value="${product.pdtPrice}" id="oriPrice" hidden="hidden"/>
		                    				<input type="text" value="${product.pdtPrice}" id="totalPrice" hidden="hidden"/>
		                    				<input type="text" value="0" id="optionPrice"/>
		                    				<span id="viewPrice" style="width:60px;text-align:right; border:none;">${product.pdtPrice}</span>원
	                    				</c:if>
	                    			<!-- 세일가격 -->
	                    				<c:if test="${not empty product.eventNoRef and product.salePer!=0}">
	                    					<input type="text" value="${product.pdtPrice*(1-(product.salePer/100))}" id="oriPrice" hidden="hidden"/>
	                    					<input type="text" value="${product.pdtPrice*(1-(product.salePer/100))}" id="totalPrice" hidden="hidden"/>
	                    					<input type="text" value="0" id="optionPrice"/>
	                    					<span id="viewPrice" style="width:60px;text-align:right; border:none;"><fmt:formatNumber value="${product.pdtPrice*(1-(product.salePer/100))}" pattern="###"/></span>원
	                    				</c:if>
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
                    </c:if> 
                    
                    <script>
                    	//옵션선택 시 수량계산 창 나옴
                    	$("#optionSelect").change(function(){
                    		if($("#optionView").css("display")=="none"){
                    			$("#optionView").css("display","");
                    		}
                    		//옵션가격을 optionPrice value에 넣기
                    		var price = $("#optionSelect option:selected").val();
                    		$("#optionPrice").val(price);
                    		//옵션명 optionCheck에 넣기
                    		var text = $("#optionSelect option:selected").text();
                    		var optionName = text.substring(0,text.indexOf("+")).trim();
                    		$("#optionCheck").text(optionName);	
                    	});
                    	
                    	//수량계산창 닫기
                    	$("#optionClose").click(function(){
                    		$("#optionView").css("display","none");
                    	});
                    	
                    	
                    	var count = 1;
                    	var countEl = document.getElementById("count");
                    	var oriPrice = document.getElementById("oriPrice");
                    	var totalPrice = document.getElementById("totalPrice");
                    	var viewPrice = document.getElementById("viewPrice");
                    	function minus(){
                    		if(count > 1) {
                    			count--;
                    			countEl.value = count;
                    			totalPrice.value = totalPrice.value - oriPrice.value;
                    			finalPrice = totalPrice.value;
                    			$(viewPrice).text(finalPrice);
                    		}
                    	}
                    	function plus(){
                    		count++;
                    		countEl.value = count;
                    		totalPrice.value = oriPrice.value * countEl.value;
                    		finalPrice = totalPrice.value;
                    		$(viewPrice).text(finalPrice);
                    	}
                    </script>
                           			
                    <!-- 버튼 3개,로그인 안 할 경우 클릭 못하게 방지 -->    
                    <div>
                    	<c:if test="${loginMember!=null and product.pdtStatus=='Y'}">
		                    <button type="button" href="#" class="btn btn-success custom">구매하기</button>
		                    <button type="button" onclick="fn_goBasket();" class="btn btn-outline-success custom">장바구니</button>
		                    <button type="button" href="#" data-toggle="modal" data-target="#zzimView" class="btn btn-outline-success custom">찜하기</button>
	                    </c:if>
	                    <c:if test="${loginMember==null and product.pdtStatus=='Y'}">
		                    <button type="button" href="#" class="btn btn-success custom loginCheck">구매하기</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom loginCheck">장바구니</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom loginCheck">찜하기</button>
	                    </c:if>
	                    <!-- soldout일 경우 구매하기, 장바구니 클릭 방지 -->
	                    <c:if test="${loginMember!=null and product.pdtStatus=='N'}">
		                    <button type="button" href="#" class="btn btn-secondary custom soldoutCheck">구매하기</button>
		                    <button type="button" href="#" class="btn btn-outline-secondary custom soldoutCheck">장바구니</button>
		                    <button type="button" href="#" data-toggle="modal" data-target="#zzimView" class="btn btn-outline-success custom">찜하기</button>
	                    </c:if>
	                    <!-- soldout일 경우 구매하기, 장바구니 클릭 방지 -->
	                    <c:if test="${loginMember==null and product.pdtStatus=='N'}">
		                    <button type="button" href="#" class="btn btn-secondary custom soldoutCheck">구매하기</button>
		                    <button type="button" href="#" class="btn btn-outline-secondary custom soldoutCheck">장바구니</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom loginCheck">찜하기</button>
	                    </c:if>
                    </div><!-- 버튼 끝 -->
                    
                    <c:if test="${not empty favlist }">
                    <c:choose>
                  		<c:when test="${fn:contains(favlist,product.pdtNo)}">
       						<img src="${path }/resources/images/product/heartfull.png" style="height:20px;">
       					</c:when>
	       				<c:otherwise>
	       					<img src="${path }/resources/images/product/heartblank.png" style="height:20px;">
	       				</c:otherwise>
                  	</c:choose>
                  	</c:if>  
                  	
        		</div><!-- class="head" 끝 -->
        	</div>
        </div><!-- 제품 div끝 -->
        
        
      <!-- 찜하기 모달창 -->
	  <div class="modal fade" id="zzimView" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	    <div class="modal-dialog modal-sm zzim-size">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h5 class="modal-title">찜하기</h5>
	          <button type="button" class="close" data-dismiss="modal">X</button>
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body container ">
	        	<!-- 찜폴더 목록 -->
        		<p data-toggle="modal" data-target="#zzimFolderModal" data-dismiss="modal" style="cursor:pointer;padding-down:5px;">폴더 만들기 +</p>
        		<c:if test="${not empty zzimlist }">
		        	<table class="table">
	        			<c:forEach items="${zzimlist}" var="list">
			        		<tr>
			        			<td style=display:none;><c:out value="${list.zzimNo }"/></td>
			        			<td><c:out value="${list.zzimName }"/></td> <!-- 찜폴더명 -->
			        			<td style="display:none;"><c:out value="${list.favlist }"/></td>
			        			<c:choose>
			        				<c:when test="${fn:contains(list.favlist,product.pdtNo)}"> 
			        					<td><div class="heart happy">❤</div></td>
			        				</c:when>
			        				<c:otherwise>
			        					<td><div class="heart broken">❤</div></td>
			        				</c:otherwise>
								</c:choose>
			        		</tr>
				    	</c:forEach>
		        	</table>
       			</c:if>
	        </div>
	      </div>
	    </div>
	  </div><!-- 찜하기 모달창 끝! -->
	  
	  <!-- 찜하기 새폴더 만들기 -->
	  <div class="modal fade" id="zzimFolderModal">
	    <div class="modal-dialog zzim-size">
	      <div class="modal-content">
	      
	        <!-- Modal Header -->
	        <div class="modal-header">
	          <h5 class="modal-title">새 폴더 만들기</h5>
	          <button type="button" class="close" data-dismiss="modal">X</button>
	        </div>
	        
	        <!-- Modal body --> 
	        <div class="modal-body container ">
	        	<!-- 찜하기 새폴더 만들기-->
	        	<form name="" action="${path}/zzim/proInsertZzim" onsubmit="return fn_addFolder();">
		        	<input type="hidden" name="memNo" value="${loginMember.memNo}">
		        	<input type="hidden" name="pdtNo" value="${product.pdtNo }">
		        	<input type="text" class="form-control" name="zzimName" placeholder="폴더이름을 지정해주세요. (10자 이내 한글 ,영어,숫자만 가능)" required>
		        	<br>
		        	<div style="float:right"><input type="submit" class="btn btn-success" value="만들기" onclick="return fn_addFolder();"></div> 
	        	</form>
	        </div>
	      </div>
	    </div>
	  </div><!-- 찜하기 새폴더 모달창 끝! -->
        
        
		<!-- 네비바 -->
		<div class="tab_wrap container">
		    <div class="tab_menu_container container">
			    <button class="tab_menu_btn" id="productDetail" type="button">상품상세</button>
			    <button class="tab_menu_btn" id="productReview" type="button">구매평(<c:out value="${reviewCount }"/>)</button>
			    <button class="tab_menu_btn" id="productInquiry" type="button">상품문의(<c:out value="${count }"/>)</button>
		    </div> <!-- tab_menu_container e -->
		    
		    <div class="tab_box_container" style="padding-top:20px;">
		    	<!-- 상품상세 시작 -->
		    	<div id="detailResult">
					<!--제품이미지 삽입-->
					<img src="${path}/resources/upload/product/${product.pdtDetailImage}" style="width:80%; display:block;margin:auto;">
					<!--배송안내 시작!-->
					<div id="information">
						<hr>
						<p>
							<strong>■ 배송안내</strong>
						</p>
						<p>- 결제 완료일로부터 주말 및 공휴일 제외 2~5일 안에 배송됩니다.</p>
						<p>- 제주지역의 경우 추가 운임이 발생합니다.</p>
						<hr>
						<p>
							<strong>■ 교환 및 반품 안내</strong>
						</p>
						<p>- 전자상거래법에 의거하여 교환 및 반품 요청은 수령일로부터 7일 이내 입니다.</p>
						<p>- 고객의 단순 변심이나 실수로 인한 교환 및 반품의 경우 왕복 배송비는 고객이 부담하셔야 합니다.</p>
						<p>- 상품을 사용하였을 경우는 교환 및 반품이 불가합니다.(*상품 하자의 경우 예외)</p>
						<p>
							<strong>■ 제품불량에 따른 교환 및 반품 정책</strong>
						</p>
						<p>- 제품 수령일을 기준으로 7일이내 가능하며 뚜렷한 파손 및 제품 기능에 중대한 영향이 있는 경우에 한하여
							가능합니다.</p>
						<p>
							<strong>■ 단순 변심에 의한 교환 및 환불 정책</strong>
						</p>
						<p>- 제품 공급을 위한 운송비 전액(왕복 및 재발송)을 제한 금액이 환불됩니다.</p>
						<p>
							<strong>■ 교환 및 반품이 불가능한 경우</strong>
						</p>
						<p>- 포장을 개봉하였거나 훼손되어 상품 가치가 상실된 경우</p>
						<p>- 고객님의 사용 또는 일부 소비에 의해 상품의 가치가 현저히 감소한 경우</p>
						<p>- 교환 및 반품 접수 기간(7일)의 경과 혹은 시간의 경과에 의해 재판매가 곤란할 정도로 상품등의 가치가
							현저히 감소된 경우</p>
					</div>
					<!-- 위로가기 버튼 -->
					<a href="#" class="scrollTop"><img src="${path}/resources/images/product/up-arrow.png" style="height:100%;"></a>
				</div>
				
			</div><!-- tab_box_container -->
		</div><!--네비바 끝 -->
		
		<!--연관상품 스와이프-->
		<div id="recommand_wrap" class="container" style="padding-top: 50px;">
			<div class="information"><strong>연관상품</strong></div>
			<div class="swiper-container container">
				<!-- 현재 페이지의 카테고리에 해당하는 제품만 랜덤 슬라이드 -->
				<div class="swiper-wrapper">
					<c:forEach items="${slidelist}" var="s">
						<c:if test="${s.pdtCategory eq product.pdtCategory}">
							<div class="swiper-slide" style="display:block;cursor:pointer;" onclick="location.href='${path }/product/productOne?pdtNo=${s.pdtNo}'" >
								<!-- 제품이이미지 -->
								<div class="slideImg">
									<c:choose>
										<c:when test="${fn:contains(s.thumbs,',') }">
											<c:forTokens items="${s.thumbs }" var="th" delims="," varStatus="vs">
												<div>
													<!-- 첫번째 사진 -->
													<c:if test="${vs.count==1}"><img id="firstImg" src="${path }/resources/upload/product/${th}"></c:if>
													<!-- 두번째 사진 -->
													<c:if test="${vs.count==2}"><img id="secondImg" src="${path }/resources/upload/product/${th}"></c:if>
												</div>
											</c:forTokens>
										</c:when>
										<c:otherwise>
											<c:forTokens items="${s.thumbs }" var="th" delims="," varStatus="vs">
												<c:if test="${vs.count==1}"><img src="${path }/resources/upload/product/${th}"></c:if>
											</c:forTokens>
										</c:otherwise>
									</c:choose>
								</div>
								
								<!-- 가격 -->
								<div class="slidePrice">
									<span>${s.pdtName }</span><br>
									<!-- 세일가격 -->
									<span style="color:#45A663;"><fmt:formatNumber value="${s.pdtPrice*(1-(s.salePer/100))}" pattern="#,###"/>원</span>&nbsp;
				        			<!-- 원래가격 -->
				        			<c:if test="${not empty s.eventNoRef and s.salePer!=0}">
				        				<span id="sale_price" style="text-decoration:line-through; color:dimgray;"><fmt:formatNumber value="${s.pdtPrice }" pattern="#,###"/>원</span>
				        			</c:if>
								</div>
								<!-- NEW 아이콘 -->
								<c:if test="${dateResult.pdtDate==s.pdtDate}"><div class="new-icon" style="display:inline-block;width:37px;">NEW</div></c:if>
								<!-- SALE 아이콘 -->
								<c:if test="${not empty s.eventNoRef and s.salePer!=0}"><div class="sale-icon" style="display:inline-block;width:40px;">SALE</div></c:if>
								<!-- soldout 아이콘 -->
								<c:if test="${s.pdtStatus=='N' }"><div class="soldout-icon" style="display:inline-block;width:68px;">SOLDOUT</div></c:if>
							</div>
						</c:if>
					</c:forEach>
				</div>
								
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
				<!-- Add Arrows -->
				<!-- <div class="swiper-button-next"></div>
                     <div class="swiper-button-prev"></div> -->
			</div>
		</div>
		
		
	</div><!-- class="row"끝 -->
	
</section>

<script type="text/javascript">
	//썸네일 바꾸기 스크립트
	$(function() {
		$(".small_image a").click(function() {
			$("#main_image").attr("src", $(this).attr("href"));
			return false;
		});
		$(".small_image a").hover(function() {
			$("#main_image").attr("src", $(this).attr("href"));
			return false;
		});
	});
	//옵션선택 스크립트
	$('.optionChoice').click(function() {
		$(this).attr('tabindex', 1).focus();
		$(this).toggleClass('active');
		$(this).find('.dropdown-menu').slideToggle(300);
	});
	$('.optionChoice').focusout(function() {
		$(this).removeClass('active');
		$(this).find('.dropdown-menu').slideUp(300);
	});
	$('.optionChoice .dropdown-menu li').click(
			function() {
				$(this).parents('.optionChoice').find('span').text(
						$(this).text());
				$(this).parents('.optionChoice').find('input').attr('value',
						$(this).attr('id'));
			});
	
	//수량계산
	var count = 1;
	var countEl = document.getElementById("count");
	var oriPrice = document.getElementById("oriPrice");
	var totalPrice = document.getElementById("totalPrice");
	var viewPrice = document.getElementById("viewPrice");
	function minus(){
		if(count > 1) {
			count--;
			countEl.value = count;
			totalPrice.value = totalPrice.value - oriPrice.value;
			finalPrice = totalPrice.value;
			$(viewPrice).text(finalPrice);
		}
	}
	function plus(){
		count++;
		countEl.value = count;
		totalPrice.value = oriPrice.value * countEl.value;
		finalPrice = totalPrice.value;
		$(viewPrice).text(finalPrice);
	} 
	
	//상품상세 눌렀을 때
	$("#productDetail").click(e=>{
		//console.log($(e.target).html());
		$.ajax({
			url:"${path}/product/productDetail",
			data:{pdtNo:$("#pdtNo").val()},
			type:"get",
			dataType:"html",
			success:data=>{
				//console.log(data);
				$("#detailResult").html("");
				$("#detailResult").html(data);
			}
		});
	});
	
	//구매평 눌렀을 때
	$("#productReview").click(e=>{
		//console.log($(e.target).html());
		$.ajax({
			url:"${path}/product/productReview",
			data:{cPage:"${cPage}",numPerpage:"${numPerpage}",pdtNo:$("#pdtNo").val()},
			type:"get",
			dataType:"html",
			success:data=>{
				//console.log(data);
				$("#detailResult").html("");
				$("#detailResult").html(data);
			}
		});
	});
	
	//상품문의 눌렀을 때
	$("#productInquiry").click(e=>{
		//console.log($(e.target).html());
		$.ajax({
			url:"${path}/product/productInquiry",
			data:{cPage:"${cPage}",numPerpage:"${numPerpage}",pdtNo:$("#pdtNo").val()},
			type:"get",
			dataType:"html",
			success:data=>{
				//console.log(data);
				$("#detailResult").html("");
				$("#detailResult").html(data);
			}
		});
	});
	
	//연관상품 스와이프 스크립트
	var swiper = new Swiper('.swiper-container', {
		slidesPerView : 5, //보여줄 슬라이드 갯수
		spaceBetween : 20, //슬라이드간 간격
		slidesPerGroup : 5, //그룹으로 묶을 수
		loop : true, //무한반복
		loopFillGroupWithBlank : false, //그룹수가 맞지 않을 경우 빈칸 채우기(true)/그림으로 채우기(false)
		speed: 1200, //슬라이드 속도 
		pagination : { //페이징처리
			el : '.swiper-pagination',
			clickable : true, //페이징 클릭 시 해당 영역으로 이동
		},
		autoplay : {
			delay : 5000,
		},
	});
	//연관상품 위에 마우스 올렸을 시 이벤트
	var mySwiper = document.querySelector('.swiper-container').swiper;
	//마우스 오버시 STOP!
	$(".swiper-container").mouseenter(function() {
		mySwiper.autoplay.stop();
	});
	//마우스 나갔을 시 다시 시작
	$(".swiper-container").mouseleave(function() {
		mySwiper.autoplay.start();
	});
	
	
	//구매하기,장바구니,찜하기,상품문의 클릭 시 로그인 체크
	$(function() {
		$(".loginCheck").click(function() {
			swal("로그인을 먼저 해주세요");
		});
	});
	
	//soldout 일 경우 클릭 방지
	$(".soldoutCheck").click(function(){
		swal("제품이 현재 SOLDOUT 되었습니다");
	});
	
	
	//위로가기 버튼
	$(function(){
		$(window).scroll(function(){
			let scroll = document.body.scrollHeight;
			if(scroll*0.1<$(this).scrollTop() && $(this).scrollTop()<scroll*0.8){
				$(".scrollTop").fadeIn();
			}else{
				$(".scrollTop").fadeOut();
			}
		});
	});
	
	//구매평 - 별점 마킹 모듈 프로토타입으로 생성
	function Rating(){};
	Rating.prototype.rate = 0;
	Rating.prototype.setRate = function(newrate){
		//별점 마킹 - 클릭한 별 이하 모든 별 체크 처리
		this.rate = newrate;
		let items = document.querySelectorAll('.rate_radio');
		items.forEach(function(item, idx){
			if(idx < newrate){
				item.checked = true;
			}else{
				item.checked = false;
			}
		});
	}
	let rating = new Rating();//별점 인스턴스 생성 
	
 	//찜하기 모달창 끄기
 	$(".modalClose").click(function(){
 		$(modal).close();
 	});
 	
 	//찜하기 폴더 추가
 	function fn_addFolder(){
 		//폴더이름 유효성검사
		var zzimName=$("input[name=zzimName]").val();
		var nameCheck = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/;
		if(zzimName.length<1 || zzimName.length>10){
			swal("폴더명은 한글자 이상 10이내만 가능합니다.");
			return false;
		}
		if(!nameCheck.test(zzimName)){
			swal("한글,숫자,영문만 폴더명으로 가능합니다.");
			return false;
		}
 	}
 	
 	//찜하기 버튼
 	let zzimNo;
    $(".heart").click(function(){
    	$(this).attr("class",function(index,attr){
      		//찜하기 누른 상태
    		if(attr.match("broken")){
		        let zzimNo = $(this).parent().parent().children().eq(0).text();
		        
		        $.ajax({
		        	url:"${path}/zzim/proInsertZzim2",
		      		data:{pdtNo:$("#pdtNo").val(),zzimNo:zzimNo},
		      		dataType:"json",
		      		success:data=>{
		      			if(data.likePdtno!=null){
			      			//swal({text:"찜하기 추가가 완료되었습니다",timer:1000}); //알림창 1초뒤 닫기
			      			$("#zzimFolderModal").modal("hide"); //모달닫기
		      			}
		      		},error:function(error){
		      			swal("찜하기를 다시 추가해주세요");
		      		}
		        });
		        return attr.replace("broken","happy");
			//찜하기 취소 상태
    		}else {
		        let zzimNo = $(this).parent().parent().children().eq(0).text();
		        let pdtNo = $("#pdtNo").val();
		        
		        $.ajax({
		        	url:"${path}/zzim/proDeleteZzim",
		        	data:{pdtNo:$("#pdtNo").val(),zzimNo:zzimNo},
		      		dataType:"json",
		      		success:data=>{
		      			//현재제품이랑 비교해서 없을경우
		      			if(data.likePdtno.indexOf("pdtNo")==-1){
		      				//swal({text:"찜하기 삭제가 완료되었습니다",timer:1000});
		      				$("#zzimFolderModal").modal("hide");
		      			}
		      		},error:function(error){
		      			swal("찜하기를 다시 삭제해주세요");
		      		}
		        });
		        return attr.replace("happy","broken");
	    	}
    	});
      
    });
	
	//장바구니 버튼 누르면 실행됨
	function fn_goBasket(pdtNo){
		//basket으로 insert시킬 url
		let basUrl = "${path}/admin/basket";
		//넘길 변수들 - 상품번호pdtNo, 옵션번호pdtOptionNo, 갯수 Qty
		let basket_need = {pdtNo : pdtNo, };
		
		//장바구니 insert용 함수
		
	};
</script>
    
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
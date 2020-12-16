<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

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

/*셀렉트박스 디자인*/
.optionChoice {
	width: 100%;
	height: 45px;
	display: inline-block;
	background-color: #fff;
	border-radius: 4px;
	border: #28a745 1px solid;
	transition: all .5s ease;
	position: relative;
	cursor: pointer;
}

.optionChoice .select {
	cursor: pointer;
	padding: 10px;
	-webkit-appearance: none;
	/* 네이티브 외형 감추기 */
	-moz-appearance: none;
	appearance: none;
}

.optionChoice .dropdown-menu {
	position: absolute;
	background-color: #fff;
	text-align: left;
	width: 100%;
	border-radius: 0 0 4px 4px;
	border: #28a745 1px solid;
	overflow: hidden;
	display: none;
	overflow-y: auto;
}

.optionChoice .dropdown-menu li {
	padding: 10px;
	transition: all .2s ease-in-out;
	cursor: pointer;
}

.optionChoice .dropdown-menu {
	padding: 0;
	list-style: none
}

.optionChoice .dropdown-menu li:hover {
	color: #28a745;
}

.optionChoice .dropdown-menu li:active {
	background-color: #28a745;
}

/*수량 스타일*/
#info_count {
	border: #28a745 1px solid;
	width: 100%;
	height: 100px;
}

.input_count {
	border: #28a745 1px solid;
	background-color: #fff;
	color: 00000;
	width: 26px;
	font-size: 13px;
	display: table-cell;
	vertical-align: middle;
	text-align: center;
}

.input_count2 {
	border: #28a745 1px solid;
	background-color: #fff;
	color: 00000;
	width: 26px;
	font-size: 13px;
	display: table-cell;
	vertical-align: middle;
	text-align: center;
}

/* 버튼 크기 조절 */
.custom {
	width: 163px !important;
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
	width: 100%;
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
	border: #45A663 1px solid;
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

.swiper-slide img {
	/* 이미지 최대너비 제한 */
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
}

.slideImg {
	padding-top: 10px;
}

/*상품문의 박스 스타일*/
div.wrap-category {
	margin: 7px 0px 7px 0px;
	text-align: left;
}

.span_textarea {
	position: relative;
	padding: 8px;
	width: auto;
	border: lightslategray 1px solid;
	border-radius: 4px;
	display: inline-block;
	width: 100%;
	height: 200px;
}

textarea {
	width: 99%;
	height: 80%;
	resize: none;
	border: none;
}

textarea:focus {
	outline: none;
}

textarea.inqContent {
	width: 100%;
	height: 100%;
	resize: none;
	border: none;
	margin: 7px 0 7px 0;
}

textarea.answer {
	width: 100%;
	height: 100%;
	resize: none;
	border: none;
	margin: 7px 0 7px 0;
}

/* 상품문의 모달창 */
#modalClick {
	cursor: pointer;
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

/* 스타 체크박스 옆으로 조절 */
.rating .rate_radio {
	position: relative;
	display: inline-block;
	z-index: 20;
	opacity: 0.001;
	width: 20px;
	height: 20px;
	background-color: #fff;
	cursor: pointer;
	vertical-align: top;
	/* 체크박스 안 보이게  */
	display: none;
}

.rating .rate_radio+label {
	position: relative;
	display: inline-block;
	/* margin-left: -4px; */
	margin: 0 0 -4px -3px;
	z-index: 10;
	width: 20px;
	height: 20px;
	background-image: url('../resources/images/product/starblank.png');
	background-repeat: no-repeat;
	background-size: 20px 20px;
	cursor: pointer;
	background-color:
}

.rating .rate_radio:checked+label {
	background-image: url('../resources/images/product/star.png');
}

/* 구매평 */
.review_span {
	height: 250px;
}

#review_textarea {
	height: 50%;
}

.accordion_title {
	display: flex;
	position: relative;
}

.plusminus::before {
	content: '';
	display: block;
	width: 24px;
	height: 3px;
	background-color: #45A663;
	position: absolute;
	right: 0;
	transform: rotate(90deg);
	transition: .5s;
	margin: 10px;
}

.plusminus::after {
	content: '';
	display: block;
	width: 24px;
	height: 3px;
	background-color: #45A663;
	position: absolute;
	right: 0;
	transform: rotate(0deg);
	margin: 10px;
}

.plusminus.active::before {
	transform: rotate(0deg);
}

.accordion_title:hover {
	cursor: pointer;
}

.accordion_title {
	margin: 10px;
}

.accordion_title:active .shortContent {
	style: none;
}

.accordion_content {
	display: block;
	margin: 0;
	height: 0;
	overflow: hidden;
	transition: .5s;
}

.accordion_content.show {
	margin: 10px;
}

.accordion_wrap {
	border-color: #E2E2E2;
	list-style: none;
	border-width: 1px 0 0 0;
	border-style: solid;
	padding: 0px;
}

.accordion_inner {
	border-color: #E2E2E2;
	list-style: none;
	border-width: 0 0 1px 0;
	border-style: solid;
	margin: 10px 0 0 0;
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
    <c:out value="${product}"/>
    <div class="row" >
    	<!-- 썸네일 -->
        <div class="col-6" >
        	<c:forTokens items="${product.thumbs}" var="th" delims="," varStatus="vs">
        	<!-- 큰사진 -->
        	<c:if test="${vs.first }">
            	<img alt="" class="img-fluid" id="main_image" style="padding-bottom:7px;" src="${path}/resources/upload/product/${th}"/>
            </c:if>
            <!-- 작은사진 여러개 -->
            <div class="goods_thumbs_image row container">
                <ul class="clearfix">
	                <li class="col-2 small_image"><a href="${path }/resources/upload/product/${th}"><img src="${path }/resources/upload/product/${th}"></a></li>
                </ul>
            </div>
            </c:forTokens>
        </div>
        <!-- 제품 info -->
        <div class="col-6 info-container" style="display:flex;flex-wrap:wrap;">
        	<div class="inner_goods_form container">
        		<div class="head" style="margin-top:0px;">
        			<div class="information size-up" style="padding-top:10px;">${product.pdtName }&nbsp;&nbsp;
        			<c:if test="${product.eventNoRef!=null }">
        			<img src="${path}/resources/images/product/sale.jpg" width="50px">
        			</c:if>
        			</div>
        			<div class="information size-up"><fmt:formatNumber value="${product.pdtPrice }" pattern="#,###"/>원&nbsp;
        			<c:if test="${product.eventNoRef!=null }">
        				<span id="sale_price" value="" style="text-decoration:line-through; font-size:18px; color:dimgray;"><fmt:formatNumber value="${product.pdtPrice }" pattern="#,###"/>원</span>
        			</c:if>
        			</div>
                    <div class="information size-mid row">
	                    <div class="col-10">별점</div>
	                    <div class="col-2"><a href=""><img src="${path}/resources/images/product/SNS.png" width="35px" style="right:0;"></a></div>
                    </div>
                    <hr>
                    <div class="information size-mid">${product.pdtIntro }</div>
                    <div class="information size-mid">구매 시 <fmt:formatNumber value="${product.pdtPrice*0.05 }" pattern="#,###"/>봄 적립</div>
                    <div class="information size-mid">배송비 2,500원(50,000원이상 무료배송) | 도서산간 배송비 추가</div>
                    <hr>
                    
                    <!-- 1.기본선택창:옵션이 없을 경우 나올 화면 -->
                    <c:if test="${product.pdtOptionNo==null}">
	                   <div class="information" style="padding-bottom:10px;">
	                    	<div id="info_count" style="border-radius:4px;">
	                    		<div class="information" style="margin:10px;visibility:hidden;">옵션선택확인</div>
	                    		<div class="inforamtion row">
	                    			<div class="col" style="margin-left:10px;">
	                    				<input type="button" class="input_count" value="-" id="minus" onclick="minus();">
	                    				<input type="text" class="input_count2" value="1" id="count" style="width:40px; text-align:center;">
	                    				<input type="button" class="input_count" value="+" id="plus" onclick="plus();">
	                    			</div>
	                    			<div class="col-3">
	                    				<input type="text" value="${product.pdtPrice}" id="total_count" hidden="hidden"/>
	                    				<input type="text" value="${product.pdtPrice}" id="total_count_view" style="width:60px;text-align:right; border:none;" readonly/>원
	                    			</div>
	                    		</div>
	                    	</div>
	                    </div>
                    </c:if>
                    <script>
                	//수량선택 스크립트
                	var count = 1;
                	var countEl = document.getElementById("count");
                	var total_count = document.getElementById("total_count");
                	var total_count_view = document.getElementById("total_count_view");

                	function minus(){
                		if(count > 1) {
                			count--;
                			countEl.value = count;
                			total_count_view.value = total_count_view.value - total_count.value;
                		}
                	}
                	function plus(){
                		count++;
                		countEl.value = count;
                		total_count_view.value = total_count.value * countEl.value;
                	}
                    </script>                  
                    
                    <!-- 2.옵션선택창:옵션이 있을 경우 반드시 선택해야함 -->
                    <c:if test="${product.pdtOptionNo!=null}">
                    <div class="information">
                    	<div class="optionChoice">
                    		<div class="select">
                    			<span class="size-mid">옵션선택</span>
                    		</div>
                    		<input type="hidden" name="option">
                    		<ul class="dropdown-menu">
                    			<li id="one">1번</li>
                    			<li id="two">2번</li>
                    		</ul>
                    	</div>
                    </div>
                    <div class="information" style="padding-bottom:10px;">
                    	<div id="info_count" style="border-radius:4px;">
                    		<div class="information" style="margin:10px;">옵션선택확인</div>
                    		<div class="inforamtion">
                    			<div style="float:left;margin:0 0 0 10px;">
                    				<input type="button" class="input_count" value="-" id="minus" onclick="minus();">
                    				<input type="text" class="input_count2" value="1" id="count" style="width:40px; text-align:center;">
                    				<input type="button" class="input_count" value="+" id="plus" onclick="plus();">
                    			</div>
                    			<div style="float:right;margin:0 10px 0 0;">
                    				<input type="text" value="4000" id="total_count" hidden="hidden"/>
                    				<input type="text" value="4000" id="total_count_view" style="width:60px;right:0; border:none;" readonly/>원
                    			</div>
                    		</div>
                    	</div>
                    </div>
                    </c:if>        			
                    <!-- 버튼 3개,로그인 안 할 경우 클릭 못하게 방지 -->        			
                    <div class="information container">
                    	<c:if test="${loginMember!=null }">
		                    <button type="button" href="#" class="btn btn-success custom">구매하기</button>
		                    <button type="button" onclick="fn_goBasket();" class="btn btn-outline-success custom">장바구니</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom">찜하기</button>
	                    </c:if>
	                    <c:if test="${loginMember==null }">
		                    <button type="button" href="#" class="btn btn-success custom loginCheck">구매하기</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom loginCheck">장바구니</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom loginCheck">찜하기</button>
	                    </c:if>
                    </div>                            			     			
        		</div><!-- class="head" 끝 -->
        	</div>
        </div><!-- 제품 div끝 -->
 
		<!-- 네비바 -->
		<div class="tab_wrap container">
		    <div class="tab_menu_container container">
			    <button class="tab_menu_btn on" type="button">상품상세</button>
			    <button class="tab_menu_btn" type="button">구매평(<c:out value="${reviewCount }"/>)</button>
			    <button class="tab_menu_btn" type="button">상품문의(<c:out value="${count }"/>)</button>
		    </div> <!-- tab_menu_container e -->
		    <div class="tab_box_container">
		    	<!-- 상품상세 시작 -->
		    	<div class="tab_box on">
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
					<a href="#" class="scrollTop"><img src="${path}/resources/images/product/up-arrow.png"></a>
				</div>
				
		    	<!-- 구매평 시작 -->
		    	<div class="tab_box">
			        <!--구매평 작성창-->
			        <form name="frm_review" action="${path}/review/insertReview" method="post" enctype="multipart/form-data" onsubmit="return fn_reviewCheck()" >
				        <div class="writebox_wrap container" style="float:none; margin:10px 0 10px 0;">
				            <button type="button" class="btn btn-success showBox">구매평 작성</button>
					        <div class="wrap-category" style="display:none;">
						        <span class="span_textarea review_span">
							        <textarea name="revContent" id="review_textarea" placeholder="구매평을 입력해주세요" onKeyUp="javascript:fnChkByte2(this,'500')"></textarea>
							        <div class="imgPreview" style="height:30%;"></div>
							        <div class="wrap_bottom">
							        <div style="float:left;left:0;bottom:0;">
							        	<!-- 업로드 사진 -->
							       		<img id="uploadImage1" src="${path}/resources/images/product/gallery.png" style="width:25px;height:25px;">&nbsp;
							       		<input type="file" id="upload1" name="upload1" accept="image/gif, image/jpeg, image/png" style="display:none;">
							       		<!-- 별점 -->
								        <div class="rating" style="display:inline-block;">
											<!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
											<input type="checkbox" id="rating1" name="rating" class="rate_radio" value="1">
											<label for="rating1"></label>
											<input type="checkbox" id="rating2" name="rating" class="rate_radio" value="2">
											<label for="rating2"></label>
											<input type="checkbox" id="rating3" name="rating" class="rate_radio" value="3">
											<label for="rating3"></label>
											<input type="checkbox" id="rating4" name="rating" class="rate_radio" value="4">
											<label for="rating4"></label>
											<input type="checkbox" id="rating5" name="rating" class="rate_radio" value="5">
											<label for="rating5"></label>
										</div>
									</div>
									<div style="float:right;">
									<span id="byteInfo2">0</span>/500bytes
										<!-- 로그인 한 사람 및 구매한 사람만 구매평 등록가능-->
								        <c:if test="${loginMember!=null }">
								        	<input type="hidden" name="memNo" value="${loginMember.memNo}">
								        	<input type="hidden" name="revScore">
								        	<input type="submit" class="btn btn-success textCheck" value="등록" style="right:0;">
								        </c:if>
								        <c:if test="${loginMember==null }">
								        	<input type="button" class="btn btn-success loginCheck" value="등록" style="right:0;">
								        </c:if>
						        	</div>
						        	</div>
						        </span>
					        </div>
				        </div>
			        </form><!-- 구매평 작성창 끝 -->
			        
			        <!-- 구매평 게시글 -->
			        <div id="reviewResult">
			        	<div class="container">
				        	 <c:if test="${not empty reviewlist }">	
				        		 <ul class="accordion_wrap">
					        		 <c:forEach items="${reviewlist}" var="r">
									    <li class="accordion_inner">
									    <!-- 타이틀 -->
									      <div class="accordion_title">
									      	<div class="col-9">
									      		<!-- 별점 불러오기 -->
									      		<c:forEach begin="1" end="${r.revScore}" step="1" varStatus="vs"> 
									      			<img src="${path}/resources/images/product/star.png" style="width:20px;height:20px;margin:0 0 5px -3px;">
									      		</c:forEach>
									      		<c:forEach begin="1" end="${5-r.revScore}" step="1">
									      		 	<img src="${path}/resources/images/product/starblank.png" style="width:20px;height:20px;margin:0 0 5px -3px;">
									      		</c:forEach>
										      	<span><c:out value="${r.revScore}"/></span><br>
										      	<img src="${path }/resources/upload/profile/${r.memPro}" style="max-width:30px; height:30px;border-radius:50%;">&nbsp;
											      <span><strong><c:out value="${r.memNick}" /></strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><fmt:formatDate type="both" timeStyle="short" value="${r.revDate }"/></span><br>
											     <c:out value="${r.revContent}"/>
									      	</div>
									      	<div class="col-2"><c:if test="${r.revImage!=null }"><img src="${path}/resources/upload/review/${r.revImage }" style="height: auto;"/></c:if></div>
									      	<div class="col-1 plusminus"></div>
									      </div>
									      <!-- 상세보기 -->
									      <div class="accordion_content">
									      	<div>
										        <!-- 작성자와 로그인한 사람이 같을경우 수정, 삭제 버튼 생성 -->
										        <c:if test="${loginMember.memNo==r.memNo }">
										        	<div style="display:inline-block;float:right;">
										        		<input type="hidden" name="revNo" value="${r.revNo}">
											        	<input type="button" class="btn btn-outline-success btn-sm updateView" data-toggle="modal" data-target="#updateReview" value="수정">
											        	<span style="display:none"><c:out value="${r.revNo}"/></span>
													    <span style="display:none"><c:out value="${r.memNick}"/></span>
													    <span style="display:none"><c:out value="${r.revScore}"/></span>
													    <span style="display:none"><c:out value="${r.revContent}"/></span>
													    <span style="display:none"><c:out value="${r.revImage}"/></span>
													    <span style="display:none"><fmt:formatDate type="both" timeStyle="short" value="${r.revDate }"/></span>
													    <span style="display:none"><c:out value="${r.memPro}"/></span>
						        						<input type="button" class="btn btn-outline-success btn-sm deleteReviewCk" data-confirm="구매평을 삭제하시겠습니까?" value="삭제">
										        	</div>
										        </c:if>
										        <br><br>
										        <c:if test="${r.revImage!=null }"><img src="${path}/resources/upload/review/${r.revImage }" style="max-width:40%; height: auto;"/></c:if>
									      	</div>
									      </div>
									    </li>
									</c:forEach>    
								</ul>
							</c:if>
							<c:if test="${empty reviewlist }">
						    	등록된 구매평이 없습니다
						    </c:if>		    
			        	</div>
			        </div>
		    	</div><!-- 구매평 끝 -->
		    	
		    	<!-- 구매평 수정 모달창 -->
		   <div class="modal fade" id="updateReview">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">구매평 수정하기</h4>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
		        
		        <!-- Modal body -->
			        <div class="modal-body container">
				        	<!-- 상품문의 내용 -->
				        	<span class="revScore"></span><br>
				        	<img id="memProimg">
				        	<strong><span class="memNick"></span></strong>&nbsp;&nbsp;<span class="revDate"></span>&nbsp;&nbsp;&nbsp;&nbsp;
				        	<input type="hidden" name="revNo" class="revNo"/>
							<div id="secret" style="display:inline-block;">
					        	<input type="button" class="btn btn-outline-success btn-sm" value="수정완료">
				        	</div>
				        	<span class="span_textarea" style="margin: 10px 0 0 0;">
							    <textarea class="revContent" name="revContent" style="height:50%;" onKeyUp="javascript:fnChkByte3(this,'500')"></textarea>
							    	<div id="uploadPreview" style="height:30%;"><img id="imgPreview" style="height:30%;"></div>
							        <div class="wrap_bottom">
							        <div style="float:left;left:0;bottom:0;">
							        	<!-- 업로드 사진 -->
							       		<img id="uploadImage2" src="${path}/resources/images/product/gallery.png" style="width:25px;height:25px;">&nbsp;
							       		<input type="file" id="upload2" name="upload2" accept="image/gif, image/jpeg, image/png" style="display:none;">
							       		<!-- 별점 -->
								        <div class="rating" style="display:inline-block;">
											<!-- 해당 별점을 클릭하면 해당 별과 그 왼쪽의 모든 별의 체크박스에 checked 적용 -->
											<input type="checkbox" id="revrating1" name="rating" class="rate_radio" value="1">
											<label for="revrating1"></label>
											<input type="checkbox" id="revrating2" name="rating" class="rate_radio" value="2">
											<label for="revrating2"></label>
											<input type="checkbox" id="revrating3" name="rating" class="rate_radio" value="3">
											<label for="revrating3"></label>
											<input type="checkbox" id="revrating4" name="rating" class="rate_radio" value="4">
											<label for="revrating4"></label>
											<input type="checkbox" id="revrating5" name="rating" class="rate_radio" value="5">
											<label for="revrating5"></label>
										</div>
									</div>
									<div style="float:right;">
									<!--  -->
									<span id="byteInfo3" style="display:none;">0</span><!-- /500bytes -->
						        	</div>
						        	</div>
						    </span>
				        </div>
		        
		      </div>
		    </div>
		  </div><!-- 구매평 모달창 끝 -->
		  
		  <script>
		  //구매평 수정창 클릭시 모달창 띄움
		  $(".updateView").click(function(){
			 let wrap = $(this).parent();
			 let choice = wrap.children("span");
			 
			 let revNo = choice.eq(0).text();
			 let memNick = choice.eq(1).text();
			 let revScore = choice.eq(2).text();
			 let revContent = choice.eq(3).text();
			 let revImage = choice.eq(4).text();
			 let revDate = choice.eq(5).text();
			 let memPro = choice.eq(6).text();
			 
			 $(".revNo").val(revNo);
			 $(".memNick").text(memNick);
			 $(".revScore").text(revScore);
			 $(".revContent").text(revContent);
			 
			 //별점이 있을경우 checked
			 if(revScore==1){
				 $("input:checkbox[name='rating']:checkbox[value='1']").prop("checked",true);
			 }else if(revScore==2){
				 $("input:checkbox[name='rating']:checkbox[value='2']").prop("checked",true);
			 }else if(revScore==3){
				 $("input:checkbox[name='rating']:checkbox[value='3']").prop("checked",true);
			 }else if(revScore==4){
				 $("input:checkbox[name='rating']:checkbox[value='4']").prop("checked",true);
			 }else if(revScore==5){
				 $("input:checkbox[name='rating']:checkbox[value='5']").prop("checked",true);
			 }
			 
			 //이미지가 있을경우 모달창에 이미지 넣어두기
			 if(revImage!=""){
				 $("#imgPreview").prop("src","${path}/resources/upload/review/"+revImage);
				 $("#imgPreview").prop("style","height:100%;");
			 }else{
				 $("#imgPreview").prop("src","");
			 }
			 
			 $(".revDate").text(revDate);
			 $("#memProimg").prop("src","${path}/resources/upload/profile/"+memPro);
			 $("#memProimg").prop("style","max-width:30px; height:30px;border-radius:50%;");
		  });
		  
		  	//수정누를경우 수정완료로 변경
			$(this).attr("value",function(index,attr){
				if(attr.match("수정")){
					console.log("수정완료");
					return attr.replace("수정","수정완료");
				}
			});
		  
		  </script>
		    	
		    	
		    	<!-- 상품문의 시작 -->
				<div class="tab_box">
			        <!--상품문의 작성창-->
			        <form name="frm_inquiry" action="${path}/product/insertInquiry" onsubmit="return fn_check()">
				        <div class="writebox_wrap container" style="float:none; margin:10px 0 10px 0;">
				            <button type="button" class="btn btn-success showBox">상품문의</button>
					        <div class="wrap-category" style="display:none;">
						        <span class="span_textarea">
							        <textarea name="inqContent" id="inqContent" placeholder="문의내용을 입력해주세요" onKeyUp="javascript:fnChkByte1(this,'500')"></textarea>
									<div style="float:right;">
										<span id="byteInfo1">0</span>/500bytes
								        <label>
						 		        	<img id="lockUnlock" src="${path}/resources/images/product/unlock.png" name="inqSecret" style="width:25px;height:25px;">
								        	<input type="hidden" id="secret" name="inqSecret" value="N">
								        </label>
								        <c:if test="${loginMember!=null }">
								        	<input type="hidden" name="memNo" value="${loginMember.memNo}">
								        	<input type="submit" class="btn btn-success" value="등록" style="right:0;">
								        </c:if>
								        <c:if test="${loginMember==null }">
								        	<input type="button" class="btn btn-success loginCheck" value="등록" style="right:0;">
								        </c:if>
						        	</div>
						        </span>
					        </div>
				        </div>
			        </form><!-- 상품문의 작성창 끝 -->
			        
			        <!-- 상품문의 게시글 -->
			        <div id="result">
				        <div class="container">
					        <table class="table" style=" table-layout: fixed;">
						    <c:if test="${not empty list }">	
						        <thead>
						        	<tr>
						        		<td style="width:10%;">상태</td>
						        		<td style="width:65%;">내용</td>
						        		<td style="width:20%;">문의날짜</td>
						        		<td style="width:15%;">작성자</td>
						        	</tr>
						        </thead>
								<c:forEach items="${list}" var="i">
						        	<thead>
						        		<tr>
						        			<td>
						        				<c:out value="${i.inqAnswerYn=='Y'?'답변완료':'답변대기'}"/>
						        			</td>					        		
						        			<td style="width:100%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						        				<c:if test="${i.inqSecret=='N'}">
						        					<a href="#" data-toggle="modal" data-target="#inquiryView" data-no='<c:out value="${i.inqNo}"/>' data-content='<c:out value="${i.inqContent }"/>'
						        						data-answeryn='<c:out value="${i.inqAnswerYn}"/>' data-date='<fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/>' data-memnick='<c:out value="${i.memNick}"/>'
						        						data-answer='<c:out value="${i.inqAnswer}"/>' data-answerdate='<fmt:formatDate type="both" timeStyle="short" value="${i.inqAnswerDate}"/>'
						        						data-secret='<c:out value="${i.inqSecret}"/>' data-memno='<c:out value="${i.memNo}"/>' data-loginno='<c:out value="${loginMember.memNo}"/>'>
						        						<c:out value="${i.inqContent }"/>
						        					</a>
						        				</c:if>
						        				<c:if test="${i.inqSecret=='Y' and loginMember.memNo==i.memNo }">
						        					<img src="${path}/resources/images/product/lock.png" style="width:20px;height:20px;">
						        					<a href="#" data-toggle="modal" data-target="#inquiryView" data-no='<c:out value="${i.inqNo}"/>' data-content='<c:out value="${i.inqContent }"/>'
						        						data-answeryn='<c:out value="${i.inqAnswerYn}"/>' data-date='<fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/>' data-memnick='<c:out value="${i.memNick}"/>'
						        						data-answer='<c:out value="${i.inqAnswer}"/>' data-answerdate='<fmt:formatDate type="both" timeStyle="short" value="${i.inqAnswerDate}"/>'
						        						data-secret='<c:out value="${i.inqSecret}"/>' data-memno='<c:out value="${i.memNo}"/>' data-loginno='<c:out value="${loginMember.memNo}"/>'>
						        						<c:out value="${i.inqContent }"/>
						        					</a>
						        				</c:if>
						        				<c:if test="${i.inqSecret=='Y' and loginMember.memNo!=i.memNo}">
						        					<img src="${path}/resources/images/product/lock.png" style="width:20px;height:20px;">
						        					<a href="#" onclick="secretCk();">
						        					<c:out value="${i.inqContent }"/></a>
						        				</c:if>					        		
						        			</td>
						        			<td><fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/></td>
						        			<td>
						        				<c:out value="${i.memNick}"/>
						        			</td>
						        		</tr>
						        	</thead>
						        </c:forEach>
					        </c:if>
					        <c:if test="${empty list }">
					        	<thead>
					        		<tr>
					        			<td colspan="4">등록된 문의가 없습니다</td>
					        		</tr>
					        	</thead>
					        </c:if>
					        </table>
				        </div><!-- 상품문의 게시글 끝 -->			        
				        <div class="pageBar">
							<span>${pageBar }</span>
				    	</div>
			    	</div><!-- result 끝 -->
			        
			      <!-- 상품문의 모달창 -->
				  <div class="modal fade" id="inquiryView" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				    <div class="modal-dialog">
				      <div class="modal-content">
				      
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h5 class="modal-title">상품문의</h5>
				          <button type="button" class="close" data-dismiss="modal">X</button>
				        </div>
				        
				        <!-- Modal body --> 
				        <div class="modal-body container">
				        	<!-- 상품문의 내용 -->
				        	<strong><span id="memNick"></span></strong>&nbsp;&nbsp;<span id="inqDate"></span>&nbsp;&nbsp;&nbsp;&nbsp;
				        	<input type="hidden" name="inqNo" class="inqNo"/>
							<div id="secret" style="display:inline-block;">
					        	<input type="button" class="btn btn-outline-success btn-sm fn_updateInquiry" value="수정">
					        	<input type="button" class="btn btn-outline-success btn-sm deleteInquiryCk" data-confirm="문의를 삭제하시겠습니까?" value="삭제"><br>
				        	</div>
				        	<textarea class="inqContent" name="inqContent" id="textCk" style="background-color:#fff;" disabled></textarea>
				        	<hr>
				        	<!-- 상품문의 관리자 답변 내용 -->
				        	<strong><span>관리자</span></strong>&nbsp;&nbsp;<span class="answerDate"></span>&nbsp;&nbsp;&nbsp;&nbsp;
				        	<!-- 관리자로 로그인 했을시&&답변이 있을경우에만 수정,삭제창 생김 -->
				        	<c:if test="${loginMember.memManagerYn=='Y'}">
				        		<div id="secret2" style="display:inline-block;">
					        		<input type="button" class="btn btn-outline-success btn-sm fn_updateInquiryAnswer" value="수정">
					        		<input type="button" class="btn btn-outline-success btn-sm deleteAnswerCk" data-confirm="답변을 삭제하시겠습니까?" value="삭제"><br>
				        		</div>
				        	</c:if>
				        	<textarea class="answer" name="inqAnswer" id="textAnswerCk" style="background-color:#fff;" disabled></textarea>
				        </div>
				        <!-- 모달창 상품문의 답변창 시작, 관리자일 경우에만 답변창 생김-->
				        <c:if test="${loginMember.memManagerYn=='Y'}">
					        <form name="frm_inquiryAnswer" action="${path}/inquiry/insertInquiryAnswer" onsubmit="return fn_answerCheck()">
						        <div class="writebox_wrap container" style="float:none; margin:10px 0 10px 0;">
								    <span class="span_textarea" style="height:150px; ">
										<textarea name="inqAnswer" class="inqAnswer" placeholder="답변을 입력해주세요" style="height:70%;"></textarea>
										<div style="float:right;">
											<c:if test="${loginMember!=null }">
												<input type="hidden" name="memNo" value="${loginMember.memNo}">
												<input type="hidden" name="inqNo" class="inqNo"/>
												<input type="submit" class="btn btn-success" value="등록" style="right:0;">
											</c:if>
											<c:if test="${loginMember==null }">
												<input type="button" class="btn btn-success loginCheck" value="등록" style="right:0;">
											</c:if>
									    </div>
								    </span>
						        </div>
					        </form><!-- 모달창 상품문의 답변창  끝 -->
				        </c:if>			        	
				      </div>
				    </div>
				  </div><!-- 상품문의 모달창 끝! -->
				</div>
			</div><!-- tab_box_container -->
		</div><!--네비바 끝 -->
		
		<!--연관상품 스와이프-->
		<div id="recommand_wrap" style="padding-top: 50px;">
			<div class="information">연관상품</div>
			<div class="swiper-container container">
				<div class="swiper-wrapper">
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/upload/product/coffee1.jpg">
						</div>
						<div class="slideImg"><span>제품명1</span><br><span>제품가격</span></div>
						<div>
							<img src="${path}/resources/images/product/sale.jpg" width="50px">
						</div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/upload/product/soap1.jpg">
						</div>
						<div class="slideImg"><span>제품명2</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/upload/product/som1.jpg">
						</div>
						<div class="slideImg"><span>제품명3</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/upload/product/woman1.jpg">
						</div>
						<div class="slideImg"><span>제품명4</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/upload/product/coffee1.jpg">
						</div>
						<div class="slideImg"><span>제품명5</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/upload/product/coffee1.jpg">
						</div>
						<div class="slideImg"><span>제품명6</span><br><span>제품가격</span></div>
					</div>
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

	
	//수량선택 스크립트
	/* var count = 1;
	var countEl = document.getElementById("count");
	var total_count = document.getElementById("total_count");
	var total_count_view = document.getElementById("total_count_view");

	function minus(){
		if(count > 1) {
			count--;
			countEl.value = count;
			total_count_view.value = total_count_view.value - total_count.value;
		}
	}
	function plus(){
		count++;
		countEl.value = count;
		total_count_view.value = total_count.value * countEl.value;
	} */

	
	//네비바
	$(".tab_menu_btn").on("click", function() {
		//버튼 색 제거,추가
		$(".tab_menu_btn").removeClass("on");
		$(this).addClass("on");

		//컨텐츠 제거 후 인덱스에 맞는 컨텐츠 노출
		var idx = $(".tab_menu_btn").index(this);

		$(".tab_box").hide();
		$(".tab_box").eq(idx).show();
	});

	//연관상품 스와이프 스크립트
	var swiper = new Swiper('.swiper-container', {
		slidesPerView : 5, //보여줄 슬라이드 갯수
		spaceBetween : 20, //슬라이드간 간격
		slidesPerGroup : 5, //그룹으로 묶을 수
		loop : true, //무한반복
		loopFillGroupWithBlank : false, //그룹수가 맞지 않을 경우 빈칸 채우기(true)/그림으로 채우기(false)
		pagination : { //페이징처리
			el : '.swiper-pagination',
			clickable : true, //페이징 클릭 시 해당 영역으로 이동
		},
		autoplay : {
			delay : 2000,
		},
	});
	//연관상품 위에 마우스 올렸을 시 이벤트
	var mySwiper = document.querySelector('.swiper-container').swiper;
	//마우스 오버시 STOP!
	$(".swiper-container").mouseenter(function() {
		mySwiper.autoplay.stop();
		console.log('slider stopped');
	});
	//마우스 나갔을 시 다시 시작
	$(".swiper-container").mouseleave(function() {
		mySwiper.autoplay.start();
		console.log('slider started again');
	});

	
	//상품문의 클릭 시 박스 보였다가 안보였다가 이벤트
	$(function() {
		$(".showBox").click(function() {
			if ($(this).next().css("display") == "none") {
				$(this).next().show(1000);
			} else {
				$(this).next().hide(1000);
			}
		});
	});
	
	//상품문의 자물쇠그림바꾸기 + 비밀글 파라미터값 넘기기
	$("#lockUnlock").click(function() {
		$(this).attr("src", function(index, attr) {
			if(attr.match("unlock")) {
				$("#secret").attr("value",function(index,attr){ 
					if(attr.match("N")){
						console.log("Y");
						return attr.replace("N","Y");
					}
				});
				return attr.replace("unlock.png", "lock.png");
			} else {
				$("#secret").attr("value",function(index,attr){
					if(attr.match("Y")){
						console.log("N");
						return attr.replace("Y","N");
					}
				});
				return attr.replace("lock.png", "unlock.png");
			}
		});
	});
	
    //상품문의 Byte 수 체크 제한
    function fnChkByte1(obj, maxByte) {
      var str = obj.value;
      var str_len = str.length;
      var rbyte = 0;
      var rlen = 0;
      var one_char = "";
      var str2 = "";

      for(var i = 0; i<str_len; i++) {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
          rbyte += 3; //한글2Byte
        }else{
          rbyte++; //영문 등 나머지 1Byte
        }

        if(rbyte <= maxByte){
          rlen = i + 1; //return할 문자열 갯수
        }
      }

      if(rbyte > maxByte) {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte1(obj, maxByte);
      }else{
        document.getElementById("byteInfo1").innerText = rbyte;
      }
    }

    //구매평 Byte 수 체크 제한
    function fnChkByte2(obj, maxByte) {
      var str = obj.value;
      var str_len = str.length;
      var rbyte = 0;
      var rlen = 0;
      var one_char = "";
      var str2 = "";

      for(var i = 0; i<str_len; i++) {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
          rbyte += 3; //한글2Byte
        }else{
          rbyte++; //영문 등 나머지 1Byte
        }

        if(rbyte <= maxByte){
          rlen = i + 1; //return할 문자열 갯수
        }
      }

      if(rbyte > maxByte) {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte2(obj, maxByte);
      }else{
        document.getElementById("byteInfo2").innerText = rbyte;
      }
    }   
    
    //구매평 수정하기 Byte 수 체크 제한
    function fnChkByte3(obj, maxByte) {
      var str = obj.value;
      var str_len = str.length;
      var rbyte = 0;
      var rlen = 0;
      var one_char = "";
      var str2 = "";

      for(var i = 0; i<str_len; i++) {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
          rbyte += 3; //한글2Byte
        }else{
          rbyte++; //영문 등 나머지 1Byte
        }

        if(rbyte <= maxByte){
          rlen = i + 1; //return할 문자열 갯수
        }
      }

      if(rbyte > maxByte) {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte3(obj, maxByte);
      }else{
        document.getElementById("byteInfo3").innerText = rbyte;
      }
    }      
    

	//구매하기,장바구니,찜하기,상품문의 클릭 시 로그인 체크
	$(function() {
		$(".loginCheck").click(function() {
			swal("로그인을 먼저 해주세요");
		});
	});
	
	//상품문의 클릭 시 입력확인
	function fn_check(){
		if(frm_inquiry.inqContent.value==""){
			swal("문의내용을 입력해주세요");
			return false;
		}
		return true;
	}	
	
	//상품문의 페이징
	$(function(){
		$(".pageBar").click(e=>{
			$.ajax({
				url:"${path}/product/productOneAjax",
				data:{cPage:"${cPage}",numPerpage:"${numPerPage}"},
				type:"get",
				success:data=>{
					console.log(data);
					$("#result").html("");
					$("#result").html(data);
				}
			});
		});
	});	
	
  	//상품문의 상세보기 답변입력확인
	function fn_answerCheck(){
		if(frm_inquiryAnswer.inqAnswer.value==""){
			swal("답변을 입력해주세요");
			return false;
		}
		return true;
	}	
	
	//상품문의 답변삭제
	$(".deleteInquiryCk").on("click",function(e){
		e.preventDefault();
		var choice = confirm($(this).attr('data-confirm'));
		if(choice){
			let inqNo = $(event.target).parents().children('input[name=inqNo]').val();
			location.replace("${path}/inquiry/deleteInquiry?inqNo="+inqNo);
		}
	});
	
	//상품문의 답변삭제
	$(".deleteAnswerCk").on("click",function(e){
		e.preventDefault();
		var choice = confirm($(this).attr('data-confirm'));
		if(choice){
			let inqNo = $(event.target).parents().children('input[name=inqNo]').val();
			location.replace("${path}/inquiry/deleteInquiryAnswer?inqNo="+inqNo);
		}	
	});
	
	//비밀글 접근제한
	function secretCk(){
		alert("작성자와 관리자만 접근할 수 있는 글입니다");
	}

	//상품문의 수정버튼 클릭 시 
	$(".fn_updateInquiry").click(function(){
		//수정 -> 수정완료버튼으로 바꾸고, textarea 활성화
		if($("textarea[id=textCk]").attr("disabled")){
			$(this).attr("value",function(index,attr){
				if(attr.match("수정")){
					console.log("수정완료");
					return attr.replace("수정","수정완료");
				}
			});
			$("textarea[id=textCk]").attr("style","border:lightslategray 1px solid;border-radius:4px;padding:8px;");
			return $("textarea[id=textCk]").removeAttr("disabled");
		}else{
			//수정완료 누를 시 수정한 내용 update
			$(this).attr("value",function(index,attr){
				if(attr.match("수정완료")){
					let inqNo = $(event.target).parents().children('input[type=hidden][name=inqNo]').val();
					let inqContent = $(event.target).parents().children('textarea[name=inqContent]').val();
					location.replace("${path}/inquiry/updateInquiry?inqNo="+inqNo+"&inqContent="+inqContent);
				}
			});
			$("textarea[id=textCk]").attr("style","background-color:#fff;");
			return $("textarea[id=textCk]").attr("disabled","");
		}
	});	
	
	//상품문의 관리자답변 수정버튼 클릭 시 
	$(".fn_updateInquiryAnswer").click(function(){
		//수정 -> 수정완료버튼으로 바꾸고, textarea 활성화
		if($("textarea[id=textAnswerCk]").attr("disabled")){
			$(this).attr("value",function(index,attr){
				if(attr.match("수정")){
					console.log("수정완료");
					return attr.replace("수정","수정완료");
				}
			});
			$("textarea[id=textAnswerCk]").attr("style","border:lightslategray 1px solid;border-radius:4px;padding:8px;");
			return $("textarea[id=textAnswerCk]").removeAttr("disabled");
		}else{
			//수정완료 누를 시 수정한 내용 update
			$(this).attr("value",function(index,attr){
				if(attr.match("수정완료")){
					let inqNo = $(event.target).parents().children('input[type=hidden][name=inqNo]').val();
					let inqAnswer = $(event.target).parents().children('textarea[name=inqAnswer]').val();
					console.log(inqNo);
					console.log(inqAnswer);
					location.replace("${path}/inquiry/updateInquiryAnswer?inqNo="+inqNo+"&inqAnswer="+inqAnswer);
				}
			});
			$("textarea[id=textAnswerCk]").attr("style","background-color:#fff;");
			return $("textarea[id=textAnswerCk]").attr("disabled","");
		}
	});
	
	//상품문의 상세보기 모달창
	$(document).ready(function(){
  		$("#inquiryView").on("show.bs.modal",function(event){ //modal 윈도우가 오픈할 때 아래 옵션 적용
  			var a = $(event.relatedTarget); //이벤트 적용시 모달 윈도우 오픈하는 a 태그
  			var inqNo = a.data("no");
  			var inqContent = a.data("content"); //a태그에서 data-content 값을 inqContent에 저장
  			var inqDate = a.data("date");
  			var memNick = a.data("memnick");
  			var answerYn = a.data("answeryn");
  			var answer = a.data("answer");
  			var answerDate = a.data("answerdate");
  			var inqSecret = a.data("secret");
  			var memNo = a.data("memno");
  			var loginno = a.data("loginno");
  			var modal = $(this);
  			
  			//로그인 한 사람==게시글 작성자 일 경우에만 수정,삭제버튼 생성
            if(memNo==loginno){
            	$("div[id=secret]").show();
            }else{
            	$("div[id=secret]").hide();
            }
  			
  			//관리자로 로그인 시, 답변이 있을경우에만 수정,삭제버튼 생성
  			if(answerYn=='Y'){
  				$("div[id=secret2]").show();
  			}else{
  				$("div[id=secret2]").hide();
  			}
  			
  			modal.find(".inqNo").val(inqNo);
  			modal.find(".inqContent").text(inqContent); //모달창에서 .modal-body에 inqContent값을 출력
  			modal.find("#inqDate").text(inqDate);
  			modal.find("#memNick").text(memNick);
  			modal.find(".answerYn").text(answerYn);
  			modal.find(".answer").text(answer);
  			modal.find(".answerDate").text(answerDate);
  		});
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
	
	//별점 마킹 모듈 프로토타입으로 생성
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

	//별점선택
	$(document).ready(function(){
		$("input[name=rating]").click(function(){
			if($(this).find("rate_radio")){
				rating.setRate(parseInt($(this).val()));
				//별점 점수
				console.log(rating.rate);
				$("input[type=hidden][name=revScore]").val(rating.rate);
			}
		});
	});

	//별점선택 안 했을 시 알림, 리뷰 5자 미만 시 알림
	function fn_reviewCheck(){
		if($("#review_textarea").val().length<5){
			swal("상품평을 5글자 이상 입력해주세요");
			return false;
		}
		if(rating.rate==0){
			swal("별점을 선택해주세요")
			return false;
		}
		
	}
	
	//구매평 사진 클릭 시 업로드 새창뜨기
	$("#uploadImage1").click(function(){
		$("#upload1").click();
	});
		
	$("#upload1").change(e => {
   		let reader = new FileReader();
   		reader.onload = e =>{
   			let img = $("<img>").attr({"src":e.target.result,"style":"width:70px;height:auto"});
   			
   			$(".imgPreview").html("");
   			$(".imgPreview").append(img);
   		}
   		reader.readAsDataURL($(e.target)[0].files[0]);
	});	
	
	
	//구매평 아코디언
	window.onload = init();
    function init() {
        const accordion_items = document.querySelectorAll(".accordion_title");
        for (var i = 0; i < accordion_items.length; i++) {
          accordion_items[i].addEventListener("click", function () {
            this.nextElementSibling.classList.toggle("show");
            this.classList.toggle("active");
            if (this.classList.contains("active")) {
              this.nextElementSibling.style.height =
                this.nextElementSibling.children[0].clientHeight + 40 + "px";
            } else {
              this.nextElementSibling.style.height = 0;
            }
          });
        }
      }
    
    //구매평 삭제, 구매평 지우려면 revNo가 필요할 것 같은데?
	$(".deleteReviewCk").on("click",function(e){
		e.preventDefault();
		var choice = confirm($(this).attr('data-confirm'));
		if(choice){
			let revNo = $(event.target).parents().children('input[name=revNo]').val();
			location.replace("${path}/review/deleteReview?revNo="+revNo);
		}	
	});	
    
	//구매평 수정화면 사진 클릭 시 업로드 새창뜨기
	$("#uploadImage2").click(function(){
		$("#upload2").click();
	});
			
	$("#upload2").change(e => {
		let reader = new FileReader();
		reader.onload = e =>{
			let img = $("<img>").attr({"src":e.target.result,"style":"height:100%"});
			$("#uploadPreview").html("");
			$("#uploadPreview").append(img);
	   	}
		reader.readAsDataURL($(e.target)[0].files[0]);
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
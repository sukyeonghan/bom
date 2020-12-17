<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!-- icon -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="Welcom springAgain" />
</jsp:include>

<!-- 따라오는 div.js -->
<script src="${path }/resources/js/jquery.scrollfollow.js"></script>

<style>
#basket_header>h1 {
	height: 80px;
	margin: 50px 0;
}

.basket_container_wrap {
	display: flex;
	justify-content: space-around;
}

.basket_sidebar {
	position: absolute;
	left: 100px;
	top: 30px;
	width: 150px;
}
</style>
<style>
ol, ul {
	list-style: none;
}
/* 상품선택 체크박스 */
.carted-product__select {
	position: relative;
	display: inline-block;
	font-size: 0;
	padding: 9px;
}

path[Attributes Style] {
	fill: currentcolor;
	d: path("M 6.185 10.247 l 7.079 -7.297 l 1.435 1.393 l -8.443 8.703 L 1.3 8.432 l 1.363 -1.464 Z"
		);
}

svg:not(:root) {
	overflow: hidden;
}

.product-small-item__image {
	flex: 0 0 auto;
	position: relative;
	display: block;
	width: 70px;
	height: 70px;
	border-radius: 6px;
	background-color: #ededed;
	overflow: hidden;
}

.product-small-item__image>img {
	display: block;
	position: absolute;
	top: 50%;
	left: 50%;
	width: 100%;
	transition: transform .2s;
	transform: translate(-50%, -50%) scale(1.0001);
}

.carted-product {
	position: relative;
}

.carted-product__delete {
	position: absolute;
	display: inline-block;
	top: 15px;
	right: 10px;
	padding: 5px;
	background: none;
	border: none;
	font-size: 0;
	transition: opacity .1s;
	color: #424242;
}
.check_input {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    margin: 0;
    padding: 0;
    cursor: inherit;
    opacity: 0;
    box-sizing: border-box;
}
</style>
<script>
	// 움직이는 사이드바
	$(document).ready(function() {
		$(".basket_sidebar").scrollFollow({
			speed : 1000, // 움직이는 속도
			offset : 250
		// 웹페이지 상단에서 부터의 거리
		});
	});
</script>

<section id="container" class="container ">
	<div class="basket_header">
		<h1>주문하기</h1>
	</div>
	<div class="basket_container_wrap">
		<div class=" col-8">
			<!--좌측메뉴선택시 화면 -->
			<div id="basket-container" class="media-body">
				<div id="product_view">
					<ul>
						<c:forEach items="${list }" var="b">
							<li>
								<div class="carted-product d-flex">
									<!-- 선택 체크박스 -->
									<div class="carted-product__select">
										<input type="checkbox" id="" class="check_input">
									</div>
									<!-- 상품이동 -->
									<div>
										<a class="product-small-item product-small-item--clickable"
											href="${path }/product/productOne?pdtNo=${b.pdtNo}">
											<div class="product-small-item__image">
												<img
													src="${path}/resources/upload/product/${b.pdtDetailImage}"
													style="width: 100px; height: 100px;">
											</div>
											<p>
												<c:out value="${b.pdtName }" />
											</p>
										</a>
										<!-- 변경버튼 -->
										<div>
											<fmt:formatNumber value="${b.inbasQty}" pattern="###,###" />
											개
											<button class="btn btn-outline-primary">변경</button>
										</div>
									</div>
									<!-- 삭제버튼 -->
									<div>
										<button type="button" onclick=""
											class="carted-product__delete">
											<svg width="12" height="12" viewBox="0 0 12 12"
												fill="currentColor">
										<path fill-rule="nonzero"
													d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path>
										</svg>
										</button>
									</div>

								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		<div class="col-4">
			<!-- 따라오는 사이드바 -->
			<div class="basket_sidebar">
				<h2>주문하기</h2>
				<p>상품금액 : 68,500 원</p>
				<p>배송비 : 2,500원</p>
				<hr>
				<p>
					결제금액 : <span id="price">71,500</span>원
				</p>
				<div class="btn-contain">
					<input type="button" class="btn btn-outline-success btn-block"
						onclick="fn_goOrder();" value="결제하기">
					<div class="btn-particles"></div>
				</div>
			</div>
		</div>
	</div>

</section>

<script>
	var oriPrice = $("#price").html(); //총 결제금액
	var price; //db에 넘길 금액 변수
	price = oriPrice.replace(",", ""); //,제거 작업

	function fn_goOrder() {
		location.assign("${path}/order/doOrder");
	}
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<c:set var="totalPdtPrice" value="0" />
<c:set var="totalSale" value="0"/>
<c:set var="totalPrice" value="0"/>
<c:forEach items="${list}" var="l">
	<c:set var="totalPdtPrice" value="${l.inbasQty * l.pdtPrice}"/>
	<c:set var="totalSale" value="${l.pdtPrice - (l.pdtPrice * l.salePer/100)}"/>
	<c:set var="totalPrice" value="${totalPrice + (l.inbasQty * (l.pdtPrice - (l.pdtPrice * l.salePer/100)))}" />
</c:forEach>

<!-- icon -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="Welcome springAgain" />
</jsp:include>

<!-- 따라오는 div.js -->
<script src="${path }/resources/js/jquery.scrollfollow.js"></script>


<script>
	//움직이는 사이드바
	$(document).ready(function() {
		$(".basket_sidebar").scrollFollow({
			speed : 1000, // 움직이는 속도
			offset : 150
		// 웹페이지 상단에서 부터의 거리
		});
	});
</script>

<section id="container" class="container">
	<div class="basket_header">
		<h1>주문하기</h1>
	</div>
	<div class="basket_container_wrap">
			<div class=" col-8">
				<div id="basket-container" class="media-body">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>선택한 상품</th>
							<th>수량</th>
							<th>가격</th>
							<th></th><!-- 삭제 -->
						</tr>
					</thead>
					<form name="basketFrm" id="basketFrm" action="${path}/order/doOrder">
						<tbody>
							<c:forEach items="${list }" var="b">
							<tr>
							
							<td>
							<!-- 상품보여주기 -->
							<div>
								<a href="${path }/product/productOne?pdtNo=${b.pdtNo}"
									class="d-flex">
								<!-- 제품썸네일 -->
								<c:forTokens items="${b.pdtThumbImage}" var="th" delims="," varStatus="vs">
									<c:if test="${vs.first }">
										<img src="${path}/resources/upload/product/${th}"
											class="img-fluid" style="width: 50px; height: 50px;">
									</c:if>
								</c:forTokens>
								<p class="pdtName_p"><c:out value="${b.pdtName }" /></p>
								</a>
								<input type="hidden" name="pdtNo" value="${b.pdtNo }" class="pNo"> 
								<input type="hidden" name="pdtOptionNo" value="${b.pdtOptionNo }" class="opNo">
								<input type="hidden" name="basketNo" value="${b.basketNo }" class="bNo">
							</div>
							</td>
							
							<!-- 수량 -->
							<td>
								<div class="input_number_wrap option-count-input">
									<input type="text" name="inbasQty" 
										class="form-control amount" value="${b.inbasQty }"
										pattern="[0-9]*" size="3" min="1"
										style="width: 80px; text-align: center;"/>
								</div>
							</td>
							
							<!-- 가격 -->
							<td>
								<div class="pdtOnePrice">
									<fmt:formatNumber
										value="${b.salePer != 0? b.pdtPrice-(b.pdtPrice*(b.salePer/100)) : b.inbasQty*b.pdtPrice}"
										pattern="#,###,###" />
									원
								</div>
							</td>
							<!-- 삭제버튼 -->
							<td class="carted-product">
								<button type="button" class="remove carted-product__delete" onclick="fn_delete();">
									<svg width="12" height="12" viewBox="0 0 12 12"
										fill="currentColor">
                         				<path fill-rule="nonzero"
											d="M6 4.6L10.3.3l1.4 1.4L7.4 6l4.3 4.3-1.4 1.4L6 7.4l-4.3 4.3-1.4-1.4L4.6 6 .3 1.7 1.7.3 6 4.6z"></path></svg>
								</button>
							</td>
						</tr>
						</c:forEach>
						</form>
					</tbody>
				</table>
				</div><!-- /basket-container -->
			</div><!-- /basket-container-wrap -->

			<!-- 따라다니는 사이드 바 영역-->
			<div class="col-4">
				<!-- 따라오는 사이드바 -->
				<div class="basket_sidebar">
				
					<div>
						<p>
							상품금액 <span id="plusPrice">
								<fmt:formatNumber pattern="#,###,###" value="${totalPdtPrice }"/>
							</span>원
						</p>
					</div>
					<div>
						<p>
							할인금액 <span id="salePrice">
								(-)<fmt:formatNumber pattern="#,###,###" value="${totalSale }"/>
							</span>원
						</p>
					</div>
					<hr>
					<div>
						<p>
							결제금액 <span id="totalPrice">
							<fmt:formatNumber pattern="#,###,###" value="${totalPrice }"/>
							</span>원
						</p>
					</div>
					<!-- 결제하기 -->
					<div class="btn-contain">
						<button form="basketFrm" class="btn btn-outline-success btn-block">결제하기</button>
					</div>
				</div>
			</div>
		
	</div>
</section>

<script type="text/javascript">

	//select box ID로 접근하여 선택된 값 읽기
	//$("#셀렉트박스ID option:selected").val();
	
	var prices = $(".pdtOnePrice").html(); //상품가격(할인됐으면 할인적용)
	var pNos = $(".pNo"); //상품번호
	var bNos = $(".bNo"); //장바구니번호
	var opNos = $(".opNo"); //상품옵션번호
	var removes = $(".remove"); //삭제버튼
	var qtys = $(".qty");//수량

	
	//장바구니 상품삭제하기
	var pNo;
	var bNo;
	var opNo;
	$(document).on("click",".remove",function(e){
		console.log("삭제");
		var ck = confirm("삭제하시겠습니까?");
		if(ck){
			$.ajax({
				url : "${path}/order/deleteBasketOne",
				data : {"pdtNo": pNo, "basketNo":bNo,"pdtOptionNo":opNo},
				dataType : "html",
				success : data =>{
					console.log(data);
					$("table").html("");
					$("table").html(data);
				}
			});
		}
	});
	
	
	//수량값변경
	var amounts = $(".amount");
	$(document).on("keyup",".amount",function(e){
		
	});
	
	//수량 버튼 클릭시 태그 색변경
    $(document).on("focus",".amount",function(e){
   		$(e.target).css("outline-color","#27b06e");
	});
	
</script>
<style>
ol, ul {
	list-style: none;
}
/* 상품선택 체크박스 */
path[Attributes Style] {
	fill: currentcolor;
	d: path("M 6.185 10.247 l 7.079 -7.297 l 1.435 1.393 l -8.443 8.703 L 1.3 8.432 l 1.363 -1.464 Z"
		);
}

svg:not(:root) {
	overflow: hidden;
}

input[type='number'], input[type='text'], input[type='password'], input[type='file'],
	input[type='tel'], input[type='email'], select, option, textarea, input[type='submit'],
	button {
	-webkit-appearance: none;
	-moz-appearance: textfield;
}

svg[Attributes Style] {
	width: 10;
	height: 10;
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
.basket_header>h1 {
	margin: 50px 0;
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

.form-relative {
	position: relative;
}

.select-input>.form-control {
	height: 24px;
	padding: 0 10px;
	font-size: 13px;
	line-height: 22px;
	border-radius: 3px;
	text-align: center;
}

.option-count-input {
	width: 80px;
}

.input_number_wrap>.form-control {
	height: 24px;
	padding: 0 10px;
	font-size: 13px;
	line-height: 22px;
	border-radius: 3px;
	text-align: center;
	font-family: Tahoma, sans;
}

.option-count-input .select-input__icon {
	top: 2px;
	right: 5px;
}

.option-count-input input.form-control {
	height: 24px;
	padding: 0 10px;
	font-size: 13px;
	border-radius: 3px;
	line-height: 22px;
	text-align: center;
}

.select-input__icon {
	position: absolute;
	top: 10px;
	right: 10px;
	padding: 5px;
	font-size: 0;
	cursor: default;
	color: rgba(0, 0, 0, .3);
	pointer-events: none;
}

.pdtName_p {
	font-size: 14px;
}
</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
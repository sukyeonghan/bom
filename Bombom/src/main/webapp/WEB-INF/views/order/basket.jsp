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
	<c:set var="totalPdtPrice" value="${totalPdtPrice+ (l.inbasQty * l.pdtPrice)}"/>
	<c:if test="${l.salePer != 0 }">
		<c:set var="totalSale" value="${totalSale+((l.pdtPrice * l.salePer/100))}"/>
	</c:if>
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
<script src="${path }/resources/js/basket.js"></script>
<link rel="stylesheet" href="${path }/resources/css/order/memberBasket.css"/>

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
							<th style="width: 40%;">선택한 상품</th>
							<th style="width: 20%;">수량</th>
							<th style="width: 20%;">가격</th>
							<th style="width: 10%;">할인</th>
							<th style="width: 10%;"></th><!-- 삭제 -->
						</tr>
					</thead>
					<form name="basketFrm" id="basketFrm" action="${path}/order/doOrder">
						<tbody>
							<c:forEach items="${list }" var="b">
							<tr>
							
							<td>
							<!-- 상품보여주기 -->
							<div class="show_pdt-wrap">
								<a href="${path }/product/productOne?pdtNo=${b.pdtNo}"
									class="d-flex">
								<!-- 제품썸네일 -->
								<c:forTokens items="${b.pdtThumbImage}" var="th" delims="," varStatus="vs">
									<c:if test="${vs.first }">
										<img src="${path}/resources/upload/product/${th}"
											class="img-fluid" style="width:80px; height: 80px;">
									</c:if>
								</c:forTokens>
								<!-- 제품명 -->
								<div class="pdtName_p"><p><c:out value="${b.pdtName }" /><br>
									<fmt:formatNumber value="${b.pdtPrice}" pattern="#,###,###" />원</p></div>
								</a>
							</div>
							<input type="hidden" name="memNo" value="${b.memNo }" > 
							<input type="hidden" class="pNo" name="pdtNo" value="${b.pdtNo }" > 
							<input type="hidden" class="opNo" name="pdtOptionNo" value="${b.pdtOptionNo }" >
							<input type="hidden" class="bNo" name="basketNo" value="${b.basketNo }">
							</td>
							
							<!-- 수량 -->
							<td>
								<div class="input_number_wrap option-count-input form-number">
									<button  class="Btnminus form-number_control" type="button" onclick="fn_minus(event);">
										<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="currentColor" d="M 7 11.5 h 10 v 1 H 7 Z"></path></svg>
									</button>
										<input type="text" name="inbasQty" 	class="qty form-control " value="${b.inbasQty }" style="width: 80px; text-align: center;"
										onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' />
									<button  class="Btnplus form-number_control" type="button" onclick="fn_plus(event);">
										<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path fill="currentColor" d="M 11.5 11.5 V 6 h 1 v 5.5 H 18 v 1 h -5.5 V 18 h -1 v -5.5 H 6 v -1 h 5.5 Z"></path></svg>
									</button>
								</div>
							</td>
							
							<!-- 가격 -->
							<td>
								<div class="pdtOnePrice">
									<fmt:formatNumber value="${b.salePer != 0? b.pdtPrice-(b.pdtPrice*(b.salePer/100)) : b.inbasQty*b.pdtPrice}" pattern="#,###,###" />원
								</div>
							</td>
							<td>
								<div>(-)<fmt:formatNumber pattern="#,###,###" value="${b.salePer != 0? b.pdtPrice*(b.salePer/100) : 0 }" />원</div>
							</td>
							<!-- 삭제버튼 -->
							<td class="carted-product">
								<button type="button" class="remove carted-product__delete" 
									onclick="fn_delete('${b.pdtNo}','${b.basketNo }','${b.memNo }');">
                         				<svg fill="currentColor" style="width: 15px;height:15px;"><path fill-rule="nonzero"
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
						<p>상품금액 <span id="plusPrice"><fmt:formatNumber pattern="#,###,###" value="${totalPdtPrice }"/></span>원</p>
					</div>
					<div>
						<p>할인금액 <span id="salePrice" style="color: red;font-weight: 800;">(-)<fmt:formatNumber pattern="#,###,###" value="${totalSale }"/></span>원</p>
					</div>
					<hr>
					<div>
						<p>결제금액 <span id="totalPrice" style="font-weight: 800;font-size: 18px;"><fmt:formatNumber pattern="#,###,###" value="${totalPrice }"/></span>원</p>
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
	//수량 -
	var qty = $(".qty");
	
	$("[class^=Btn]").on("click",function(event){
		var before = $(this).attr("class");
		var after = before.replace("Btn","");
		var qtyBtn = after.substr(0,5);
		console.log(qtyBtn.trim().length);
		
		var minus = qtyBtn.trim();
		var plus = qtyBtn.trim();
		if()
		
	});
	
	$(".minus").click(e => {
		
		
	});

	//수량 +
	function fn_plus(target){
		console.log("+");
	
	}

	
</script>
<style>

</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
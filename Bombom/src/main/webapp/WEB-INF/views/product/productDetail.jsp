<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
/* 배송 안내사항 */
#information p {
	font-size: 12px;
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
</style>
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
				
<script>
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
</script>
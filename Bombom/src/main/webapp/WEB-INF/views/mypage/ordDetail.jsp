<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" " />
</jsp:include>
<style>
#flexDiv {
	display: flex;
	padding: 0px 10% 0px 10%;
}

#mypage-container {
	min-width: 800px;
	width: 100%;
	padding-right: 100px;
}

/* 주문 상품정보 */
.order-info {
	margin-top: 30px;
}
/* 테이블 */
.table th, .table td {
	vertical-align: middle;
}

.table .th {
	vertical-align: middle;
}
/* 페이지 번호 들어갈 곳 */
#page-bar {
	text-align: center;
	margin-top: 30px;
}
/* 주문상품정보 정렬 */
.order-item .table th, .order-item .table td {
	text-align: center;
	vertical-align: middle;
}

.order-info .table th, .order-payment .table th, .order-address .table th
	{
	width: 160px;
}

table {
	border: 1px #e9ecef solid;
}

.order-payment .table tr:nth-child(4) {
	color: red;
	font-weight: bolder;
}
/* 서브 헤드라인 */
p {
	font-size: 18px;
	font-weight: bolder;
}
/* 버튼 */
.btn-box {
	text-align: center;
	margin-bottom: 30px;
}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp" />
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container">
			<h3>주문 상세내역</h3>
			<div class="order-item">
				<p>주문 상품 정보</p>
				<table class="table">
					<thead>
						<tr>

							<th>이미지</th>
							<th>상품명</th>
							<th>상품옵션</th>
							<th>수량</th>
							<th>상품금액</th>
							<th>총 금액</th>

						</tr>
					</thead>
					<tbody>
						<c:set var="total" value="0" />
						<c:forEach items="${product}" var="p" varStatus="vs">
							<tr>
								<c:forTokens items="${p.pdtThumbImage}" var="th" delims=","
									varStatus="vs">
									<c:if test="${vs.first }">

										<td><img alt="" class="img-fluid" id="main_image"
											style="height: 40px"
											src="${path}/resources/upload/product/${th}" /></td>
									</c:if>
								</c:forTokens>
								<td><c:out value="${p.pdtName}" /></td>
								<td><c:out value="${p.pdtOptionContent}" /></td>
								<td><c:out value="${p.inorderQty}" /></td>
								<td><fmt:formatNumber pattern="#,###,###" value="${p.pdtPrice}" />원</td>
								<td><fmt:formatNumber pattern="#,###,###"
										value="${p.inorderQty * p.pdtPrice}" />원</td>
							</tr>
							<c:set var="total" value="${p.inorderQty * p.pdtPrice + total}" />
						</c:forEach>
						<tr>
							<td colspan="5">총 합계</td>
							<td id="total"><b><fmt:formatNumber pattern="#,###,###"
										value="${total }" />원</b></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="order-info">
				<p>주문 정보</p>
				<table class="table table-borderless">
					<tr>
						<th>주문자</th>
						<td><c:out value="${order.ordOname}" /></td>
						
						<th>주문번호</th>
						<td><c:out value="${order.orderNo}" /></td>
					</tr>
					<tr>
						<th>전화번호</th>
						<td><c:out value="${order.ordOphone}" /></td>
						
						<th>주문일자</th>
						<td><fmt:formatDate type="both" dateStyle="full"
								value="${order.ordDate}" /></td>
					</tr>
				
				</table>
			</div>
			<div class="order-payment">
				<p>결제 금액</p>
				<table class="table table-borderless">

					<tr>
						<th>주문금액</th>
						<td id="total2"></td>
					</tr>
					<tr>
						<th>포인트결제액</th>
						<td><fmt:formatNumber pattern="#,###,###"
								value="${order.ordUsePoint}" /></td>
					</tr>
					<tr>
						<th>결제금액</th>
						<td><b><fmt:formatNumber pattern="#,###,###"
									value="${order.ordAmount }" />원</b></td>
					</tr>
				</table>
			</div>
			<div class="order-address">
				<p>배송지 정보</p>
				<table class="table table-borderless">

					<tr>
						<th>받는사람</th>
						<td><c:out value="${order.ordRname }" /></td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td><c:out value="${order.ordZipcode}" /></td>
					<tr>
						<th>주소</th>
						<td><c:out value="${order.ordAddr }" />
							<c:out value="${ order.ordDetailAddr}" /></td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td><c:out value="${order.ordRphone }" /></td>
					</tr>
					<tr>
						<th>배송메시지</th>
						<td><c:out value="${order.ordMemo }" /></td>
					</tr>
				</table>
			</div>

			<div class="btn-box">
				<button type="button" class="btn btn-outline-success"
					onclick="location.replace('${path}/mypage/orderStatus')">목록으로</button>
			</div>
		</div>
	</div>

</section>
<script>
//주문금액 다시 결제정보에 다시 쏴주기 
$("#total2").text($("#total").text())
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
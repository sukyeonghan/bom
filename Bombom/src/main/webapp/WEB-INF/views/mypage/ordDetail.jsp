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
							<th>상품정보</th>
							<th>수량</th>
							<th>상품금액</th>
							<th>주문상태</th>

						</tr>
					</thead>
					<tbody>
						<tr>
							<td>상품이미지</td>
							<td>대나무칫솔</td>
							<td>2</td>
							<td>3,000원</td>
							<td>배송중[3650928566501]</td>

						</tr>
						<tr>
							<td>상품이미지</td>
							<td>대나무칫솔</td>
							<td>2</td>
							<td>3,000원</td>
							<td>배송중[3650928566501]</td>

						</tr>


					</tbody>
				</table>
			</div>
			<div class="order-info">
				<p>주문 정보</p>
				<table class="table table-borderless">

					<tr>
						<th>주문번호</th>
						<td>2020111900091</td>
					</tr>
					<tr>
						<th>주문일자</th>
						<td>2020-11-19</td>
					</tr>
					<tr>
						<th>주문자</th>
						<td>김홍시</td>
				</table>
			</div>
			<div class="order-payment">
				<p>결제 금액</p>
				<table class="table table-borderless">

					<tr>
						<th>주문금액</th>
						<td>50,000원</td>
					</tr>
					<tr>
						<th>포인트결제액</th>
						<td>0원</td>
					</tr>
					<tr>
						<th>결제금액</th>
						<td>48,000원</td>
					</tr>
				</table>
			</div>
			<div class="order-address">
				<p>배송지 정보</p>
				<table class="table table-borderless">

					<tr>
						<th>받는사람</th>
						<td>김홍도</td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td>472810</td>
					<tr>
						<th>주소</th>
						<td>수락산 언저리 두번째 산골 뒤에 있는 굴뚝이 있는집</td>
					</tr>
					<tr>
						<th>휴대전화</th>
						<td>010-8895-5965</td>
					</tr>
					<tr>
						<th>배송메시지</th>
						<td>바둑이네 집 옆, 보관함에 두고가세요.</td>
					</tr>
				</table>
			</div>

			<div class="btn-box">
				<button type="button" class="btn btn-outline-success" onclick="location.replace('${path}/mypage/orderStatus')">목록으로</button>
			</div>
		</div>
	</div>

</section>
<script>
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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

/* 주문내역 */
.status {
	background-color: #e9ecef;
	height: 90px;
}

.status2 {
	background-color: #e9ecef;
	height: 40px;
}

.status>ul, .status2>ul {
	text-align: center;
	vertical-align: middle;
}

.status2 li {
	list-style-type: none;
	float: left;
	margin: 10px 10px 0 0;
	width: 23%;
}

.status li {
	list-style-type: none;
	float: left;
	margin-top: 19px;
	width: 19%;
}

.status>ul>li>p {
	float: right;
	font-size: 35px;
}

.status>ul>li label {
	display: block;
	font-weight: bolder;
	font-size: 20px;
}
/* 주문 상품정보 */
.order-info {
	margin-top: 30px;
}
/* 테이블 */
.table th, .table td {
	text-align: center;
	vertical-align: middle;
}

.table .th {
	vertical-align: middle;
}
/* 페이지 번호 들어갈 곳 */
.pagebar{
	text-align: center;
}
/*모달창  */
.btnBox{
	text-align:center;
}
/*글자 말줄임  */
.textLine {
  vertical-align: middle;
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 170px;
  height: 63px;
}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp" />
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container">
			<h3>주문내역</h3>
			<div class="status">
				<ul>

					<li><span class="status-order">주문대기</span>
						<p>></p> <label class="order-qty"><c:out
								value="${ordWait }" /></label></li>
					<li><span class="status-order">주문완료</span>
						<p>></p> <label class="order-qty"><c:out
								value="${ordEnd }" /></label></li>
					<li><span class="status-order">배송준비</span>
						<p>></p> <label class="order-qty"><c:out
								value="${shipReady }" /></label></li>
					<li><span class="status-order">배송중</span>
						<p>></p> <label class="order-qty"><c:out
								value="${shipping }" /></label></li>
					<li><span class="status-order">배송완료</span> <label
						class="order-qty"><c:out value="${shipEnd }" /></label></li>
				</ul>
			</div>
			<div class="status2">
				<ul>
					<li><span class="status-order">주문취소: </span><label
						class="order-qty"><c:out value="${ordCancel }" /></label></li>
					<li><span class="status-order">취소완료: </span><label
						class="order-qty"><c:out value="${cancelEnd }" /></label></li>
					<li><span class="status-order">반품요청: </span><label
						class="order-qty"><c:out value="${returnWait }" /></label></li>
					<li><span class="status-order">반품완료: </span><label
						class="order-qty"><c:out value="${returnEnd }" /></label></li>
				</ul>
			</div>

			<div class="order-info">
				<h4>주문 상품 정보</h4>
				<br>
				<table class="table">
					<thead>
						<tr>
							<th class="th">주문일자<br>[주문번호]
							</th>
							<th class="th" >이미지</th>
							<th class="th" style="width:170px">상품명</th>
							<th class="th">옵션</th>
							<th class="th" >수량</th>
							<th class="th">상품금액</th>
							<th class="th">주문상태</th>
							<th></th>
						</tr>
					</thead>
					<tbody>

						<c:forEach items="${list}" var="o">
							<tr>
								<td class="ordTd"><fmt:formatDate type="date" 
										 value="${o.ordDate}" /> <br>
								<a name="orderNo"
									href="${path }/mypage/orderDetail?orderNo=${o.orderNo}"> [<c:out
											value="${o.orderNo }" />]
								</a></td>
								<c:forTokens items="${o.pdtThumbImage}" var="th" delims=","
									varStatus="vs">
									<c:if test="${vs.first }">
										<td><img alt="" class="img-fluid" id="main_image"
											style="height: 40px"
											src="${path}/resources/upload/product/${th}" /></td>
									</c:if>
								</c:forTokens>

								<td class="textLine"><a name="pdtNo" 
									href="${path }/product/productOne?pdtNo=${o.pdtNo}"><c:out
											value="${o.pdtName}" /></a></td>
								<td><c:out value="${o.pdtOptionContent}" /></td>
								<td><c:out value="${o.inorderQty}" /></td>
								<td><fmt:formatNumber pattern="#,###,###"
										value="${o.pdtPrice}" />원</td>
								<td class="statusTd"><c:out value="${o.ordStatus}" /></td>
								<td style="display: none"><c:out value="${o.orderNo}" /></td>
								<td style="display: none"><c:out value="${o.ordUsePoint}" /></td>
								<td style="display: none"><c:out value="${o.ordAmount}" /></td>
								<td style="display: none"><c:out value="${o.pdtNo}" /></td>
								<td style="display: none"><c:out value="${o.pdtName}" /></td>
								<c:if test="${o.ordCancel ==null }">
									<td class="btnTd"><c:if
											test="${o.ordStatus =='주문대기'or o.ordStatus=='주문완료'}">
											<button type="button"
												class="btn btn-outline-success cancelModal"
												data-toggle="modal" data-target="#cancelView">주문취소</button>
										</c:if> <c:if test="${o.ordConfirmYn =='N' }">
											<c:if test="${o.ordStatus =='배송준비'or o.ordStatus=='배송중'or o.ordStatus=='배송완료'}">
												<button type="button"
													class="btn btn-outline-success confirmModal"
													data-toggle="modal" data-target="#confirmView">구매확정</button>
												<button type="button"
													class="btn btn-outline-success returnModal"
													data-toggle="modal" data-target="#returnView">반품요청</button>
											</c:if>
										</c:if> <c:if test="${o.ordConfirmYn =='Y' }">
											<input type="button" class="btn btn-success pointEndBtn"
												disabled value="적립완료">
										</c:if></td>
								</c:if>
								<c:if test="${o.ordCancel !=null }">
								<td class="btnTd">
								</td>
								</c:if>
							</tr>

						</c:forEach>

					</tbody>
				</table>
				<div class="pagebar">${pageBar }</div>
				<div id="order-notice"></div>
			</div>
		</div>
	</div>
</section>
	<!--취소 사유 모달창  -->
	<div class="modal fade" id="cancelView" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">취소 사유</h5>
					<button type="button" class="close" data-dismiss="modal">X</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body container">
					<!--환불사유 선택  -->
					<div class="form-group">
						<div class="form-check">
							<label class="form-check-label">
							<input class="form-check-input" type="radio" name="reason" value="단순변심">단순변심
							</label><br> 
							<label class="form-check-label">
							<input class="form-check-input" type="radio" name="reason" value="배송지연">배송지연
							</label><br> 

						</div>
					</div>


					<div class="btnBox">
						<input type="hidden" class="cancelNo" readonly> <input
							type="hidden" class="cancelPoint" readonly> <input
							type="button" class="btn btn-outline-success btn-sm cancelBtn "
							value="주문취소"><br>
					</div>

				</div>

			</div>
		</div>
	</div>
	<!--반품 사유 모달창  -->
	<div class="modal fade" id="returnView" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">반품 사유</h5>
					<button type="button" class="close" data-dismiss="modal">X</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body container">
					<!--환불사유 선택  -->
					<div class="form-group">
						<div class="form-check">
							<label class="form-check-label"><input
								class="form-check-input" type="radio" name="reason" value="단순변심">단순변심
							</label><br> <label class="form-check-label"><input
								class="form-check-input" type="radio" name="reason" value="상품불량">상품불량</label><br>
							<label class="form-check-label"><input
								class="form-check-input" type="radio" name="reason" value="배송지연">배송지연
							</label><br> <label class="form-check-label"><input
								class="form-check-input" type="radio" name="reason"
								value="상품정보와 상이">상품정보와 상이</label>
						</div>
					</div>
				<!-- Modal footer -->
					<div class="modal-footer">
						<p style="font-size: 11px">-반품은 상품 수령일로부터 7일 이내에 가능합니다.</br>
						-반품시 제품의 상태는 배송 받으신 처음의 상태로 보존되어야 합니다.
						</p>
						
						
					</div>


					<div class="btnBox">
						<input type="hidden" class="returnNo" readonly> <input
							type="hidden" class="returnPoint" readonly> <input
							type="button" class="btn btn-outline-success btn-sm returnBtn "
							value="반품요청"><br>
					</div>

				</div>

			</div>
		</div>
	</div>
	<!--구매확정 모달창  -->
	<div class="modal fade" id="confirmView" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h5 class="modal-title">구매확정 진행</h5>
					<button type="button" class="close" data-dismiss="modal">X</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body container">
					<!--구매확정 안내문 -->
					<div class="form-group">
						<p>
							구매확정 이후에는 반품/교환이 불가하므로 <b>반드시 상품을 확인 후 구매확정을 진행해주세요.</b>
						</p>
						</br>
						<p>상품을 배송받지 않은 상태에서 구매확정을 하신 경우 상품 미수령에 대한 책임은 구매자에게 있습니다.</p>
					</div>


					<div class="btnBox">
						<input type="hidden" class="confirmNo" readonly> <input
							type="hidden" class="confirmAmount" readonly> <input
							type="button" class="btn btn-outline-success btn-sm confirmBtn "
							value="구매확정"><br>
					</div>

				</div>

			</div>
		</div>
	</div>


<script>
	//구매확정 모달창으로 
	$(".confirmModal").click(function() {
		let td = $(this).parent().parent().children();
		let orderNo = td.eq(7).text();
		let ordAmount = td.eq(9).text();
		$(".confirmNo").val(orderNo);
		$(".confirmAmount").val(ordAmount);

	})
	//주문취소 모달창으로 
	$(".cancelModal").click(function() {
		let td = $(this).parent().parent().children();
		let orderNo = td.eq(7).text();
		let ordUsePoint = td.eq(8).text();
		$(".cancelPoint").val(ordUsePoint);
		$(".cancelNo").val(orderNo);
	})

	//환불요청 모달창으로 값 보내기
	$(".returnModal").click(function() {
		let td = $(this).parent().parent().children();
		let orderNo = td.eq(7).text();
		let ordUsePoint = td.eq(8).text();
		$(".returnPoint").val(ordUsePoint);
		$(".returnNo").val(orderNo);
	})

	//반품요청 
	$(".returnBtn").click(
			function() {
				let cancel = $('input[name=reason]:checked').val();
				let orderNo = $(this).parent().children(".returnNo").val();
				let ordUsePoint = $(this).parent().children(".returnPoint")
						.val();
				console.log(ordUsePoint);
				if (cancel != null) {
					location.replace("${path}/mypage/returnRequest?cancel="
							+ cancel + "&orderNo=" + orderNo + "&ordUsePoint="
							+ ordUsePoint);
				}
			})

	//구매확정 
	$(".confirmBtn").click(
			function() {
				let orderNo = $(this).parent().children(".confirmNo").val();
				let ordAmount = $(this).parent().children(".confirmAmount")
						.val();
				location.replace("${path}/mypage/buyConfirm?ordAmount="
						+ ordAmount + "&orderNo=" + orderNo);
				$(".confirmModal").attr('type', 'hidden');

			})
			
	//주문취소
	$(".cancelBtn").click(
			function() {
				let cancel = $('input[name=reason]:checked').val();
				let orderNo = $(this).parent().children(".cancelNo").val();
				let ordUsePoint = $(this).parent().children(".cancelPoint")
						.val();
				console.log(ordUsePoint);
				if (cancel != null) {
					location.replace("${path}/mypage/orderCancel?cancel="
							+ cancel + "&orderNo=" + orderNo + "&ordUsePoint="
							+ ordUsePoint);
				}
			})		

	//같은값 데이터가 있을 경우 셀 병합하기 
	$(function() {

		$(".ordTd").each(function() {
			let rows = $(".ordTd:contains('" + $(this).text() + "')");
			let statusTd = rows.siblings(".statusTd");
			let btnTd = rows.siblings(".btnTd");
			if (rows.length > 1) {
				rows.eq(0).attr("rowspan", rows.length);
				statusTd.eq(0).attr("rowspan", statusTd.length);
				btnTd.eq(0).attr("rowspan", btnTd.length);

				rows.not(":eq(0)").remove();
				statusTd.not(":eq(0)").remove();
				btnTd.not(":eq(0)").remove();
			}
		});

		//주문대기일때 
		if ($(".statusTd").text().match("주문대기")) {
			$(".confirmModal").attr('type', 'hidden');
		}

		//주문취소 눌렀을때 주문취소 버튼 숨기기
		if ($(".statusTd").text().match("주문취소")) {
			$(".cancelModal").attr('type', 'hidden');

		}
		//구매확정 버튼 보이기
		if ($(".statusTd").text().match("배송준비")
				|| $(".statusTd").text().match("배송중")
				|| $(".statusTd").text().match("배송완료")) {
			$(".pointEndBtn").attr('type', 'button');
			$(".cancelModal").attr('type', 'hidden');

		}
		//리뷰버튼 보이기 
		if ($(".statusTd").text().match("배송완료")) {
			$(".cancelModal").attr('type', 'hidden');
		}
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
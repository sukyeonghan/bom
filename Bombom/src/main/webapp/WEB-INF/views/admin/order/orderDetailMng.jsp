<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" " />
</jsp:include>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
/*기본 화면 설정  */
#flexDiv {
	display: flex;
	margin: 0px 10% 0px 10%;
}
/*출력 화면 설정  */
#admin-container {
	min-width: 800px;
	width: 100%;
	padding-right: 100px;
}
/*좌측메뉴*/
#mypage-nav {
	padding-right: 100px;
}

#mypage-nav a {
	color: black;
	font-weight: bolder;
}

#mypage-nav a:hover {
	color: #45A663;
}

/* 주문 상품정보 */
.order-info {
	margin-top: 30px;
}
/* 테이블 */
/* 주문상품정보 정렬 */
.order-item .table th, .order-item .table td {
	text-align: center;
	vertical-align: middle;
}

.order-info-person .table th, .order-payment .table th, .order-address .table th
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
/* 주소 */
#sample4_detailAddress {
	margin-top: 5px;
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
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp" />
		<!-- 화면내용입력부분 -->
		<div id="admin-container">
			<form action="${path }/admin/order/updateOrder" method="post">
				<h3>주문 상세내역</h3>
				<br />
				<div class="order-item">
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
									<td><fmt:formatNumber pattern="#,###"
											value="${p.pdtPrice}" />원</td>
									<td><fmt:formatNumber pattern="#,###"
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
					<p>주문 및 결제정보</p>

					<table class="table table-borderless">

						<tr>
							<th>주문번호</th>
							<td><input type="text" name="orderNo" readonly value="${order.orderNo}" /></td>
							<th>운송장번호</th>
							<td><input type="text" name="ordTrack" value="${order.ordTrack}"></td>
						</tr>

						<tr>
							<th>주문날짜</th>
							<td><fmt:formatDate type="both" dateStyle="full"
									value="${order.ordDate}" /></td>
							<th>처리상태</th>
							<td><select id="category" name="ordStatus">
									<option value="주문대기"
										${order.ordStatus eq "주문대기"? "selected":"" }>주문대기</option>
									<option value="주문완료"
										${order.ordStatus eq "주문완료"? "selected":"" }>주문완료</option>
									<option value="주문취소"
										${order.ordStatus eq "주문취소"? "selected":"" }>주문취소</option>
									<option value="배송준비"
										${order.ordStatus eq "배송준비"? "selected":"" }>배송준비</option>
									<option value="배송중" 
										${order.ordStatus eq "배송중"? "selected":"" }>배송중</option>
									<option value="배송완료"
										${order.ordStatus eq "배송완료"? "selected":"" }>배송완료</option>
									<option value="취소완료"
										${order.ordStatus eq "취소완료"? "selected":"" }>취소완료</option>
							</select></td>
						</tr>
						<tr>
							<th>주문금액</th>
							<td id="total2"></td>
						</tr>
						<tr>
							<th>포인트결제액</th>
							<td>(-)<fmt:formatNumber pattern="#,###,###"
									value="${order.ordUsePoint}" />P
							</td>
						</tr>
						<tr>
							<th>결제금액</th>
							<td><b><fmt:formatNumber pattern="#,###,###"
										value="${order.ordAmount }" />원</b></td>
						</tr>

					</table>
				</div>

				<div class="order-info-person">
					<p>주문자 정보</p>
					<table class="table table-borderless">
						<tr>
							<th>주문자</th>
							<td><c:out value="${order.ordOname }" /></td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td><c:out value="${order.ordOphone }" /></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><c:out value="${order.memEmail }" /></td>
						</tr>

					</table>
				</div>

				<div class="order-address">
					<p>수취인 정보</p>
					<table class="table table-borderless">
						<tr>
							<th>받는사람</th>
							<td><c:out value="${order.ordRname }" /></td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td><c:out value="${order.ordRphone }" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td class="td-address">
							<input type="text"
								id="sample4_postcode" placeholder="우편번호" name="ordZipcode"
								value="${order.ordZipcode }" readonly> 
							<input
								type="button" onclick="sample4_execDaumPostcode()" 
								style="margin-bottom: 6px;" value="주소검색"><br>
						    <input
								type="text" id="sample4_roadAddress" placeholder="도로명주소" name="ordAddr
								value="${order.ordAddr }" readonly required size=50><br>
							<input type="hidden" id="sample4_jibunAddress" 
								placeholder="지번주소"> <span id="guide"
								style="color: #999; display: none"></span> 
							<input type="text"
								id="sample4_detailAddress" placeholder="상세주소 입력" name="ordDetailAddr"
								value="${order.ordDetailAddr }" size=50> 
							<input
								type="text" id="sample4_extraAddress" placeholder="참고항목" size=30 name="ordExtraAddr"></td>
						</tr>
						<tr>
							<th>요청사항</th>
							<td><c:out value="${order.ordMemo }" /></td>
						</tr>
						<c:if test="${not empty order.ordCancel }">
							<tr>
								<th>주문취소 사유</th>
								<td><c:out value="${order.ordCancel }" /></td>
							</tr>
						</c:if>
						<tr>
							<th>관리자메모</th>
							<td><div class="form-group">
									<textarea class="form-control" rows="3" id="contents" name="ordMngMemo"
										placeholder="남기실 메모를 작성해주세요.">${order.ordMngMemo }</textarea>
								</div></td>
						</tr>
					</table>
				</div>

				<div class="btn-box">
					<button type="button" class="btn btn-outline-secondary"
						onclick="location.replace('${path}/admin/order')">목록으로</button>
					<button type="submit" class="btn btn-success">수정/확인</button>
				</div>
			</form>
		</div>
	</div>
</section>
<script>
	//주문금액 다시 결제정보에 다시 쏴주기 
	$("#total2").text($("#total").text())
		
	
	
	//주소찾기 우편번호
	function sample4_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var roadAddr = data.roadAddress; // 도로명 주소 변수
						var extraRoadAddr = ''; // 참고 항목 변수

						// 법정동명이 있을 경우 추가한다. (법정리는 제외)
						// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
						if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// 건물명이 있고, 공동주택일 경우 추가한다.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample4_postcode').value = data.zonecode;
						document.getElementById("sample4_roadAddress").value = roadAddr;
						document.getElementById("sample4_jibunAddress").value = data.jibunAddress;

						// 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
						if (roadAddr !== '') {
							document.getElementById("sample4_extraAddress").value = extraRoadAddr;
						} else {
							document.getElementById("sample4_extraAddress").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(예상 도로명 주소 : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'block';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(예상 지번 주소 : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'block';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
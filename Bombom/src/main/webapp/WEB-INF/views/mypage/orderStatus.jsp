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

/* 주문내역 */
.status {
	background-color: #e9ecef;
	height: 100px;
}

.status>ul {
	text-align: center;
}

.status li {
	list-style-type: none;
	float: left;
	margin-top: 19px;
	width: 16%;
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
#page-bar {
	text-align: center;
	margin-top: 30px;
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
						<p>></p> <label class="order-qty">0</label></li>
					<li><span class="status-order">주문완료</span>
						<p>></p> <label class="order-qty">0</label></li>
					<li><span class="status-order">배송준비</span>
						<p>></p> <label class="order-qty"><c:out value="${shipReady }" /></label></li>
					<li><span class="status-order">배송중</span>
						<p>></p> <label class="order-qty">0</label></li>
					<li><span class="status-order">배송완료</span>
						<p>></p> <label class="order-qty">0</label></li>
					<li><span class="status-order">구매확정</span> <label
						class="order-qty">0</label></li>
				</ul>
			</div>
			<div class="order-info">
				<h4>주문 상품 정보</h4>
				<br>
				<table class="table">
					<thead>
						<tr>
							<th>주문일자<br>[주문번호]
							</th>
							<th class="th">이미지</th>
							<th class="th">상품정보</th>
							<th class="th">수량</th>
							<th class="th">상품금액</th>
							<th class="th">주문상태</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="o">
							<tr>
								<td class="ordTd"><fmt:formatDate type="date" dateStyle="short" value="${o.ordDate}" />
									<br><a name="orderNo" href="${path }/mypage/orderDetail?orderNo=${o.orderNo}">
									[<c:out value="${o.orderNo }" />]</a>
								</td>
								<c:forTokens items="${o.pdtThumbImage}" var="th" delims=","
									varStatus="vs">
									<c:if test="${vs.first }">
										<td><img alt="" class="img-fluid" id="main_image"
											style="height: 40px"
											src="${path}/resources/upload/product/${th}" /></td>
									</c:if>
								</c:forTokens>
								
								<td><a name="pdtNo"
									href="${path }/product/productOne?pdtNo=${o.pdtNo}"><c:out
											value="${o.pdtName}" /></a></td>
								<td><c:out value="${o.inorderQty}" /></td>
								<td><c:out value="${o.pdtPrice}" /></td>
								<td class="statusTd"><c:out value="${o.ordStatus}" /></td>
								<td class="btnTd">
								<button type="button" class="btn btn-outline-success" data-toggle="modal" data-target="#cancelView">주문취소</button>
								<input type="hidden" class="btn btn-outline-success" value="구매확정">
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div id="page-bar">${pageBar }</div>
				<div id="order-notice">• 주문상태에 따른 버튼 변경 -주문취소(주문대기/주문완료), 배송
					준비중이면 주문 취소 불가함 - 고객센터에 문의하세요 -구매확정(배송준비/배송중/배송완료) -리뷰작성(배송완료 시
					리뷰작성 버튼으로 바꾸기)</div>
			</div>
		</div>
	</div>
		<!--주문취소 사유 모달창  -->
		  <div class="modal fade" id="cancelView" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		    <div class="modal-dialog modal-sm modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title">주문 취소 사유</h5>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
          <!-- Modal body -->
	        <div class="modal-body container">
            <!--문의내용  -->
           		 <div class="form-group">
				      <div class="form-check">
				        <label class="form-check-label"><input class="form-check-input" type="checkbox" value="고객변심" >고객변심 </label><br>
				        <label class="form-check-label"><input class="form-check-input" type="checkbox" value="상품불량" >상품불량</label><br>
				        <label class="form-check-label"><input class="form-check-input" type="checkbox" value="배송지연" >배송지연 </label><br>
				        <label class="form-check-label"><input class="form-check-input" type="checkbox" value="상품불량 상이" >상품불량 상이</label>
				      </div>
            	</div>


	        		<div class="btnBox">
	        		   	<input type="hidden" class="" name="" readonly>
	        			<input type="button" class="btn btn-outline-success btn-sm cancelBtn " data-confirm="주문을 취소하시겠습니까?" value="완료"><br>	        			
	        		

					</div>
	        	 
		    </div>
	      	  
	      	  </div>
			</div>
		</div>
</section>
<script>
/* 	$(document).ready(function(e) {
		genRowspan(".ordTd");
	
	});

	function genRowspan(ordTd) {
		$("." + "ordTd").each(
				function() {
					let rows = $("." + "ordTd" + ":contains('" + $(this).text()
							+ "')");
					if (rows.length > 1) {
						rows.eq(0).attr("rowspan", rows.length);
						rows.not(":eq(0)").remove();
					}
				});
	} */
	
//같은값 데이터가 있을 경우 셀 병합하기 
	 $(function(){
		$(".ordTd").each(function(){
			let rows = $(".ordTd:contains('" + $(this).text()+ "')");
			let statusTd=rows.siblings(".statusTd");
			let btnTd=rows.siblings(".btnTd");
			if (rows.length > 1) {
				rows.eq(0).attr("rowspan", rows.length);
				statusTd.eq(0).attr("rowspan", statusTd.length);
				btnTd.eq(0).attr("rowspan", btnTd.length);
				
				rows.not(":eq(0)").remove();
				statusTd.not(":eq(0)").remove();
				btnTd.not(":eq(0)").remove();
			}
		});
	});



</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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

#uploadImage1:hover{
	cursor:pointer;
}
#uploadImage2:hover{
	cursor:pointer;
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
/* 별점 css */
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
							<th></th>

						</tr>
					</thead>
					<tbody>
						<c:set var="total" value="0" />
						<c:forEach items="${product}" var="p" varStatus="vs">
						
							<tr>
								<c:forTokens items="${p.pdtThumbImage}" var="th" delims=","
									varStatus="vs">
									<c:if test="${vs.first }">

										<td class="imgTd"><img alt="" class="img-fluid" id="main_image"
											style="height: 40px"
											src="${path}/resources/upload/product/${th}" /></td>
									</c:if>
								</c:forTokens>
								<td class="pdtTd"><c:out value="${p.pdtName}" /></td>
								<td><c:out value="${p.pdtOptionContent}" /></td>
								<td><c:out value="${p.inorderQty}" /></td>
								<td><fmt:formatNumber pattern="#,###,###" value="${p.pdtPrice}" />원</td>
								<td><fmt:formatNumber pattern="#,###,###"
										value="${p.inorderQty * p.pdtPrice}" />원</td>
								<td ><c:out value="${p.pdtNo}" /></td>
								<c:if test="${not empty p.pdtOptionNo}">
								<td style="display:none"><c:out value="${p.pdtOptionNo}" /></td>
								</c:if>
								<c:if test="${empty p.pdtOptionNo}">
								<td style="display:none"><c:out value="null" /></td>
								</c:if>
								<c:if test="${p.ordStatus =='배송준비' or p.ordStatus =='배송중' or p.ordStatus =='배송완료' }">
								<c:if test="${ p.ordConfirmYn=='Y' && p.revYn=='N'}">					
								<td class="btnTd"><input type="button" class="btn btn-outline-success reviewModal" data-toggle="modal" data-target="#reviewView" value="리뷰작성"></td>
								</c:if> 
								
								<c:if test="${p.revYn=='Y'}">
								<td class="btnTd"><input type="button" class="btn btn-success" disabled  value="작성완료"></td>
								
								</c:if>
								</c:if>
								
							</tr>
							<c:set var="total" value="${p.inorderQty * p.pdtPrice + total}" />
						</c:forEach>
				
						<tr>
							<td colspan="5">총 합계</td>
							<td id="total"><b><fmt:formatNumber pattern="#,###,###"
										value="${total }" />원</b></td>
							<td></td>
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
						<td id="total2">원</td>
					</tr>
					<tr>
						<th>배송료</th>
						<td><fmt:formatNumber pattern="#,###"
								value="${order.ordDeliPrice}" />원</td>
					</tr>
					<tr>
						<th>적립금사용</th>
						<td><fmt:formatNumber pattern="#,###,###"
								value="${order.ordUsePoint}" />봄</td>
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
<!--flexDiv  -->

<!--구매평 쓰기  -->
		<div class="modal fade" id="reviewView" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title title"></h5>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
          <!-- Modal body -->
	        <div class="modal-body container">
            <!--구매내용  -->
           		 <div class="form-group">
			        <!--구매평 작성창-->
			        <form name="frm_review" action="${path}/review/insertReview" method="post" enctype="multipart/form-data" onsubmit="return fn_reviewCheck()" >
				        <div class="writebox_wrap container" style="float:none; margin:10px 0 10px 0;">
					        <div>
						        <span class="span_textarea review_span">
							        <textarea name="revContent" id="review_textarea" placeholder="구매평을 입력해주세요" onKeyUp="javascript:fnChkByte2(this,'500')"></textarea>
							        <div class="imgPreview" style="height:35%;"></div>
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
								        	<input type="hidden" name="pdtNo" class="pdtNo-review">
								        	<input type="hidden" name="memNo" value="${loginMember.memNo}">
								        	<input type="hidden" name="revScore">
								        	<input type="hidden" name="orderNo" value="${order.orderNo}">
								        	<input type="hidden" name="pdtOptionNo" class="pdtOpNo-review" >
								        	<input type="submit" class="btn btn-success reviewEnd" value="등록" style="right:0;">
								        </c:if>
									
						        	</div>
						        	</div>
						        </span>
					        </div>
				        </div>
			        </form><!-- 구매평 작성창 끝 -->
            	</div>
	        	 
		    </div>
	      	  
	      	  </div>
			</div>
		</div>

</section>
<script>
//리뷰쓰기 모달창으로 값 보내기
$(".reviewModal").click(function(){
	let td=$(this).parent().parent().children();
	let pdtName=td.eq(1).text();
	let opName=td.eq(2).text();
	let pdtNo=td.eq(6).text();
	let pdtOpNo=td.eq(7).text();
	console.log(pdtNo);
	$(".pdtNo-review").val(pdtNo);
	$(".pdtOpNo-review").val(pdtOpNo);
	$(".title").text(pdtName+" 제품 구매평");
	
})



//주문금액 다시 결제정보에 다시 쏴주기 
$("#total2").text($("#total").text());

//같은값 데이터가 있을 경우 셀 병합하기 
/* $(function(){
	
	$(".pdtTd").each(function(){
		let rows = $(".pdtTd:contains('" + $(this).text()+ "')");
		console.log(rows);
		//let btnTd=rows.siblings(".btnTd");
		let imgTd=rows.siblings(".imgTd");
		if (rows.length > 1) {
			rows.eq(0).attr("rowspan", rows.length);
	
			imgTd.eq(0).attr("rowspan", imgTd.length);
			
			rows.not(":eq(0)").remove();
		
			imgTd.not(":eq(0)").remove();
		}
	})
}); */

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
    swal("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.");
    str2 = str.substr(0, rlen); //문자열 자르기
    obj.value = str2;
    fnChkByte2(obj, maxByte);
  }else{
    document.getElementById("byteInfo2").innerText = rbyte;
  }
} 

//구매평 - 별점 마킹 모듈 프로토타입으로 생성
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
			let img = $("<img>").attr({"src":e.target.result,"style":"width:auto;height:60px;"});
			
			$(".imgPreview").html("");
			$(".imgPreview").append(img);
		}
		reader.readAsDataURL($(e.target)[0].files[0]);
});	

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
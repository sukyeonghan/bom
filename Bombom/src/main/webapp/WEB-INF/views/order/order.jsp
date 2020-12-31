<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="${path }/resources/js/order.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp" >
	<jsp:param name="title" value="결제하기" />
</jsp:include>

<!-- 금액계산해주기 -->
<c:set var="totalPdtPrice" value="0" />
<c:set var="totalSale" value="0"/>
<c:set var="totalPrice" value="0"/>
<c:forEach items="${blist}" var="l">
	<c:set var="totalPdtPrice" value="${totalPdtPrice+ (l.inbasQty * l.pdtPrice)}"/>
	<c:if test="${l.salePer != 0 }">
		<c:set var="totalSale" value="${totalSale+((l.pdtPrice * l.salePer/100))}"/>
	</c:if>
	<c:set var="totalPrice" value="${totalPrice + (l.inbasQty * (l.pdtPrice - (l.pdtPrice * l.salePer/100)))}" />

	<c:set var="basketNo" value="${l.basketNo }"/>
</c:forEach>







<section id="container" class="container">
    <div class="order_header">
        <h1>결제하기</h1>
    </div>
   <div style="width: 760px;margin: 40px auto 0;">
   
    <form name="orderInfo" action="${path }/order/insertOrder?basketNo=${basketNo}" method="post">
    
    <!-- 주문상품 -->
    <div class="mb-5">
        <h3>주문상품</h3>
        <table>
        	<thead>
				<tr>
					<th style="width: 20%;"></th>
					<th style="width: 40%;"></th>
					<th style="width: 20%;"></th>
					<th style="width: 20%;"></th>
				</tr>
			</thead>
	        <c:forEach items="${blist }" var="b">
            <tr>
            	<!-- 상품사진 -->
                <td>
					<div class="show_pdt-wrap">
						<a href="${path }/product/productOne?pdtNo=${b.pdtNo}" class="d-flex">
						<!-- 제품썸네일 -->
						<c:forTokens items="${b.pdtThumbImage}" var="th" delims="," varStatus="vs">
							<c:if test="${vs.first }">
								<img src="${path}/resources/upload/product/${th}"
									class="img-fluid" style="width:80px; height: 80px;">
							</c:if>
						</c:forTokens>
					</div>
                </td>
                <!-- 이름 -->
                <td><c:out value="${b.pdtName }" /></td>
                <!-- 가격 -->
                <td><fmt:formatNumber pattern="#,###,###" value="${b.pdtPrice }"/>원</td>
                <!-- 수량 -->
                <td> <c:out value="${b.inbasQty }" />개 </td>
            </tr>
	        </c:forEach><hr>
        </table>
    </div>
    <!-- 배송지 -->
    <div class="mb-5">
        <h3>배송지</h3>
        <hr>
    <c:if test="${not empty ship}">
        <div class="form-group d-flex mb-3">
            <div class="col-3"><span>받는분</span></div>
            <div class="col-9"><input type="text" name="ordOname" value="${ship.shipRecipient }"  class="orderer form-control"></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><label for="sample6_postcode" class=" mr-3">우편번호</label></div>
            <div class="col-9 d-flex"><input type="text" id='sample6_postcode' name='ordZipcode' value="${ship.shipZipCode }" class="zipCode address-detail form-control" style="width: 150px;"  placeholder='우편번호' readonly >
            <input type="button" onclick='sample6_execDaumPostcode()' class="changeAddr btn btn-success" value="주소찾기" >
            <input type="button" onclick='' class="btn btn-success" value="배송지변경" ></div>
        </div>
        <div class="form-group d-flex mb-3">
            <div class="col-3 d-flex"><label for="addr">주소</label></div>
            <div class="col-9 "><input type="text" class="address-detail form-control" name="ordAddr" id='sample6_address' value="${ship.shipAddress }" placeholder='주소' required><br>
            <input type="text" class="address-detail form-control" name='ordDetailAddr' id='sample6_detailAddress' value="${ship.shipDetailAddress }" placeholder='상세주소' required>
        	</div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><label for="deli_memo">배송 메모</label></div>
            <div class="col-9">
            <select name="ordMemo" id="deli_memo" class="form-control mb-3" required>
                <option selected disabled>배송시 요청사항</option>
                <option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
                <option value="배송 전,연락주세요.">배송 전,연락주세요.</option>
                <option value="부재 시,휴대폰으로 연락주세요.">부재 시,휴대폰으로 연락주세요.</option>
                <option value="부재 시,경비실에 맡겨주세요.">부재 시,경비실에 맡겨주세요.</option>
                <option value="경비실이 없습니다.배송 전 연락주세요.">경비실이 없습니다.배송 전,연락주세요.</option>
                <option value="배송 전,연락주세요.">배송 전,연락주세요.</option>
                <option value="직접입력">직접입력</option>
            </select>
            <div id="direct_input"></div></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><label for="phone">휴대전화</label></div>
            <div class="col-9"><input type="tel" name="ordOphone" id="phone" value="${ship.shipPhone }" class="ordererPhone form-control" required></div>
        </div>
    </c:if>
    <c:if test="${empty ship }">
    	<div class="form-group d-flex mb-3">
            <div class="col-3"><span>받는분</span></div>
            <div class="col-9"><input type="text" name="ordOname" class="orderer form-control"></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><label for="sample6_postcode" class=" mr-3">우편번호</label></div>
            <div class="col-9 d-flex"><input type="text" id='sample6_postcode' name='ordZipcode' class="zipCode address-detail form-control" style="width: 150px;"  placeholder='우편번호' readonly >
            <input type="button" onclick='sample6_execDaumPostcode()' class="changeAddr btn btn-success" value="주소찾기" >
            <input type="button" onclick='' class="btn btn-success" value="배송지변경" ></div>
        </div>
        <div class="form-group d-flex mb-3">
            <div class="col-3 d-flex"><label for="addr">주소</label></div>
            <div class="col-9 "><input type="text" class="address-detail form-control" name="ordAddr" id='sample6_address' placeholder='주소' required><br>
            <input type="text" class="address-detail form-control" name='ordDetailAddr' id='sample6_detailAddress' placeholder='상세주소' required>
        	</div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><label for="deli_memo">배송 메모</label></div>
            <div class="col-9"><select name="ordMemo" id="deli_memo" class="form-control mb-3" required>
                <option selected disabled>배송시 요청사항</option>
                <option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
                <option value="배송 전,연락주세요.">배송 전,연락주세요.</option>
                <option value="부재 시,휴대폰으로 연락주세요.">부재 시,휴대폰으로 연락주세요.</option>
                <option value="부재 시,경비실에 맡겨주세요.">부재 시,경비실에 맡겨주세요.</option>
                <option value="경비실이 없습니다.배송 전 연락주세요.">경비실이 없습니다.배송 전,연락주세요.</option>
                <option value="배송 전,연락주세요.">배송 전,연락주세요.</option>
                <option value="직접입력">직접입력</option>
            </select>
            <div id="direct_input"></div></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><label for="phone">휴대전화</label></div>
            <div class="col-9"><input type="tel" name="ordOphone" id="phone" class="ordererPhone form-control" required></div>
        </div>
    </c:if>
    </div>
    <!-- 수취인 -->
    <div class="mb-5">
    	<c:if test="${not empty ship }">
    	<div class="d-flex">
        <h3 class="mr-5">주문자</h3> 
        <label class="form-label">
           	<input type="button" class="sameInfo btn btn-outline-info" value="배송지 정보와 동일하게 채우기">
        </label>
        </div>
        <hr>
        <div class="form-group d-flex">
            <div class="col-3"><span>이름</span></div>
            <div class="col-9"><input type="text" name="ordRname" id="orderer" value="${ship.shipRecipient }" class="form-control" required></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><span>이메일</span></div>
            <div class="col-9"><input type="email" name="ordRemail" id="ordererEmail" value="${loginMember.memEmail }" class="form-control"></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><span>휴대전화</span></div>
            <div class="col-9"><input type="text" name="ordRphone" id="ordererPhone" value="${ship.shipPhone }" class="form-control" required></div>
        </div>
        </c:if>
        <c:if test="${empty ship }">
        <div class="d-flex">
        <h3 class="mr-5">주문자</h3> 
        <label class="form-label">
           	<input type="button" class="sameInfo btn btn-outline-info" value="배송지 정보와 동일하게 채우기">
        </label>
        </div>
        <hr>
        <div class="form-group d-flex">
            <div class="col-3"><span>이름</span></div>
            <div class="col-9"><input type="text" name="ordRname" id="orderer" class="form-control" required></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><span>이메일</span></div>
            <div class="col-9"><input type="email" name="ordRemail" id="ordererEmail" class="form-control"></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><span>휴대전화</span></div>
            <div class="col-9"><input type="text" name="ordRphone" id="ordererPhone" class="form-control" required></div>
        </div>
        </c:if>
    </div>
    <!-- 적립금 -->
    <div class="form-group mb-5">
        <h3>적립금</h3>
        <hr>
        <div class="form-group d-flex">
	        <input type="text" name="" id="point" class="point form-control mr-3" style="width: 100px;" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'>
	        <label for="point">P</label>
        </div>
        <p>사용 가능한 포인트 <span class="savePoint"><fmt:formatNumber pattern="#,###,###" value="${loginMember.memPoint }"/>P</span></p>
        <label for="allPoint"><input type="checkbox" id="allPoint" class="form-check-input" >전액사용</label>

    </div>
    <!-- 예상적립금 -->
    <div class="form-group mb-5">
        <h3>예상적립금</h3>
        <hr>
        <p><strong><span class="savePoint mr-1">1P</span>적립예정</strong></p>

    </div>
    <!-- 최종 결제금액 -->
    <div class="form-group mb-5">
        <h3>최종 결제금액</h3>
        <hr>
        <div class="d-flex j-between"><h4>총 상품 금액</h4>
        	<p class="text-size-20"><span class="total-price ">100</span>원</p>
        </div>
        <div class="d-flex j-between"><h4>배송비</h4>
        	<p class="text-size-20"><span class="ba" id="ordDeliPrice">0</span>원</p>
        </div>
        <div class="d-flex j-between"><h4>적립금 사용</h4>
        	<p class="text-size-20"><span class="point" id="ordUsePoint">100</span>봄</p>
        </div>
        <div class="d-flex j-between"><h4></h4>
        	<p class="text-strong"><span class="total-pay" id="ordAmount">100</span>원</p>
        </div>
		<input type="hidden" id="ba" name="ba">
       	<input type="hidden" id="total" name="total-pay">
    </div>
    <!-- 결제버튼 -->
    <div class="mb-5" style="text-align: center;">
        <button id="payBtn" type="submit" class="payBtn btn btn-outline-success" style="width: 500px;">결제하기</button>
    </div>
    </form>
    </div>
</section>




<script>
	$(function(){
		$("#point").val(0)}
	);

	$(function () { //배송메모 직접입력 선택시 input태그 보이게 하기
	    //배송메모 직접입력 input
	    let addInput = $("<input>").attr({"type":"text", "name":"ordMemo", "id":"o_memo","class":"form-control"});
	    $("#deli_memo").change(e=> {
	        let memo = $("#deli_memo").val();
	        if (memo == '직접입력') {
	            $("#direct_input").append(addInput);//input태그 추가
	            //selectbox name속성 없애기
	           	$("#deli_memo").attr("name","");
	        }else{
	        	$("#direct_input").html("");//다른 배송메모 선택시 input태그 삭제
	        }
	    })
	});

	//배송지와 주문자 동일하게 채우기 버튼
    $(".sameInfo").click(e =>{
        let orderer = $(".orderer").val(); //이름
        let ordererEmail; //이메일
        let ordererPhone = $(".ordererPhone").val();//휴대전화
        $("#orderer").val(orderer);
        $("#ordererPhone").val(ordererPhone);
    });
	
	var allPoint = '<c:out value="${loginMember.memPoint }"/>'; //사용가능한 포인트
	var allPointPat = '<fmt:formatNumber pattern="#,###,###" value="${loginMember.memPoint }"/>';
	//사용 가능한 포인트 초과 입력시 alert
	
	$("#point").on("change",e =>{
		var inputPoint = $("#point").val(); //사용자가 입력한 포인트값가져오기
		if( Number(inputPoint) > Number(allPoint)){
			alert("사용 가능한 포인트 보다 많은 가격이 입력되었습니다.");
			alert("포인트를"+allPointPat+"원을 사용하고 0원 남았습니다.");
			$("#point").val(Number(allPoint));
		}
		//포인트 사용하면 총 금액에 정산되도록 만들기
		
		
		
	});
	
	//포인트 전액사용 체크박스 체크시 또는 해제시
	console.log(allPoint);
	$("#allPoint").change(e =>{
		if($("#allPoint").is(":checked")){
			alert("포인트를"+allPoint+"원을 사용하고 0원 남았습니다.");
			$("#point").val(Number(allPoint));
		}else{
			$("#point").val(0);
		}
	});

</script>

<style>
.order_header>h1 {
	height: 80px;
	margin: 50px 0;
}
.savePoint{
	font-weight: 800;
	color : #45A663;
}
input[type='number'], input[type='text'], input[type='password'], input[type='file'],
	input[type='tel'], input[type='email'], select, option, textarea, input[type='submit'],
	button {
	-webkit-appearance: none;
	-moz-appearance: textfield;
}
.text-size-20{
	font-size: 20px;
}
.j-between{
	justify-content: space-between;
}
.text-strong{
	font-weight: bold;
	font-size: 24px;
}
</style>

<!-- 배송지/결제 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">

//총 결제 금액 가져오기
var amount = $(".total-pay").text();
console.log(amount);
amount = amount.replace("원","");
console.log(amount);

//결제 API
$(document).on("click",".payBtn",function(){
 	
	if($(".address-detail")[0].value==""||$(".address-detail")[1].value==""||$(".address-detail")[2].value==""){
		//0번 우편번호  1번 일반 주소  2번 상세주소
		alert("주소를 입력해주세요");
		return;
	}
	
	IMP.init('imp93954987');
	IMP.request_pay({
	    pg : 'inicis', // version 1.1.0부터 지원.
	    pay_method : 'card',
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:카드결제',
	    amount : Number(amount),//여기엔 가격
	    buyer_email : $("#ordererEmail").value,
	    buyer_name : $("#orderer").value,
	    buyer_tel : $("#ordererPhone").value,
	    buyer_addr : $(".address-detail")[1].value+$(".address-detail")[2].value,
	    buyer_postcode : $(".zipCode").value,
	    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
	}	, function(rsp) { //callback
	    if ( rsp.success ) { //결제 성공시
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	        orderInfo.submit();
	    } else { //결제 실패시
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});

});

var ba;
//주소 api
function sample6_execDaumPostcode() {
  new daum.Postcode({
      oncomplete: function(data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ''; // 주소 변수
          var extraAddr = ''; // 참고항목 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
              addr = data.roadAddress;
          } else { // 사용자가 지번 주소를 선택했을 경우(J)
              addr = data.jibunAddress;
          }
          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById('sample6_postcode').value = data.zonecode;
          document.getElementById("sample6_address").value = addr;
          // 커서를 상세주소 필드로 이동한다.
          var address=$(".address-detail").val();
          
          if(address.includes("서울")||address.includes("경기")){
          	ba=2500;
          }else if(address.includes("제주")||address.includes("강원")){
          	ba=7000;
          }else{
          	ba=5000;
          }

          var mileage =Number($(".point").val()); //총 할인 금액가져오기
          $(".ba").html(ba.toLocaleString()); //배송비 가져오기
          $(".total-pay").html((parseInt($(".total-price")[0].textContent.replace(/,/g, ""))+ba-mileage)
        		  .toLocaleString());//상품총가격+배송비 최종가격
          $("#total").val((parseInt($(".total-price")[0].textContent.replace(/,/g, ""))+ba-mileage));
          $("#ba").val(ba);
          
          document.getElementById("sample6_detailAddress").focus(); 
      }
  }).open();
}

	
 	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
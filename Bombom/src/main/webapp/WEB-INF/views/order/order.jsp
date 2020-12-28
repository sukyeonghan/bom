<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<jsp:include page="/WEB-INF/views/common/header.jsp" >
	<jsp:param name="title" value="결제하기" />
</jsp:include>

<section id="container" class="container">
    <div class="order_header">
        <h1>결제하기</h1>
    </div>
   <div style="width: 760px;margin: 40px auto 0;">
    <form action="'${path }/order/insertOrder?bNo=${basketNo}" method="post">
    <!-- 주문상품 -->
    <div class="mb-5">
        <h3>주문상품</h3>
        <%-- <c:forEach items="${list }" var="b"> --%>
        <table>
            <tr>
                <td>
                	<div>
						<%-- <a href="${path }/product/productOne?pdtNo=${b.pdtNo}" class="d-flex"> 
							<c:forTokens items="${b.pdtThumbImage}" var="th" delims="," varStatus="vs">
								<c:if test="${vs.first }">
									<img src="${path}/resources/upload/product/${th}" class="img-fluid" style="width: 100px; height: 100px;">
								</c:if>
							</c:forTokens>
							<p class="pdtName_p"><c:out value="${b.pdtName }" /></p>
						</a> --%>
						<img src="${path }/resources/upload/product/det20201208_000348492_120.jpg" style="width: 100px; height: 100px;">
					</div>
                </td>
                <td>여기는 상품명</td>
                <td>100원</td>
                <td>1개</td>
            </tr>
        </table>
        <%-- </c:forEach> --%>
    </div>
    <!-- 배송지 -->
    <div class="mb-5">
        <h3>배송지</h3>
        <hr>
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
            <div class="col-9"><input type="text" name="ordOphone" id="phone" class="ordererPhone form-control" required></div>
        </div>
    </div>
    <!-- 수취인 -->
    <div class="mb-5">
    	<div class="d-flex">
        <h3 class="mr-5">주문자</h3> 
        <label class="form-check-label">
           	<input type="checkbox" class="sameInfo form-check-input">배송지 정보와 동일하게 채우기
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
    </div>
    <!-- 적립금 -->
    <div class="form-group mb-5">
        <h3>적립금</h3>
        <hr>
        <label for="point">3만원이상 결제시 포인트 사용이 가능합니다.</label><br>
        <div class="form-group d-flex"><input type="number" name="" id="point" class="form-control mr-3" style="width: 100px;"><label for="point">P</label></div>
        <p>사용 가능한 포인트 <span>1,236P</span></p>
        <label for="allPoint"><input type="checkbox" id="allPoint" class="form-check-input">전액사용</label>

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
        <div class="d-flex"><h5>총 상품 금액</h5><span class="total-price">100원</span></div>
        <div class="d-flex"><h5>배송비</h5><span class="deli"id="ordDeliPrice">0원</span></div>
        <div class="d-flex"><h5>적립금 사용</h5><span class="point" id="ordUsePoint">100봄</span></div>
        <div class="d-flex"><span class="total-pay" id="ordAmount"><strong>100원</strong></span></div>
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

	$(function(){$(".point").text(0)});

    $(function () { //배송메모 직접입력 선택시 input태그 보이게 하기
	    //배송메모 직접입력 input
        let addInput = $("<input>").attr({"type":"text", "name":"ordMemo", "id":"o_memo","class":"form-control"});
        $("#deli_memo").change(e=> {
            let memo = $("#deli_memo").val();
            if (memo == '직접입력') {
                $("#direct_input").append(addInput);//input태그 추가
	            //selectbox name속성 없애기
	           	$("#deli_memo").attr("name","");
            }
        })
    });
    
    $(".sameInfo").click(e =>{
    	
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
</style>

<!-- 배송지/결제 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">

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

	            var mileage =Number($(".point").html().replace(/,/g, "")); //총 할인 금액가져오기
	            $(".deli").html(ba.toLocaleString());
	            $(".total-pay").html((parseInt($(".total-price")[0].textContent.replace(/,/g, ""))+ba-mileage).toLocaleString());//상품총가격+배송비 최종가격
	            $("#total").val((parseInt($(".total-price")[0].textContent.replace(/,/g, ""))+ba-mileage));
	            $("#ba").val(ba);
	            
	            document.getElementById("sample6_detailAddress").focus(); 
	        }
	    }).open();
	}
	
	
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
			    amount : parseInt($(".")[0].textContent.replace(/,/g, "")),
			    buyer_email : $("#ordererEmail").value,
			    buyer_name : $("#orderer").value,
			    buyer_tel : $("#ordererPhone").value,
			    buyer_addr : $(".address-detail")[1].value+$(".address-detail")[2].value,
			    buyer_postcode : $(".zipCode").value,
			    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			}	, function(rsp) {
			    if ( rsp.success ) {
			        var msg = '결제가 완료되었습니다.';
			        msg += '고유ID : ' + rsp.imp_uid;
			        msg += '상점 거래ID : ' + rsp.merchant_uid;
			        msg += '결제 금액 : ' + rsp.paid_amount;
			        msg += '카드 승인번호 : ' + rsp.apply_num;
			        orderInfo.submit();
			    } else {
			        var msg = '결제에 실패하였습니다.';
			        msg += '에러내용 : ' + rsp.error_msg;
			    }
			    alert(msg);
			});

	});
 	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
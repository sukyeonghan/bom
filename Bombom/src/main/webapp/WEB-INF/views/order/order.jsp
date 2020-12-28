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

<section id="container" class="container">
    <div class="order_header">
        <h1>결제하기</h1>
    </div>
   <div style="width: 760px;margin: 40px auto 0;">
    <form action="${path }/order/insertOrder?bNo=${basketNo}" method="post">
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
    <c:if test="${not empty ship}">
        <div class="form-group d-flex mb-3">
            <div class="col-3"><span>받는분</span></div>
            <div class="col-9"><input type="text" name="ordOname"  class="orderer form-control"></div>
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
            <div class="col-9"><p>최근 저장하신 배송메모가 선택됩니다.</p>
            <select name="ordMemo" id="deli_memo" class="form-control mb-3" required>
                <option selected disabled>배송시 요청사항</option>
                <option value="빠른 배송 부탁드립니다.">빠른 배송 부탁드립니다.</option>
                <option value="배송 전,연락주세요.">배송 전,연락주세요.</option>
                <option value="부재 시,휴대폰으로 연락주세요.">부재 시,휴대폰으로 연락주세요.</option>
                <option value="부재 시,경비실에 맡겨주세요.">부재 시,경비실에 맡겨주세요.</option>
                <option value="경비실이 없습니다.배송 전 연락주세요.">경비실이 없습니다.배송 전,연락주세요.</option>
                <option value="배송 전,연락주세요.">배송 전,연락주세요.</option>
                <option value=""></option>
                <option value="직접입력">직접입력</option>
            </select>
            <div id="direct_input"></div></div>
        </div>
        <div class="form-group d-flex">
            <div class="col-3"><label for="phone">휴대전화</label></div>
            <div class="col-9"><input type="text" name="ordOphone" id="phone" class="ordererPhone form-control" required></div>
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
            <div class="col-9"><input type="text" name="ordOphone" id="phone" class="ordererPhone form-control" required></div>
        </div>
    </c:if>
    </div>
    <!-- 수취인 -->
    <div class="mb-5">
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
    	console.log("클릭");
        let orderer = $(".orderer").val(); //이름
        let ordererEmail; //이메일
        let ordererPhone = $(".ordererPhone").val();//휴대전화
        $("#orderer").val(orderer);
        $("#ordererPhone").val(ordererPhone);
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

	
 	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
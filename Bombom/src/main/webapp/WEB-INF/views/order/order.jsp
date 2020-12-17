<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<jsp:include page="/WEB-INF/views/common/header.jsp" >
	<jsp:param name="title" value="결제하기" />
</jsp:include>

<section id="container" class="container ">
    <div class="order_header">
        <h1>결제하기</h1>
    </div>
    <form action="${path }/order/insertOrder" method="post">
    <!-- 주문상품 -->
    <div class="mb-5">
        <h3>주문상품</h3>
        <table>
            <tr>
                <td><img src="../제품이미지/잡화/면화장솜/1.jpg" alt="" style="width: 150px;height: 150px;"></td>
                <td>면화장솜</td>
                <td>3,000원</td>
                <td>3개</td>
            </tr>
        </table>
    </div>
    <!-- 배송지 -->
    <div class="mb-5">
        <h3>배송지</h3>
        <hr>
        <div class="form-group d-flex">
            <label for="postal" class="mr-3">우편번호</label>
            <input type="text" class="form-control mr-3" id="postal" style="width: 150px;" required>
            <input type="button" class="btn btn-success" value="배송지변경">
        </div><br>
        <div class="form-group mb-3">
            <label for="addr">주소</label>
            <input type="text" id="addr" class="form-control" name="ordDeliAddr" required><br>
            <input type="text" class="form-control" name="ordDeliAddr" required placeholder="상세주소">
        </div>
        <div class="form-group">
            <label for="phone">휴대전화</label>
            <input type="text" id="phone" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="deli_memo">배송 메모</label>
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
            <div id="direct_input"></div>
        </div>
    </div>
    <!-- 주문자 -->
    <div class="mb-5">
        <h3>주문자</h3>
        <hr>
        <div class="form-group">
            <span>이름</span>
            <input type="text" class="form-control" required>
        </div>
        <div class="form-group">
            <span>이메일</span>
            <input type="email" class="form-control" required>
        </div>
        <div class="form-group">
            <span>휴대전화</span>
            <input type="text" class="form-control" required><br>
            <label class="form-check-label">
                <input type="checkbox" class="form-check-input">SMS 수신동의 (배송 정보를 SMS로 보내드립니다.)
            </label>
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
        <p><span class="mr-1">1,236P</span>적립예정</p>

    </div>
    <!-- 최종 결제금액 -->
    <div class="form-group mb-5">
        <h3>최종 결제금액</h3>
        <hr>
        <div class="d-flex"><h5>총 상품 금액</h5><span>194,000</span></div>
        <div class="d-flex"><h5>배송비</h5><span name="ordDeliPrice">0</span></div>
        <div class="d-flex"><h5>적립금 사용</h5><span name="ordUsePoint">0</span></div>
        <div class="d-flex"><span name="ordAmount">194,000원</span></div>


    </div>
    <!-- 결제버튼 -->
    <div class="mb-5" style="text-align: center;">
        <button id="payBtn"type="submit" class="btn btn-outline-success" style="width: 500px;">결제하기</button>
    </div>
    </form>
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

</script>

<style>
.order_header>h1 {
	height: 80px;
	margin: 50px 0;
}
</style>

<!-- 배송지/결제 api -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	//결제 API
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
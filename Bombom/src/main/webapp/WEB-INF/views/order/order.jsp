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
    <!-- 주문상품 -->
    <div class="order_">
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
    <div>
        <h3>배송지</h3>
        <hr>
        <div>
            <span>우편번호</span>
            <input type="text">
            <input type="button" class="btn btn-success" value="배송지변경">
        </div><br>
        <div>
            <span>주소</span>
            <input type="text"><br>
            <input type="text">
        </div>
        <div>
            <span>휴대전화</span>
            <input type="text">
        </div>
        <div>
            <span>배송 메모</span>
            <input type="text">
        </div>
    </div>
    <!-- 주문자 -->
    <div>
        <h3>주문자</h3>
        <hr>
        <div>
            <span>이름</span>
            <input type="text">
        </div>
        <div>
            <span>이메일</span>
            <input type="text">
        </div>
        <div>
            <span>휴대전화</span>
            <input type="text"><br>
            <label class="form-check-label">
                <input type="checkbox" class="form-check-input">SMS 수신동의 (배송 정보를 SMS로 보내드립니다.)
            </label>
        </div>
    </div>
    <!-- 적립금 -->
    <div>
        <h3>적립금</h3>
        <hr>
        <p>3만원이상 결제시 포인트 사용이 가능합니다.</p><br>
        <input type="number" name="" id=""><span>P</span><br>
        <p>사용 가능한 포인트 <span>1,236P</span></p>
        <label for=""><input type="checkbox" class="form-check-input">전액사용</label>

    </div>
    <!-- 예상적립금 -->
    <div>
        <h3>예상적립금</h3>
        <hr>
        <p><span>1,236P</span>적립예정</p>

    </div>
    <!-- 최종 결제금액 -->
    <div>
        <h3>최종 결제금액</h3>
        <hr>
        <h5>총 상품 금액</h5><span>194,000</span><br>
        <h5>배송비</h5><span>0</span><br>
        <h5>적립금 사용</h5><span>0</span><br>
        <span>194,000원</span>


    </div>
    <!-- 결제버튼 -->
    <div>
        <button type="button" class="btn btn-outline-success" style="width: 500px;">결제하기</button>
    </div>
</section>


<style>
.order_header>h1 {
	height: 80px;
	margin: 50px 0;
}
</style>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
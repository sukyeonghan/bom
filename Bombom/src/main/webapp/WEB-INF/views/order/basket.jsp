<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<jsp:include page="/WEB-INF/views/common/header.jsp" >
	<jsp:param name="title" value="Welcom springAgain" />
</jsp:include>

<!-- 따라오는 div.js -->
<script src="${path }/resources/js/jquery.scrollfollow.js"></script>

<style>
#basket-container>h1 {
	height: 80px;
	margin: 50px 0;
}

.basket_container_wrap {
	display: flex;
	justify-content: space-around;
}

.basket_sidebar {
	position: absolute;
	left: 100px;
	top: 30px;
	width: 150px;
	height: 300px;
}
</style>

<script>
    //메인배너슬라이드 스크립트
    $(function () {
        $('#mainBanner').carousel({
            interval: 5000, //기본값 5000= 5초,false면 자동 순환하지 않는다.
            pause: "hover", // hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
        });
    })


    // 움직이는 사이드바
    $(document).ready(function () {
        $(".basket_sidebar").scrollFollow({
            speed: 1000,    // 움직이는 속도
            offset: 250     // 웹페이지 상단에서 부터의 거리
        });
    });
</script>

<section id="container" class="container ">
    <div class="basket_header">
        <h1>주문하기</h1>
    </div>
    <div class="basket_container_wrap">
        <div class=" col-8">
            <!--좌측메뉴선택시 화면 -->
            <div id="basket-container" class="media-body">
                <div id="product_view">
                    <table class="table">
                        <tbody>
                            <tr>
                                <td><img src="../제품이미지/욕실/친환경대나무칫솔/1.jpg" alt=""
                                        style="width: 100px;height: 100px;"></td>
                                <td>친환경 대나무 칫솔</td>
                                <td>16,500원</td>
                                <td>3</td>
                                <td>변경</td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="table">
                        <tbody>
                            <tr>
                                <td><img src="../제품이미지/욕실/친환경대나무칫솔/1.jpg" alt=""
                                        style="width: 100px;height: 100px;"></td>
                                <td>친환경 대나무 칫솔</td>
                                <td>16,500원</td>
                                <td>3</td>
                                <td>변경</td>
                            </tr>
                        </tbody>
                    </table>
                    <table class="table">
                        <tbody>
                            <tr>
                                <td><img src="../제품이미지/욕실/친환경대나무칫솔/1.jpg" alt=""
                                        style="width: 100px;height: 100px;"></td>
                                <td>친환경 대나무 칫솔</td>
                                <td>16,500원</td>
                                <td>3</td>
                                <td>변경</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
        <div class="col-4">
            <!-- 따라오는 사이드바 -->
            <div class="basket_sidebar" style="border: 1px solid black;">
                <h2>주문하기</h2>
                <p>상품금액 : 68,500 원</p>
                <p>배송비 : 2,500원</p>
                <hr>
                <p>결제금액 : <span>71,500원</span></p>
                <div class="btn-contain">
                    <input type="button" class="payBtn btn" value="결제하기" style="outline: 0;">
                    <div class="btn-particles"></div>
                </div>
            </div>

        </div>
    </div>

</section>

    
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
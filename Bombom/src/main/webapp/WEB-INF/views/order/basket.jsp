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
#basket_header>h1 {
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
}

</style>

<script>
	// 움직이는 사이드바
	$(document).ready(function() {
		$(".basket_sidebar").scrollFollow({
			speed : 1000, // 움직이는 속도
			offset : 250
		// 웹페이지 상단에서 부터의 거리
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
                	<%-- <c:forEach items="" var=""> --%>
                    <table class="table">
                        <tbody>
                            <tr>
                                <td><img src="../제품이미지/욕실/친환경대나무칫솔/1.jpg" style="width: 100px;height: 100px;"></td>
                                <td>친환경 대나무 칫솔</td>
                                <td>16,500원</td>
                                <td>3</td>
                                <td>변경</td>
                            </tr>
                        </tbody>
                    </table>
                    <%-- </c:forEach> --%>
                </div>
            </div>
        </div>
        <div class="col-4">
            <!-- 따라오는 사이드바 -->
            <div class="basket_sidebar">
                <h2>주문하기</h2>
                <p>상품금액 : 68,500 원</p>
                <p>배송비 : 2,500원</p>
                <hr>
                <p>결제금액 : <span>71,500원</span></p>
                <div class="btn-contain">
                    <input type="button" class="btn btn-outline-success btn-block" value="결제하기" >
                    <div class="btn-particles"></div>
                </div>
            </div>
        </div>
    </div>

</section>

    
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
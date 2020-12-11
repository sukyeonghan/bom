<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<style>

	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	      /* 주문내역 */
      .status {
        background-color: #e9ecef;
        height: 100px;
      }
      .status > ul {
        text-align: center;
      }
      .status li {
        list-style-type: none;
        float: left;
        margin-top: 19px;
        width: 16%;
      }
      .status > ul > li > p {
        float: right;
        font-size: 35px;
      }
      .status > ul > li label {
        display: block;
        font-weight: bolder;
        font-size: 20px;
      }
      /* 주문 상품정보 */
      .order-info {
        margin-top: 30px;
      }
      /* 테이블 */
      .table th, .table td{
        text-align:center;
        vertical-align:middle;
      }
      .table .th{
        vertical-align:middle;
      }
      /* 페이지 번호 들어갈 곳 */
      #page-bar {
        text-align: center;
        margin-top: 30px;
      }
	
</style>
<section id="container" class="container">
	<div class="media">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		
		<!--좌측메뉴선택시 화면 -->
		<div id="order-container" class="media-body">
          <h3>주문내역</h3>
          <div class="status">
            <ul>
              <li>
                <span class="status-order">주문대기</span>
                <p>></p>
                <label class="order-qty">0</label>
              </li>
              <li>
                <span class="status-order">주문완료</span>
                <p>></p>
                <label class="order-qty">0</label>
              </li>
              <li>
                <span class="status-order">배송준비</span>
                <p>></p>
                <label class="order-qty">0</label>
              </li>
              <li>
                <span class="status-order">배송중</span>
                <p>></p>
                <label class="order-qty">0</label>
              </li>
              <li>
                <span class="status-order">배송완료</span>
                <p>></p>
                <label class="order-qty">0</label>
              </li>
              <li>
                <span class="status-order">구매확정</span>

                <label class="order-qty">0</label>
              </li>
            </ul>
          </div>
          <div class="order-info">
            <h4>주문 상품 정보</h4>
            <br>
            <table class="table">
                <thead>
                  <tr>
                    <th>주문일자<br>[주문번호]</th>
                    <th class="th">이미지</th>
                    <th class="th">상품정보</th>
                    <th class="th">수량</th>
                    <th class="th">상품금액</th>
                    <th class="th">주문상태</th>
                    <th></th>
                  </tr>
                </thead>
                <tbody>
              	   <tr>
                    <td rowspan="2">2020-11-19<br><a href="#">[202011190009]</a></td>
                    <td>상품이미지</td>
                    <td>실리콘빨대</td>
                    <td>1</td>
                    <td>2,000원</td>
                    <td>주문완료</td>
                    <td><button type="button" class="btn btn-outline-success">주문취소</button></td>
                  </tr>
                  <tr>
                    <td>상품이미지</td>
                    <td>대나무칫솔</td>
                    <td>2</td>
                    <td>3,000원</td>
                    <td>배송중[3650928566501]</td>
                    <td><button type="button" class="btn btn-outline-success">구매확정</button></td>
                  </tr>
                  <tr>
                    <td>2020-11-19<br><a href="#">[202011190009]</a></td>
                    <td>상품이미지</td>
                    <td>샴푸바</td>
                    <td>10</td>
                    <td>9,000원</td>
                    <td>배송완료[3650928566501]</td>
                    <td><button type="button" class="btn btn-outline-success">리뷰작성</button></td>
                  </tr>
                </tbody>
              </table>
              <div id="page-bar">
                  ${pageBar }
              </div>
                <div id="order-notice">
                    • 주문상태에 따른 버튼 변경
                    -주문취소(주문대기/주문완료), 배송 준비중이면 주문 취소 불가함 - 고객센터에 문의하세요
                    -구매확정(배송준비/배송중/배송완료)
                    -리뷰작성(배송완료 시 리뷰작성 버튼으로 바꾸기)
              </div>
          </div>
        </div>
	</div>
</section>
<script>


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
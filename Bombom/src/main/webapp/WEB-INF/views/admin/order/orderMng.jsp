<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	/*기본 화면 설정  */
	#flexDiv{
	 display:flex;
	 margin:0px 10% 0px 10%;
	}
	/*출력 화면 설정  */
	#admin-container{
	min-width:800px; 
	width:100px;
	}
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}	
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	
	/* 주문관리 */
      /* 진행상태버튼 */
      .btn-outline-success {
        width: 90px;
      }
      /* 진행상태 배경 */
      .status {
        background-color: #e9ecef;
      }
      /* 진행상태 너비 */
      .status td:nth-child(1) {
        width: 20%;
      }
      /* 검색 */
      .form-group {
        display: flex;
      }
      .form-group select {
        width: 120px;
      }
      .form-group .btn-success {
        width: 100px;
      }

      /* 테이블 정렬 */
      .table th,
      .table tr td {
        text-align: center;
        vertical-align:middle;
      }
      /* 페이지 번호 들어갈 곳 */
      #page-bar {
        text-align: center;
        margin-top: 30px;
      }
      /*검색 가운데 정렬 */
      .searchBox{
      	justify-content:center;
      }
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="주문관리" />
</jsp:include>

<section id="container" >
	<div id="flexDiv">
		<!--관리자 내비게이션바 -->
		<div id="" class=" mr-3 admin-nav">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link select" href="${path }/">회원관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/admin/moveProduct">제품관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/admin/order">주문관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/admin/qnaList">1:1문의관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">이벤트관리</a>
		    </li>
		  </ul>
		</div>
		
		<!--좌측메뉴선택시 출력 화면 -->
		<div id="admin-container">
          <h3>주문관리</h3>
          <br />
          <div class="status">
            <table class="table table-borderless">
              <tr>
                <td rowspan="2">진행상태</td>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    전체
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    주문대기
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    주문완료
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    주문취소
                  </button>
                </td>
              </tr>
              <tr>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    배송준비
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    배송중
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    배송완료
                  </button>
                </td>
                <td>
                  <button type="button" class="btn btn-outline-success">
                    취소완료
                  </button>
                </td>
              </tr>
            </table>
          </div>
          <div class="order-info">
            <div class="form-group searchBox">
              <select class="form-control" id="category">
                <option>주문번호</option>
                <option>닉네임</option>
              </select>
              <input type="text" class="form-control" id="search" style="width:300px" />
              <button type="button" class="btn btn-success">검색</button>
            </div>

            <br />
            <table class="table">
              <thead>
                <tr>
                  <th>주문일자</th>
                  <th>주문번호</th>
                  <th>주문자명</th>
                  <th>주문금액</th>
                  <th>주문상태</th>
                  <th>변경</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>2020-11-19</td>
                  <td><a href="${path }/admin/orderDetail">202011190009</a></td>
                  <td>김홍시</td>
                  <td>50,000원</td>
                  <td>
                    <select class="form-control" id="category">
                      <option>주문대기</option>
                      <option>주문완료</option>
                      <option>주문취소</option>
                      <option>배송준비</option>
                      <option>배송중</option>
                      <option>배송완료</option>
                      <option>취소완료</option>
                    </select>
                  </td>
                  <td>
                    <button type="button" class="btn btn-outline-success">
                      적용
                    </button>
                  </td>
          
              </tbody>
            </table>

            <div id="page-bar">${pageBar }</div>
          </div>
        </div>
	</div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
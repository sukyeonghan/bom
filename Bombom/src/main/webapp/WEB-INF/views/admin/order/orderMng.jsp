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
	<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp" />
		<!--좌측메뉴선택시 출력 화면 -->
		<div id="admin-container">
          <form action="${path}/admin/order/ordSort" method="post">
          <h3>주문관리</h3>
          <br />
          <div class="status">
            <table class="table table-borderless">
              <tr>
                <td rowspan="2">진행상태</td>
                <td>
                  <button type="button" class="btn btn-outline-success all" onclick="location.href='${path}/admin/order'">
                    전체
                  </button>
                </td>
                <td>
                  <button type="submit" class="btn btn-outline-success ordWait" value="주문대기" name="sort">
                    주문대기
                  </button>
                </td>
                <td>
                  <button type="submit" class="btn btn-outline-success ordEnd" value="주문완료" name="sort" >
                    주문완료
                  </button>
                </td>
                <td>
                  <button type="submit" class="btn btn-outline-success ordCancel" value="주문취소" name="sort" >
                    주문취소
                  </button>
                </td>
              </tr>
              <tr>
                <td>
                  <button type="submit" class="btn btn-outline-success shipReady" value="배송준비" name="sort">
                    배송준비
                  </button>
                </td>
                <td>
                  <button type="submit" class="btn btn-outline-success shipping" value="배송중" name="sort">
                    배송중
                  </button>
                </td>
                <td>
                  <button type="submit" class="btn btn-outline-success shipEnd" value="배송완료" name="sort">
                    배송완료
                  </button>
                </td>
                <td>
                  <button type="submit" class="btn btn-outline-success cancelEnd" value="취소완료" name="sort">
                    취소완료
                  </button>
                </td>
              </tr>
            </table>
            
          </div>
          <div class="order-info">
            <div class="form-group searchBox">
              <select class="form-control search" name="searchType" >
                <option value="ordNo">주문번호</option>
                <option value="ordOname">주문자</option>
              </select>
              <input type="text" class="form-control" id="search" name="keyword" style="width:300px" />
              <button type="submit" class="btn btn-success result">검색</button>
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
              <c:forEach items="${list}" var="o">
              <tbody>
                <tr>
                  
                  <td><fmt:formatDate type="date" dateStyle="short" value="${o.ordDate}"/></td>
                  <td><a name="orderNo" href="${path }/admin/orderDetail?orderNo=${o.orderNo}"><c:out value="${o.orderNo }"/></a></td>
                  <td><c:out value="${o.ordOname}"/></td>
                  <td><fmt:formatNumber pattern="#,###" value="${o.ordAmount}"/>원</td>
                  <td>
                    <select class="form-control status" id="category">
	                    <option value="주문대기" ${o.ordStatus eq "주문대기"? "selected":"" }>주문대기</option>
	                    <option value="주문완료" ${o.ordStatus eq "주문완료"? "selected":"" }>주문완료</option>
	                    <option value="주문취소" ${o.ordStatus eq "주문취소"? "selected":"" }>주문취소</option>
	                    <option value="배송준비" ${o.ordStatus eq "배송준비"? "selected":"" }>배송준비</option>
	                    <option value="배송중" ${o.ordStatus eq "배송중"? "selected":"" }>배송중</option>
	                    <option value="배송완료" ${o.ordStatus eq "배송완료"? "selected":"" }>배송완료</option>
	                    <option value="취소완료" ${o.ordStatus eq "취소완료"? "selected":"" }>취소완료</option>
                    </select>
                  </td>
                  <td>
                    <input type="button" value="적용" id="updateShip" class="btn btn-outline-success updateShip" >
					<%-- <input type="hidden" id= "orderNo" value="${o.orderNo }"/> --%>
                    
                  </td>
              </tbody>
              </c:forEach>
            </table>

            <div id="page-bar">${pageBar }</div>
          </div>
          </form>
        </div>
	</div>
</section>
<script>


			

			
 		  $(".status").on("change", e=>{
			let ordStatus=$(e.target).val();
			//let status=$("#category").val();
			//let orderNo=$("#orderNo").val();
			console.log(ordStatus);
			let orderNo=$(e.target).parent().prev().prev().prev().children().text();
			console.log(orderNo);
	 			
	 		$(".updateShip").on("click",e=>{
	 				location.replace("${path}/admin/orderShipUpdate?orderNo="+orderNo+"&ordStatus="+ordStatus);
	 			});
		
	 		
			}) 
			
	/* 		$(".search").on("change", e=>{
				let searchType=$(e.target).val();
				console.log(searchType);
				$(".result").on("click", e=>{
					location.replace("${path}/admin/order/ordSort?searchType="+searchType);
				})
			}) */
		
		

	
	

			
</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
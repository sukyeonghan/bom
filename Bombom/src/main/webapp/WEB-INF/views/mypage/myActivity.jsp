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
	/*좌측메뉴*/
	#mypage-nav{padding-right:100px;}
	#mypage-nav a{color:black;font-weight:bolder;}
	#mypage-nav a:hover{color: #45A663;}

	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	      /*버튼 가운데정렬*/
      .btn-box {
        text-align: center;
      }
	/* 글쓰기버튼 */
      #btn-container {
        text-align: right;
      }
      /* 페이지 번호 들어갈 곳 */
      #page-bar {
        text-align: center;
        margin-top: 30px;
      }
      /* 테이블 글제목  가운데 정렬*/
      .table th {
          text-align:center;
      }
      .table th:nth-child(3){
        width: 620px;
      }
</style>
<section id="container" class="container">
	<div class="media">
	
		<!-- 좌측 메뉴 -->
		<div id="mypage-nav" class=" mr-3">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link" href="${path }/mypage/orderStatus">주문내역</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/qna">1:1문의</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link" href="${path }/mypage/myActivity">나의 활동</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link" href="${path }/mypage/stamp">스탬프</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/zzimList">찜목록</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/updateMember">회원정보수정</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/shipList">배송지관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/myPointList">적립금</a>
		    </li>
		  </ul>
		</div>
		
		<!--좌측메뉴선택시 화면 -->
		<div id="myactivity-container" class="media-body">
        <h3>나의활동</h3>
        <br />
        <!-- Nav tabs -->
        <ul class="nav nav-tabs">
            <li class="nav-item">
            <a class="nav-link active" data-toggle="tab" href="#review">상품리뷰</a>
            </li>
            <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#community">커뮤니티글</a>
            </li>
            <li class="nav-item">
            <a class="nav-link" data-toggle="tab" href="#reply">작성댓글</a>
            </li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
          <br>
          <br>
          <!-- 상품리뷰 -->
          <div class="tab-pane container active" id="review">
              <table class="table">
                  <thead>
                    <tr>
                      <th></th>
                      <th>번호</th>
                      <th>글 제목</th>
                      <th>작성날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                      <td><input type="checkbox"></td>
                      <td>2</td>
                      <td>주말이 좋은데... 간격이 왜 다르냐고ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</td>
                      <td>2020-11-18</td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td>주말이 좋은데...</td>
                      <td>2020-11-18</td>
                    </tr>
                  </tbody>
                </table>
                <div id="page-bar">${pageBar }</div>
                <div id="btn-container">
                   <button type="button" class="btn btn-success">선택삭제</button>
                </div>
          </div>
           <!-- 커뮤니티 글 -->
          <div class="tab-pane container fade" id="community">
              <table class="table">
                  <thead>
                    <tr>
                      <th></th>
                      <th>번호</th>
                      <th>글 제목</th>
                      <th>작성날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                      <td><input type="checkbox"></td>
                      <td>2</td>
                      <td>제로제로웨이스트 실천</td>
                      <td>2020-11-18</td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td>액체비누대신 고체비누 사용하기</td>
                      <td>2020-11-18</td>
                    </tr>
                  </tbody>
                </table>
                <div id="page-bar">${pageBar }</div>
               <div id="btn-container">
                  <button type="button" class="btn btn-success">선택삭제</button>
               </div>
          </div>
           <!-- 작성댓글 -->
          <div class="tab-pane container fade" id="reply">
              <table class="table">
                  <thead>
                    <tr>
                      <th></th>
                      <th>번호</th>
                      <th>댓글내용</th>
                      <th>작성날짜</th>
                    </tr>
                  </thead>
                  <tbody>
                      <td><input type="checkbox"></td>
                      <td>2</td>
                      <td>여기 완전 추천이요!</td>
                      <td>2020-11-18</td>
                    </tr>
                    <tr>
                      <td><input type="checkbox"></td>
                      <td>1</td>
                      <td>퍼가도 될까요?</td>
                      <td>2020-11-18</td>
                    </tr>
                  </tbody>
                </table>
                <div id="page-bar">${pageBar }</div>
                <div id="btn-container">
                   <button type="button" class="btn btn-success">선택삭제</button>
                </div>
            </div>
         </div>
       </div>
	</div>
</section>
<script>


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
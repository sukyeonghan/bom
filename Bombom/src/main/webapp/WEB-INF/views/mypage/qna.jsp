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
	
	/* 글쓰기 버튼 오른쪽정렬 */
    #btn-container {
      text-align: right;
    }
    /* 페이지 들어갈 곳 */
    #page-bar {
      text-align: center;
      margin-top: 30px;
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
		<div id="qna-container" class="media-body">
          <h3>1:1문의</h3>
          <br />
          <table class="table">
            <thead>
              <tr>
                <th>번호</th>
                <th>문의유형</th>
                <th>제목</th>
                <th>문의날짜</th>
                <th>답변여부</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>5</td>
                <td>주문/배송</td>
                <td>아직도 제품이 안왔는데요...</td>
                <td>2020-11-18</td>
                <td>답변대기</td>
              </tr>
              <tr>
                <td>4</td>
                <td>주문/배송</td>
                <td>아직도 제품이 안왔는데요...</td>
                <td>2020-11-18</td>
                <td>답변대기</td>
              </tr>
              <tr>
                <td>3</td>
                <td>주문/배송</td>
                <td>아직도 제품이 안왔는데요...</td>
                <td>2020-11-18</td>
                <td>답변대기</td>
              </tr>
              <tr>
                <td>2</td>
                <td>주문/배송</td>
                <td>아직도 제품이 안왔는데요...</td>
                <td>2020-11-18</td>
                <td>답변대기</td>
              </tr>
              <tr>
                <td>1</td>
                <td>주문/배송</td>
                <td>아직도 제품이 안왔는데요...</td>
                <td>2020-11-18</td>
                <td>답변대기</td>
              </tr>
            </tbody>
          </table>
          <div id="page-bar">${pageBar }</div>
          <div id="btn-container">
            <button type="button" class="btn btn-success" onclick="location.replace('${path}/mypage/qnaWrite')">문의작성</button>
          </div>
        </div>
	</div>
</section>
<script>


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
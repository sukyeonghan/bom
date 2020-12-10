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
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		
		
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
                      <th>체크박스</th>
                      <th>작성날짜</th>
                      <th>글 내용</th>
                      <th>답변여부</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:if test="${empty review }">	 
	        		<tr >
	        			<td class="noData" colspan="5">등록된 문의가 없습니다.</td>
	        		</tr>	     
		     	  </c:if>
                  <c:forEach items="${review }" var="review">
                  	<tr>
                      <td><input type="checkbox"></td>
                      <td><fmt:formatDate type="both" timeStyle="short" value="${review.inqDate }"/></td>
                      <td><c:out value="${review.inqContent }"/></td>
                      <td><c:out value="${review.inqAnswerYn }"/></td>
                    </tr>
                   </c:forEach>
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
                      <th>작성날짜</th>
                      <th>글 제목</th>
                      <th>글 내용</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:if test="${empty community }">	 
	        		<tr >
	        			<td class="noData" colspan="5">등록된 문의가 없습니다.</td>
	        		</tr>	     
		     	  </c:if>
		     	  	<tr>
                       <c:forEach items="${community }" var="cm">
                  	<tr>
                      <td><input type="checkbox"></td>
                      <td><fmt:formatDate type="both" timeStyle="short" value="${cm.cmDate }"/></td>
                      <td><c:out value="${cm.cmTitle }"/></td>
                      <td><c:out value="${cm.cmContent }"/></td>
                    </tr>
                   </c:forEach>                   
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
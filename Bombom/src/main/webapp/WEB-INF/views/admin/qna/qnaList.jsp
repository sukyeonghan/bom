<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}

</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="1:1문의" />
</jsp:include>

<section id="container" class="container">
	<div class="media">
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
            <c:forEach items="${list}" var="q">
              <tr>
                <td><c:out value="${q.rownum}"/></td>
                <td><c:out value="${q.qnaCategory}" /></td>
                <td><a><c:out value="${q.qnaTitle}" /></a></td>
                <td><fmt:formatDate type="date" value="${q.qnaDate }"/></td>
                <td><c:out value="${q.qnaYn}" /></td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
          <div id="page-bar">${pageBar }</div>
          <div id="btn-container">
            <button type="button" class="btn btn-success" onclick="location.replace('${path}/admin/qnaDelete')">선택삭제</button>
          </div>
        </div>
	</div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
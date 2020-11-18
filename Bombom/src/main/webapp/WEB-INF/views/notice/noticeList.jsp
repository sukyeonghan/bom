<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="notice" value="공지사항 " />
</jsp:include>
<style>
section {
	margin-top: 220px;
}

#board-nav a {
	color: black;
	font-weight: bolder;
}

#board-nav a:hover {
	color: #45A663;
}

a.card-link {
	font-weight: bolder;
	color: black;
}

div#notice-container {
	width: 400px;
	margin: 0 auto;
	text-align: center;
}

div#notice-container input {
	margin-bottom: 15px;
}
</style>
<section id="content" class="container">


	<!-- 좌측 메뉴 -->
	<div id="board-nav" class="col-sm-3">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link"
				href="${path }/notice/noticeList">공지사항</a></li>
			<li class="nav-item"><a class="nav-link "
				href="${path }/board/faqList">자주묻는질문</a></li>
		</ul>
	</div>

<table id="notice-container" class="table table-striped table-hover">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성일</th>
               
            </tr>
           	<c:forEach items="${list }" var="n">
           		<tr>
           			<td><c:out value="${n.NOTICE_NO }"/></td>
           			<td>
           				<a href="${path }/notice/noticeView.do?noticeNo=${n.NOTICE_NO}">
           					<c:out value="${n.NOTICE_TITLE }"/>
           				</a>
           			</td>
           			<td><c:out value="${n.NOTICE_DATE }"/></td>
           		</tr>
           	</c:forEach>
        </table> 
       
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
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
#board-nav {
	padding-right: 100px;
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

/* 공지사항 div */
div#notice-container {
	width: 800px;
	margin: 0 auto;
	text-align: center;
}

div#notice-container input {
	margin-bottom: 15px;
}
.table{
width: 800px;
}
</style>

<section id="container" class="container">


	<!-- 좌측 메뉴 -->
	<div id="board-nav" class="col-sm-3">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link"
				href="${path }/notice/noticeListMember">공지사항</a></li>
			<li class="nav-item"><a class="nav-link "
				href="/bom/faq/faqList">자주묻는질문</a></li>
		</ul>
	</div>
	
	<!-- 공지사항 리스트 -->
	
	<div id="notice-container" class="container">
		<table id="notice-container" class="table table-hover">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성일</th>
			</tr>
			<c:forEach items="${list }" var="n">
				<tr>
					<td><c:out value="${n.NOTICE_NO }" /></td>
					<td><a
						href="${path }/notice/noticeView.do?noticeNo=${n.NOTICE_NO}">
							<c:out value="${n.NOTICE_TITLE }" />
					</a></td>
				<%-- 	<td><c:out value="${n.NOTICE_DATE }" /></td> --%>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${n.NOTICE_DATE }"/></td>		
				</tr>
			</c:forEach>
		</table>
		</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
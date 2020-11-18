<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="notice" value="공지사항 상세보기" />
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

div#notice-container input, div#notice-container button {
	margin-bottom: 15px;
}


</style>
<section id="content">
	<!-- 좌측 메뉴 -->
	<div id="board-nav" class="col-sm-3">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link"
				href="${path }/notice/noticeList">공지사항</a></li>
			<li class="nav-item"><a class="nav-link "
				href="${path }/board/faqList">자주묻는질문</a></li>
		</ul>
	</div>
	<div id="notice-container">
		<input type="text" class="form-control" placeholder="제목"
			name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle }"
			required>
	
		<textarea class="form-control" name="noticeContent" placeholder="내용"
			required><c:out value="${notice.noticeContent }" /></textarea>
		</div>
	
	</section>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp" />







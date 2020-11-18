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
/* 좌측메뉴  */
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

h3 {
	text-align: center;
}

section {
	margin-top: 220px;
}

div#notice-container {
	width: 80%;
	padding: 20px;
	margin: auto;
	border: 1px #45A663 solid;
	border-radius: 10px;
}

div#btn-box {
	text-align: center;
}
</style>
<section id="content" class="container">
	<!-- 좌측 메뉴 -->
	<div id="board-nav" class="col-sm-3">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link"
				href="${path }/notice/noticeList">공지사항</a></li>
			<li class="nav-item"><a class="nav-link "
				href="/bom/faq/faqList">자주묻는질문</a></li>
		</ul>
	</div>
	<br>
	<h3>공지사항</h3>
	<br>
	<div id="notice-container">
		<input type="text" class="form-control" placeholder="제목"
			name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle }"
			required> <br>
			<input type="text" class="form-control" placeholder="관리자"
			readonly> <br>
		<textarea class="form-control" name="noticeContent" placeholder="내용"
			required><c:out value="${notice.noticeContent }" /></textarea>
	</div>
	<br><br>
	<div id="btn-box">

		<input type="button" class="btn btn-outline-success" value="목록으로"
			onclick="location.replace('${path }/notice/noticeList')">&nbsp;&nbsp;
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />







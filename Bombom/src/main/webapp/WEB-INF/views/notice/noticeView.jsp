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

/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	h3{text-align: center;}
	div#notice-container{
		width:80%;
		padding:40px;
		margin:auto;
		border:1px #45A663 solid ;
		border-radius: 10px;
	}
	/*버튼 가운데정렬*/
	.btn-box{text-align: center;}
	/*버튼크기고정*/
	.btn{width: 100px;}
</style>

<section id="container" class="container">


<div class="media">
	<!-- 좌측 메뉴 -->
	<div id="board-nav" class="col-sm-3">
		<ul class="nav flex-column">
			<li class="nav-item"><a class="nav-link"
				href="${path }/notice/noticeList">공지사항</a></li>
			<li class="nav-item"><a class="nav-link "
				href="/bom/faq/faqList">자주묻는질문</a></li>
		</ul>
	</div>
	        	
     <!-- 공지사항 리스트  -->
	<div id="notice-container" class="container">
	 <h3>공지사항</h3>
	 <br><br>
		<input type="text" class="form-control" placeholder="제목"
			name="noticeTitle" id="noticeTitle" value="${notice.noticeTitle }"
			required> <br>
			<input type="text" class="form-control" placeholder="관리자"
			readonly> <br>
		<textarea class="form-control" name="noticeContent" placeholder="내용"
			required><c:out value="${notice.noticeContent }" /></textarea>
			<br><br>
			<div class="btn-box">
		<input type="button" class="btn btn-outline-success" value="목록으로"
			onclick="location.replace('${path }/notice/noticeList')">&nbsp;&nbsp;
	</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />







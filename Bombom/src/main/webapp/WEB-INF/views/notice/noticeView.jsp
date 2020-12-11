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
	#flexDiv{display:flex; padding: 0px 10% 0px 10%;}
	#notice-container{min-width:800px; width:100%; padding-right:100px;}
	h3{text-align: center;}
	div#line-container{
		width:100%;
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

<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/boardMenu.jsp"/>

		<!-- 우측 메뉴내용 -->
		<div id="notice-container">
			<div id="line-container">
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







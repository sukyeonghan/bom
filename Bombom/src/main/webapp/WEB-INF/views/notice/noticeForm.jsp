<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="공지사항 입력" />
</jsp:include>
<style>
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

	<h3>공지사항 등록/수정/삭제(관리자용)</h3>
	<br>
		<div id="faq-container">
		<!-- faq값이 없을 때는 등록, faq 값이 넘어왔을떄는  수정 -->
		<c:if test="${empty notice }">
			<form name="noticeFrm" action="${path }/notice/insertNotice" onsubmit="return fn_check()">
		</c:if>
		<c:if test="${not empty notice }">
			<form name="noticeFrm" action="${path }/notice/updateNoticeEnd" onsubmit="return fn_check()">
		</c:if>
			<c:if test="${not empty notice }">
				<input type="hidden" value="${notice.noticeNo }" name="noticeNo">
			</c:if>
			
				<br>
				<input type="text" class="form-control" name="noticeTitle" placeholder="제목을 입력해주세요" value='<c:out value="${notice.noticeTitle }"/>' required>
				<br>
				<textarea class="form-control" rows="10" name="noticeContent" placeholder="내용을 입력해주세요" required><c:out value="${notice.noticeContent }"/></textarea>
				<br>
				<div id="btn-box">
					
					<input type="button" class="btn btn-outline-success" value="목록으로" onclick="location.replace('${path }/notice/noticeList')">&nbsp;&nbsp;
					
					<c:if test="${empty notice }">
						<input type="submit" class="btn btn-success" value="등록">
					</c:if>
					<c:if test="${not empty notice }">
						<input type="submit" class="btn btn-success" value="수정">
					</c:if>

				</div>
				
			</form>
		</div>
		
</section>
<script>
	
	function fn_check(){
		
		return true;
	}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
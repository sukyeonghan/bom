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
#flexDiv{display:flex; padding: 0px 10% 0px 10%;}
div#notice-container{min-width:800px; width:100%; padding-right:100px;}

div#notice-container input {
	margin-bottom: 15px;
}


</style>

<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/boardMenu.jsp"/>

		<!-- 우측 메뉴내용 -->
		<div id="notice-container">
		
		<h3>공지사항</h3>
		<div class="text-right">
		<c:if test="${loginMember.memManagerYn == 'Y' }">
			<button class="btn btn-success" id="noticeAddbtn"
				onclick="location.replace('${path}/notice/noticeForm.do')">글쓰기</button>
				</c:if>
		</div>
		<br>
			<table id="notice-container" class="table table-hover">
				<tr>
					<th>제목</th>
					<th>작성일</th>
					<th><c:if test="${loginMember.memManagerYn == 'Y' }">관리자권한</c:if></th>
				</tr>
				<c:forEach items="${list }" var="n">
					<tr>
						<td><a
							href="${path }/notice/noticeView.do?noticeNo=${n.NOTICE_NO}">
								<c:out value="${n.NOTICE_TITLE }" />
						</a></td>
						<%-- 	<td><c:out value="${n.NOTICE_DATE }" /></td> --%>
						<td><fmt:formatDate pattern="yyyy-MM-dd"
								value="${n.NOTICE_DATE }" /></td>
						<td><input type="hidden" value="${n.NOTICE_NO }"
							name="noticeNo" />
							<c:if test="${loginMember.memManagerYn == 'Y' }">
							<button class="btn btn-outline-success"
								onclick="fn_updateNotice();">수정</button>
							<button class="btn btn-outline-secondary"
								onclick="fn_deleteNotice();">삭제</button></c:if></td>
					</tr>
				</c:forEach>
			</table>
			<div id="pageBar">${pageBar }</div>
		</div>
	</div>
</section>
<script>
	function fn_updateNotice() {
		let noticeNo = $(event.target).parent()
				.children('input[name=noticeNo]').val();
		location.replace("${path}/notice/updateNotice?noticeNo=" + noticeNo);
	};

	function fn_deleteNotice() {
		let noticeNo = $(event.target).parent()
				.children('input[name=noticeNo]').val();
		location.replace("${path}/notice/deleteNotice?noticeNo=" + noticeNo);
	};
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
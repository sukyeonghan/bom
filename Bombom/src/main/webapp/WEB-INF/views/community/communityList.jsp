<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="community" value="커뮤니티 " />
</jsp:include>
<style>

/* 커뮤니티 div */
div#community-container {
	width: 800px;
	margin: 0 auto;
	text-align: center;
}

div#community-container input {
	margin-bottom: 15px;
}
.table{
width: 800px;
}
</style>

<br>
<br>
<br>
<br>
<br>
<br>
<section id="container" class="container">


	
	<!-- 커뮤니티 리스트 -->
	
	<div id="community-container" class="container">
		<table id="community-container" class="table table-hover">
			<c:forEach items="${list }" var="c">
				<tr>
					<td><c:out value="${c.CM_NO }" /></td>
					<td><a
						href="${path }/community/communityView.do?cmNo=${c.CM_NO}">
							<c:out value="${c.CM_TITLE }" />
					</a></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd" value="${c.CM_DATE }"/></td>
					<td><c:out value="${c.CM_THUMBNAIL }" /></td>
					<td><c:out value="${c.CM_WRITER }" /></td>
					<td><c:out value="${c.CM_VIEW }" /><c:out value="${c.CM_LIKE }" /></td>		
				</tr>
			</c:forEach>
		</table>
		</div>
		
		
		<div class="text-right">
			<button class="btn btn-success" id="communityAddbtn"
				onclick="location.replace('${path }/community/communityForm')">글쓰기</button>
		</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
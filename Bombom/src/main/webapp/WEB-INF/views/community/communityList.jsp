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
section {
	margin-top: 220px;
}

* {
	box-sizing: border-box;
}

.wrapper {
	border: 2px solid white;
	border-radius: 5px;
	background-color: white;
	
}

.wrapper>div {
	border: 2px solid white;
	border-radius: 5px;
	background-color: white;
	padding: 1em;
	color: black;
	text-align:center;
}

.wrapper {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	column-gap: 10px;
	row-gap: 1em;
	grid-auto-rows: minmax(400px, auto);
}

.banner{
width:100%;
}
</style>
<!-- 로그인 되어야 커뮤니티 이용 가능  -->
<c:if test="${loginMember!=null }">
	<section class="container">
	<div id="community-banner">
	  <img class="banner" src="${path }/resources/images/community/communityBanner.png">
	</div>
		<!-- 커뮤니티 wrapper , grid 사용 -->
        <br><br><br>
        
		<div class="wrapper">
			<c:forEach items="${list }" var="c">
				<div>
					<div id="community-container" class="section">
						<div class="item item1">
							<fmt:formatDate pattern="yyyy-MM-dd" value="${c.CM_DATE }" />
						</div>
							<div class="item item3">
							<c:out value="${c.CM_THUMBNAIL }" />
						</div>
						<div class="item item2">
							<a href="${path }/community/communityView.do?cmNo=${c.CM_NO}">
								<c:out value="${c.CM_TITLE }" />
							</a>
						</div>
						<div class="item item4">
							<c:out value="${c.CM_WRITER }" />
						</div>
						<div class="item item5">
							<span>좋아요 <c:out value="${c.CM_LIKE }" /></span>
                            <span>조회수 <c:out value="${c.CM_VIEW }" /></span>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		 <div id="pageBar">
			${pageBar }
		</div>

		<div class="text-right">
			<button class="btn btn-success" id="communityAddbtn"
				onclick="location.replace('${path }/community/communityForm')">글쓰기</button>
		</div>


	</section>
</c:if>
<script>
	//좋아요 하트 그림 바꾸기
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
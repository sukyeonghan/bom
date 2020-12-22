<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<div class="wrapper">
		<c:forEach items="${list }" var="c">
			<div>
				<div id="community-container" class="section">
					<div class="item item1">
						<fmt:formatDate pattern="yyyy-MM-dd" value="${c.cmDate }" />
					</div>
					<div class="item item3">
						<a href="${path }/community/communityView.do?cmNo=${c.cmNo}">
						<img src="${path }/resources/upload/community/${c.cmThumbnail}"
							width="300" height="200" class="img">
					</div>
					<div class="item item2">
						<a href="${path }/community/communityView.do?cmNo=${c.cmNo}">
							<c:out value="${c.cmTitle }" />
						</a>
					</div>
					<div class="item item3">
					<img src="${path }/resources/upload/profile/${c.memPro}"
					 class="rounded-circle" id="profileImg"  alt="기본프로필" width="30" height="30">
					 <c:out value="${c.memNick }" />
					</div>
					<div class="item item5">
						<span>좋아요 <c:out value="${c.cmLike }" /></span> 
						<span>조회수<c:out value="${c.cmView }" />
						</span>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<div id="pageBar">${pageBar }</div>
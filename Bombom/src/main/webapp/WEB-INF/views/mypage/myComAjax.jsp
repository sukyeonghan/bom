<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

							<!-- 커뮤니티 글 -->
	<div id="result">
					<table class="table">
						<thead>
							<tr>
								<th style="width:5%"><input type="checkbox"></th>
								<th style="width:15%">작성날짜</th>
								<th style="width:30%">글 제목</th>
								<th>글 내용</th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty community }">
								<tr>
									<td class="noData" colspan="5">등록된 글이 없습니다.</td>
								</tr>
							</c:if>
							<tr>
								<c:forEach items="${community }" var="cm">
									<tr>
										<td><input type="checkbox"></td>
										<td><fmt:formatDate type="date" timeStyle="short"
												value="${cm.cmDate }" /></td>
										<td><a href="${path }/community/communityView.do?cmNo=${cm.cmNo}"><c:out value="${cm.cmTitle }" /></a></td>
										<td class="textLine"><c:out value="${cm.cmContent}"/></td>
									</tr>
								</c:forEach>
						</tbody>
					</table>
					<div class="pageBar">${pageBarC }</div>
					<div id="btn-container">
						<button type="button" class="btn btn-success">선택삭제</button>
					</div>
</div>
		    	
<script>
		    
</script>
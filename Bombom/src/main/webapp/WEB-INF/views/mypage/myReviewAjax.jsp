<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox"></th>
								<th>작성날짜</th>
								<th>글 내용</th>

							</tr>
						</thead>
						<tbody>
							<c:if test="${empty review }">
								<tr>
									<td class="noData" colspan="5">등록된 글이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${review }" var="r">
								<tr>
									<td><input type="checkbox"></td>
									<td><fmt:formatDate type="both" timeStyle="short"
											value="${r.revDate }" /></td>
									<td><a class="reviewContent"><c:out value="${r.revContent }" /></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="pageBar">${pageBarR }</div>
					<div id="btn-container">
						<button type="button" class="btn btn-success">선택삭제</button>
					</div>

		    	
<script>
		    
</script>
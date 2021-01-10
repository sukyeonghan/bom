<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

			<!-- 관리 테이블 -->
			<div id="event-table-wrap" class="post table-responsive-md">
				<table id="event-table" class="table table-hover">
					<tr>
						<th></th>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>할인율</th>
						<th>이벤트기간</th>
						<th></th> <!-- 삭제버튼용 -->
						<th></th> <!-- 수정버튼용 -->
					</tr>
					<c:forEach items="${list }" var="e">
					<tr>
						<td><input type="checkbox" name="check" value="check"></td>
						<td><p class="eventNo"><c:out value="${e.eventNo}"/></p></td>
						<td><p class="eventCategory"><c:out value="${e.eventCategory}"/></p></td>
						<td><c:out value="${e.eventTitle }" /></td>
						<td><a class="direct-product" href="${path}/product/productAll">상품명---</a></td>
						<td><c:out value="${e.eventSalePer }" />%</td>
						<td><fmt:formatDate value="${e.eventStartDate }" /> ~ <fmt:formatDate value="${e.eventEndDate }" /></td>
						<td><button id="event-delete" class="btn btn-sm btn-outline-danger" onclick="fn_delete('${e.eventNo}');">삭제</button></td>
						<td><button id="event-delete" class="btn btn-sm btn-outline-secondary" onclick="fn_update('${e.eventNo}');">수정</button></td>
					</tr>
						
					</c:forEach>
				</table>
				<button class="btn btn-success" id="" onclick="location.href='${path}/admin/moveInsertEvent'">이벤트 등록</button>
			</div>
			
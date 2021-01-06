<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

				<div id="result">
					<table class="table">
						<thead>
							<tr>
								<th style="width:5%"><input type="checkbox"></th>
								<th style="width:15%">작성날짜</th>
								<th style="width:30%">상품명</th>
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
									<td><fmt:formatDate type="date" timeStyle="short"
											value="${r.revDate }" /></td>
									<td><a class="reviewContent" href="${path }/product/productOne?pdtNo=${r.pdtNo}"><c:out value="${r.pdtName}"/></a></td>
									<td class="textLine"><a class="shortReview" data-toggle="modal" data-target="#fullContent" onclick="modelDetail(event);"><c:out value="${r.revContent }"  /></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="pageBar">${pageBarR }</div>
					<div id="btn-container">
						<button type="button" class="btn btn-success">선택삭제</button>
					</div>
				</div>
		    	
<script>
$(".shortReview").click(function(){
	let content=$(this).text();
	console.log(content);
	$(".fullReview").text(content);
	console.log($(".fullReview"));
});

</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

	<div class="count-filter">
		<!-- 카테고리별 개수 -->
		<p id="count">총  ${count }개</p>
		<!--카테고리 정렬  -->
		<div class="select-box">
			<select class="sort">
				<option value="전체" ${sort=='전체'?"selected":"" }>전체보기</option>
				<option value="식품" ${sort=='식품'?"selected":"" }>식품</option>
				<option value="잡화" ${sort=='잡화'?"selected":"" }>잡화</option>
				<option value="주방" ${sort=='주방'?"selected":"" }>주방</option>
				<option value="욕실" ${sort=='욕실'?"selected":"" }>욕실</option>
				<option value="여성용품" ${sort=='여성용품'?"selected":"" }>여성용품</option>
				<option value="반려동물" ${sort=='반려동물'?"selected":"" }>반려동물</option>
			</select>
		</div>
	</div>
	<!-- 제품관리 테이블 -->
	<div id="product-table-wrap">
		<table id="product-table">
			<tr>
				<th>선택</th>
				<th>카테고리</th>
				<th>상품명</th>
				<th>상품설명</th>
				<th>기본가격</th>
				<th>이벤트명</th>
				<th>옵션여부</th>
				<th>판매상태</th>
				<th>등록날짜</th>
			</tr>
			<c:if test="${not empty list}">
				<c:forEach var="e" items="${list }">
					<tr>
						<td>
							<input type="checkbox" name="check" value="check">
							<input type="hidden" name="delNum" value="${e.pdtNo }">	
						</td>
						<td><c:out value="${e.pdtCategory}"/></td>
						<td>
							<a class="product-update" href="${path}/admin/productUpdate?pdtNo=${e.pdtNo}">
								<c:out value="${e.pdtName}"/>
							</a>
						</td>
						<td>
							<c:choose>
								
								<c:when test="${fn:length(e.pdtIntro)>9}">
									<c:out value="${fn:substring(e.pdtIntro,0,8) }"/>...
								</c:when>
								<c:otherwise>
									<c:out value="${e.pdtIntro}"/>
								</c:otherwise>
							</c:choose>
							</td>
						<td>
							<fmt:formatNumber value="${e.pdtPrice}" />원
						</td>
						<td>
							<c:choose>
								<c:when test="${not empty e.eventNoRef }">
									<c:out value="${e.eventNoRef}"/>
								</c:when>
								<c:otherwise>
									N
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${not empty e.pdtOptionNo }">
									Y
								</c:when>
								<c:otherwise>
									N
								</c:otherwise>
							</c:choose>
						</td>
						<td><c:out value="${e.pdtStatus}"/></td>
						<td><fmt:formatDate value="${e.pdtDate}" pattern="yyyy-MM-dd"/></td>
						
					</tr>
				</c:forEach>
			</c:if>
		</table>
	
	</div>
			
<script>
	$(".sort").on("change",e=>{
		console.log($(e.target).val());
		$.ajax({
			
			url:"${path}/admin/productListAjax",
			data:{"sort":$(e.target).val()},
			type:"get",
			dataType:"html",
			success:data=>{
				console.log(data);
				$(".ajax").html(data);
			}
		});
	});
</script>


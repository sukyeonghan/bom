<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" " />
</jsp:include>
<style>
#flexDiv {
	display: flex;
	padding: 0px 10% 0px 10%;
}

#mypage-container {
	min-width: 800px;
	width: 100%;
}
/*버튼 가운데정렬*/
.btn-box {
	text-align: center;
}


/* 페이지 번호 들어갈 곳 */
#page-bar {
	text-align: center;
	margin-top: 30px;
}
/* 테이블 */
.table th:nth-child(3) {
	width: 600px;
}

.table th, .table td {
	text-align: center;
	vertical-align: middle;
}

.table .th {
	vertical-align: middle;
}
/* 해당상품 이동버튼 */
.moveBtn{
	text-align:center;
}
.movePdt{
	margin: 20px 0 20px 0;
}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp" />
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container">
			<h3>나의활동</h3>
			<br />
			<!-- Nav tabs -->
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link active"
					data-toggle="tab" href="#review">상품리뷰</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#community">커뮤니티글</a></li>
				<li class="nav-item"><a class="nav-link" data-toggle="tab"
					href="#reply">작성댓글</a></li>
			</ul>

			<!-- Tab panes -->
			<div class="tab-content">
				<br> <br>
				<!-- 상품리뷰 -->
				<div class="tab-pane container active" id="review">
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
									<td><a data-toggle="modal" data-target="#myReview"
										class="reviewContent"><c:out value="${r.revContent }" /></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div id="page-bar">${pageBar }</div>
					<div id="btn-container">
						<button type="button" class="btn btn-success">선택삭제</button>
					</div>
					<!--구매평 모달창 -->
					<div class="modal fade" id="myReview" tabindex="-1" role="dialog"
						aria-labelledby="exampleModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">

								<!-- Modal Header -->
								<div class="modal-header">
									<h5 class="modal-title rProduct">에 대한 구매평입니다.</h5>
									<button type="button" class="close" data-dismiss="modal">X</button>
								</div>
								<!-- Modal body -->
								<div class="modal-body container">
									<!-- 구매평 작성날짜 -->
									<div class="form-group">
										<p></p>
									</div>
									<!--구매평 내용 -->
									<div class="form-group">
										<textarea class="form-control rContent" rows="5" readonly></textarea>
									</div>

								</div>
								<div class="moveBtn">
									<input type="hidden" class="qNo" name="qnaNo" readonly>
									<input type="button"
										class="btn btn-outline-success btn-sm movePdt "
										value="해당상품으로 이동"><br>
								</div>
							</div>
						</div>
					</div>

				</div>
				<!--구매평 끝  -->
				<!-- 커뮤니티 글 -->
				<div class="tab-pane container fade" id="community">
					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox"></th>
								<th>작성날짜</th>
								<th>글 제목</th>
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
										<td><fmt:formatDate type="both" timeStyle="short"
												value="${cm.cmDate }" /></td>
										<td><c:out value="${cm.cmTitle }" /></td>
									</tr>
								</c:forEach>
						</tbody>
					</table>
					<div id="page-bar">${pageBar }</div>
					<div id="btn-container">
						<button type="button" class="btn btn-success">선택삭제</button>
					</div>
				</div>
				<!-- 작성댓글 -->
				<div class="tab-pane container fade" id="reply">
					<table class="table">
						<thead>
							<tr>
								<th><input type="checkbox"></th>
								<th>작성날짜</th>
								<th>댓글내용</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><input type="checkbox"></td>
								<td>2020-11-18</td>
								<td>여기 완전 추천이요!</td>
							</tr>
						</tbody>
					</table>
					<div id="page-bar">${pageBar }</div>
					<div id="btn-container">
						<button type="button" class="btn btn-success">선택삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<script>
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
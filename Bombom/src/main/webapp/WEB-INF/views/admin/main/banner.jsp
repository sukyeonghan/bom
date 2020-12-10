<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
/*좌측메뉴*/
.admin-nav {
	padding-right: 100px;
}

.admin-nav a {
	font-weight: bolder;
}

.admin-nav a:hover {
	color: #45A663;
}

.select {
	color: #45A663;
}

.non-select {
	color: black;
}

/*최소 컨텐츠 크기*/
.media {
	min-width: 768px;
}

/*페이지 타이틀*/
.page-title {
	margin-bottom: 3%;
}
/*상단 버튼과 셀렉트 박스 정렬*/
.btns-category {
	display: flex;
	justify-content: space-between;
}
/*정렬*/
.sort {
	border: none;
	outline: none;
}
/*선택삭제 버튼*/
#selectDel {
	margin-left: 5px;
}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="이벤트" />
</jsp:include>

<section id="container" class="container">
	<div class="media">

		<!--관리자 내비게이션바 -->
		<div id="" class=" mr-3 admin-nav">
			<ul class="nav flex-column">
				<li class="nav-item"><a class="nav-link non-select"
					href="path/admin/memberList">회원관리</a></li>
				<li class="nav-item"><a class="nav-link non-select"
					href="path/admin/moveProduct">제품관리</a></li>
				<li class="nav-item"><a class="nav-link non-select"
					href="path/">주문관리</a></li>
				<li class="nav-item"><a class="nav-link non-select"
					href="path/">1:1문의관리</a></li>
				<li class="nav-item"><a class="nav-link non-select"
					href="path/admin/moveEvent">이벤트관리</a></li>
				<li class="nav-item"><a class="nav-link non-select"
					href="path/">커뮤니티관리</a></li>
				<li class="nav-item"><a class="nav-link select"
					href="path/admin/moveMainBanners">메인관리</a></li>
			</ul>
		</div>

		<div id="banner-container" class="media-body">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">메인관리</h3>
			<hr>
			<!-- 메인 이벤트 배너 관리 -->
			<div id="slide_banner">
				<h5>슬라이드 배너 관리</h5>
				<div class="btns-category mb-2">
					<!-- 전체 선택, 선택 삭제 버튼 -->
					<div class="buttons">
						<button class="btn btn-success" id="selectAll"
							onclick="selectAll();">전체 선택</button>
						<button class="btn btn-success" id="selectDel" onclick="">선택
							삭제</button>
					</div>
				</div>

				<!-- 관리 테이블 -->
				<div id="event-table-wrap" class="post table-responsive-md">
					<table id="" class="table table-hover">
						<thead>
							<tr>
								<th></th>
								<th>번호</th>
								<th>연관상품</th>
								<th>제목</th>
								<th>소제목</th>
								<th>이미지미리보기</th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:if test="${empty list }">
								<thead>
									<tr>
										<td colspan="8" style="text-align: center;">존재하는 배너가 없습니다.</td>
									</tr>
								</thead>
							</c:if>
							<c:forEach items="${list }" var="b">
								<tr>
									<td><input type="checkbox" name="check" value="check"></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td><button id="banner-update"
											class="btn btn-sm btn-outline-secondary"
											onclick="fn_update('');">수정</button></td>
									<td><button id="banner-delete"
											class="btn btn-sm btn-outline-danger"
											onclick="fn_delete('');">삭제</button></td>
								</tr>
							</c:forEach>
						</tbody>

					</table>
					
				</div>
				<button class="btn btn-success" id=""
					onclick="location.href='${path}/admin/moveInsertBanner'">배너
					등록</button>
			</div>
			<div id="page-bar">${pageBar }</div>
		</div>
	</div>
</section>

<script>

	var checkAll = 'false';

	function selectAll() {
		let items = document.getElementsByName("check");
	
		if (checkAll == 'false') {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = true;
			}
			checkAll = "true";
		} else {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = false;
			}
			checkAll = "false";
		}
	}
	
	//삭제버튼 구현
	function fn_delete(){
		var url = "${path}/admin/";
		var no = { : };
		var ck = confirm("정말로 삭제하시겠습니까?");
		if(ck){
			window.location = url+'?'+$.param(no);
		}
	}
	
	//수정하기버튼 구현
	function fn_update(){
		var url = "${path}/admin/";
		var no = { : };
		var ck = confirm("수정하시겠습니까?");
		if(ck){
			window.location = url+'?'+$.param(no);
		}
		
	}
	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />



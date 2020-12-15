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
	margin-bottom: 5%;
}

/*상단 버튼과 셀렉트 박스 정렬*/
.btns-category, .select-box {
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
/* 테이블*/
#event-table {
	width: 100%;
	margin: 20px 0;
	border-collapse: collapse;
	text-align: center;
	padding: 5px;
}

th, td {
	padding: 5px;
}
/*페이지바*/
.pagebar {
	margin-top: 100px;
	text-align: center;
}

.pagebar a {
	font-size: 18px;
	color: black;
}

.pagebar a:link {
	text-decoration: none;
	color: black;
}

.pagebar a:hover {
	text-decoration: none;
	color: #45A663;
}

/*검색*/
#search-wrap {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 20px;
}

#search-text {
	margin: 0 15px;
}

#flexDiv {
	display: flex;
	padding: 0px 10% 0px 10%;
}

#admin-container {
	min-width: 800px;
	width: 100%;
	padding-right: 100px;
}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="이벤트" />
</jsp:include>

<section id="container">
	<div id="flexDiv">
      <!-- 좌측 메뉴 -->
      <jsp:include page="/WEB-INF/views/common/adminMenu.jsp" />
      <!-- 우측 메뉴내용 -->
      <div id="admin-container">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">이벤트관리</h3><hr>
			<div class="btns-category">
				<!-- 전체 선택, 선택 삭제 버튼 -->
				<div class="buttons">
					<button class="btn btn-success" id="selectAll" onclick="selectAll();">전체 선택</button>
					<button class="btn btn-success" id="selectDel" onclick="">선택 삭제</button>
				</div>
				<!--카테고리 정렬  -->
				<div class="select-box">
					<select id="event_sort" class="sort">
						<option value="전체보기">전체보기</option>
						<option value="할인">할인</option>
						<option value="커뮤니티">커뮤니티</option>
						<option value="기타">기타</option>
					</select>
				</div>
			</div>
			
			<!-- 관리 테이블 -->
			<div id="event-table-wrap" class="post table-responsive-md">
				<table id="event-table" class="table table-hover">
					<tr>
						<th></th>
						<th>번호</th>
						<th>카테고리</th>
						<th>제목</th>
						<th>할인품목</th>
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
						<td><button id="event-update" class="btn btn-sm btn-outline-secondary" onclick="fn_update('${e.eventNo}');">수정</button></td>
					</tr>
						
					</c:forEach>
				</table>
				<button class="btn btn-success" id="" onclick="location.href='${path}/admin/moveInsertEvent'">이벤트 등록</button>
			</div>
			
			<!-- 페이징바 -->
			 <div class="w3-center pagebar">	
				<div class="w3-bar">
					<a href="#" class="w3-button w3-hover-black"> < </a>
					<a href="#" class="w3-button w3-hover-black">1</a>
					<a href="#" class="w3-button w3-hover-black">2</a>
					<a href="#" class="w3-button w3-hover-black">3</a>
					<a href="#" class="w3-button w3-hover-black">4</a>
					<a href="#" class="w3-button w3-hover-black"> > </a>
				</div>
			</div>
			
			<!-- 검색 -->
			<div id="search-wrap">
				<!-- 검색 카테고리 -->
				<div class="select-box">
					<select class="sort">
						<option>상품명</option>
						<option>이벤트명</option>
					</select>
				</div>
				<input type="text" id="search-text">
				<button class="btn btn-success" id="search-btn">검색</button>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

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
	function fn_delete(eventNo){
		var url = "${path}/admin/eventDelete";
		var no = {eventNo : eventNo};
		var ck = confirm("정말로 삭제하시겠습니까?");
		if(ck){
			window.location = url+'?'+$.param(no);
		}
	}
	
	//수정하기버튼 구현
	function fn_update(eventNo){
		var url = "${path}/admin/moveEventUpdate";
		var no = {eventNo:eventNo};
		var ck = confirm("수정하시겠습니까?");
		if(ck){
			window.location = url+'?'+$.param(no);
		}
		
	}
	
	//카테고리별 정렬하기
	$("#event_sort").change(e => {
		console.log($(e.target).val()); //전체보기, 할인, 커뮤니티, 기타
		$.ajax({
			url:"${path}/admin/eventSort",
			data:{"sort":$(e.target).val()},
	        dataType:"html",
	        type:"post",
	        success:data =>{
				console.log(data);
				$("#event-table-wrap").html("");
				$("#event-table-wrap").html(data);
	        }
		});
	});
	
	
</script>

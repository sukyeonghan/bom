<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="이벤트" />
</jsp:include>

<section id="container" class="container">
    <div class="media">

        <!--관리자 내비게이션바 -->
        <div id="" class=" mr-3 admin-nav">
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link non-select" href="${path }/">회원관리</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link select" href="${path }/admin/moveProduct">제품관리</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link non-select" href="${path }/">주문관리</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link non-select" href="${path }/">1:1문의관리</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link non-select" href="${path }/admin/event/moveEvent">이벤트관리</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link non-select" href="${path }/">커뮤니티관리</a>
                </li>
            </ul>
        </div>

        <div id="admin-container" class="media-body">
            <!-- 페이지 타이틀 -->
            <h3 class="page-title">이벤트관리</h3>
            <hr>

            <!-- 이벤트 작성 폼 -->
            <div id="event-container-wrap">
                <h4>이벤트 작성</h4>
                <form class="form-horizontal" role="form" action="${path }/admin/insertEvent">
                    <div class="form-group d-flex">
                        <label for="title" class="col-2 control-label">제목</label>
                        <div class="col-10">
                            <input type="text" id="title" class="form-control" placeholder="제목입력">
                        </div>
                    </div>
                    <div class="form-group d-flex">
                        <div class="col-2">
                            <label for="e_term" class="control-label">이벤트기간</label>
                        </div>
                        <div id="e_term" class="d-flex col-10">
                            <div class="col-5">
                                <h6><label for="start"><small>시작일</small></label></h6>
                                <div class="d-flex" id="start">
                                    <input type="number" name="year" id="year_" placeholder="YYYY"
                                        class="form-control" max="2050" min="1900" required>
                                    <input type="number" name="month" id="month_" placeholder="MM"
                                        class="form-control" max="12" min="1" required>
                                    <input type="number" name="date" id="date_" placeholder="DD"
                                        class="form-control" max="31" min="1" required><br>
                                </div>
                            </div>
                            <div class="col-2">
                                <p>
                                <h3> ~ </h3>
                                </p>
                            </div>
                            <div class="col-5">
                                <h6><label for="end"><small>종료일</small></label></h6>
                                <div class="d-flex" id="end">
                                    <input type="number" name="year" id="year_" placeholder="YYYY"
                                        class="form-control" max="2050" min="1900" required>
                                    <input type="number" name="month" id="month_" placeholder="MM"
                                        class="form-control" max="12" min="1" required>
                                    <input type="number" name="date" id="date_" placeholder="DD"
                                        class="form-control" max="31" min="1" required><br>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group d-flex">
                        <label for="title" class="col-2 control-label">할인율</label>
                        <div class="col-10">
                            <input type="number"><span>%</span>
                        </div>
                    </div>
                    <div>
                        <button type="submit" class="btn btn-success" style="text-align:center;">이벤트 등록하기</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</section>


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

/* 이벤트 작성 폼 */
#event-container-wrap label {
	
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
</style>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
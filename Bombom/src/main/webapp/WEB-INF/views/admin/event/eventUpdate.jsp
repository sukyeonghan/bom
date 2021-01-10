<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	
	input[type=number]{	width:50%;}
	
	   
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
			<h3 class="page-title">이벤트 수정</h3><hr>
			
			<!-- 이벤트 작성 폼 -->
            <div id="event-container-wrap">
                <h4>이벤트 작성</h4>
                <form class="form-horizontal" role="form" action="${path }/admin/eventUpdate">
                    <div class="form-group d-flex">
                        <label for="title" class="col-2 control-label">이벤트번호</label>
                        <div class="col-10">
                            <input type="text" id="no" name="eventNo" value="${e.eventNo }"class="form-control" readonly>
                        </div>
                    </div>
                    <div class="form-group d-flex">
                        <label for="title" class="col-2 control-label">제목</label>
                        <div class="col-10">
                            <input type="text" id="title" name="eventTitle" value="${e.eventTitle }"class="form-control" placeholder="제목입력" >
                        </div>
                    </div>
                    <div class="form-group d-flex">
                        <div class="col-2">
                            <label for="e_term" class="control-label">이벤트기간</label>
                        </div>
                        <div id="e_term" class="d-flex col-10">
                            <div class="col-5">
                                <h6><label for="start"><small>시작일 / <fmt:formatDate value="${e.eventStartDate }" /></small></label></h6>
                                <div class="d-flex" id="start">
                                    <input type="date" name="eventStartDate" id="eventStartDate" value="<fmt:formatDate value="${e.eventStartDate }" />"placeholder="YYYY"
                                        class="form-control" max="2100" min="1900" required >
                                </div>
                            </div>
                            <div class="col-2">
                               	<h3> ~ </h3>
                            </div>
                            <div class="col-5">
                                <h6><label for="end"><small>종료일 / <fmt:formatDate value="${e.eventEndDate }" /></small></label></h6>
                                <div class="d-flex" id="end">
                                    <input type="date" name="eventEndDate" id="eventEndDate" value="<fmt:formatDate value="${e.eventEndDate }" />" placeholder="YYYY"
                                        class="form-control" max="2100" min="1900" required>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="form-group d-flex">
                      <label for="category" class="col-2 control-label">카테고리</label>
                      <div class="col-10">
                          <select name="eventCategory" id="category" class="form-control" required> 
                              <option selected disabled>${e.eventCategory }</option>
                              <option value="할인">할인</option>
                              <option value="커뮤니티">커뮤니티</option>
                              <option value="기타">기타</option>
                          </select>
                      </div>
                  </div>
                  <div class="form-group d-flex">
                      <label for="sale" class="col-2 control-label">할인율</label>
                      <div class="col-10 d-flex">
                          <input type="number" id="sale" name="eventSalePer" value="${e.eventSalePer}" class="form-control" required><span>%</span>
                      </div>
                  </div>
                  <div style="text-align:center;">
                      <button type="submit" class="btn btn-success" style="text-align:center;">이벤트 수정하기</button>
                  </div>
                </form>
            </div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script type="text/javascript">
	//수정할때 날짜 뿌려주기







</script>


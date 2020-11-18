<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<style>
	section{margin-top:220px;}
	/*게시판 메뉴*/
/*  	#board-nav{
		min-width: 180px;
		width: 180px;
		padding:0;
	}  */
	#board-nav a{color:black;font-weight:bolder;}
	#board-nav a:hover{color: #45A663;}
	
	a.card-link{font-weight:bolder; color:black;}
	
	/*아코디언 타이틀*/
	.card-header div{display: inline-block;}
	.card-header div:nth-of-type(1){width: 50px;}
	.card-header div:nth-of-type(2){width: 100px;color:#45A663;}
	

</style>
<section id="content" class="container">
	
	<div class="row">
		<!-- 좌측 메뉴 -->
		<div id="board-nav" class="col-sm-3">
		  <ul class="nav flex-column">
		    <li class="nav-item">
		      <a class="nav-link" href="${path }/notice/noticeList">공지사항</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link " href="${path }/board/faqList">자주묻는질문</a>
		    </li>
		  </ul>
		</div>
		
		<!--좌측메뉴선택시 화면 -->
		<div id="board-container" class="col-sm-9">
			<h3>자주묻는 질문</h3> 
			<br>
			<div class="d-flex justify-content-between">
				  <div>
					  <ul id="category-nav" class="nav">
					  	
						  <li class="nav-item">
						    <a class="nav-link active" href="#">전체</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link" href="#">주문/결제</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link" href="#">배송</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link" href="#">취소/환불</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link" href="#">기타</a>
						  </li>
					  </ul>
				  </div>
				  <div class="text-right">
				  	<button class="btn btn-success" id="faqAddbtn" onclick="location.replace('${path}/board/faq')">글쓰기</button>     
				  </div>
			</div>
		 	<hr>
			 <div id="accordion">
				  <c:forEach items="${list}" var="f" varStatus="vs">
				  
					 <div class="card">
						<!-- 타이틀부분 -->
					    <div class="card-header">
					      <a class="collapsed card-link" data-toggle="collapse" href="#collapse${vs.index}">
					         <div><c:out value="${list.size() - vs.index}"/></div>
					         <div><c:out value="${f.faqCategory }"/></div> 
					         <div><c:out value="${f.faqTitle}"/></div>
					      </a>
					    </div>
					    
					    <!-- body부분 -->
					    <div id="collapse${vs.index}" class="collapse" data-parent="#accordion">
					      <div class="card-body">
					        <c:out value="${f.faqContent }"/> 
					        <!-- 관리자일때만 뜰 부분 -->
							<br>
							<br>
							<div class="btn-box">
								<input type="hidden" value="${f.faqNo }" name="faqNo"/>
								<button class="btn btn-outline-success" onclick="fn_updateFaq();">수정</button>
								<button class="btn btn-outline-secondary" onclick="fn_deleteFaq();">삭제</button>
							</div> 
							
					      </div>
					    </div>
					    
					  </div>
					  
			   	</c:forEach>
			</div>
		</div>
	</div>
</section>
<script>
	function fn_updateFaq(){
		let faqNo=$(event.target).parent().children('input[name=faqNo]').val();		
		location.replace("${path}/board/updateFaq?faqNo="+faqNo);
	} 
		
	function fn_deleteFaq(){
		let faqNo=$(event.target).parent().children('input[name=faqNo]').val();
		location.replace("${path}/board/deleteFaq?faqNo="+faqNo);
	}; 


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
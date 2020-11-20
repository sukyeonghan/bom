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
	/*좌측메뉴*/
	#board-nav{padding-right:100px;}
	#board-nav a{color:black;font-weight:bolder;}
	#board-nav a:hover{color: #45A663;}

	/*아코디언 타이틀*/
	a.card-link{font-weight:bolder; color:black;} 
	.card-header{background-color: #F2FFED;border:1px #E0FFDB solid;}
	.card-header div{display: inline-block;}
	.card-header div:nth-of-type(1){width: 50px;}
	.card-header div:nth-of-type(2){width: 100px;color:#45A663;}
	.card-header div:nth-of-type(3){width: 450px;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*버튼 가운데정렬*/
	.btn-box{text-align: center;}
	/*faq 카테고리*/
	ul#category-nav{padding:0px;}
	ul#category-nav>li{
		display:inline-block;
		margin-right: 30px;
		font-weight:bolder; 
		color:black;
		cursor:pointer;
	}
	ul#category-nav>li:hover{color:#45A663;}

</style>
<section id="container" class="container">
	<div class="media">
	
		<!-- 좌측 메뉴 -->
		<div id="board-nav" class=" mr-3">
		  <ul class="nav flex-column">
		    <li class="nav-item">
		      <a class="nav-link" href="${path }/notice/noticeList">공지사항</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link " href="${path }/faq/faqList">자주묻는질문</a>
		    </li>
		  </ul>
		</div>
		
		<!--좌측메뉴선택시 화면 -->
		<div id="faq-container" class="media-body">
			<h3>자주묻는 질문</h3> 
			<br>
			<div class="d-flex justify-content-between">
				  <div>
					  <ul id="category-nav">  	
						  <li class="cate-list">전체</li>
						  <li class="cate-list">주문/결제</li>
						  <li class="cate-list">배송</li>
						  <li class="cate-list">취소/환불</li>
						  <li class="cate-list">기타</li>
					  </ul>
				  </div>
				  <!-- 관리자일때만 뜰 버튼 -->
				  <div class="text-right">
				  	<button class="btn btn-success" id="faqAddbtn" onclick="location.replace('${path}/faq/faq')">글쓰기</button>     
				  </div>
			</div>
			
		 	<hr>
		 	<div id="result">
			 <div id="accordion">
				  <c:forEach items="${list}" var="f" varStatus="vs">
				  
					 <div class="card">
						<!-- 타이틀부분 -->
					    <div class="card-header">
					      <a class="collapsed card-link" data-toggle="collapse" href="#collapse${vs.index}">
					         <div><c:out value="${f.rownum }"/></div>
					         <div><c:out value="${f.faqCategory }"/></div> 
					         <div><c:out value="${f.faqTitle}"/></div>
					      </a>
					    </div>
					    
					    <!-- body부분 -->
					    <div id="collapse${vs.index}" class="collapse" data-parent="#accordion">
					      <div class="card-body">
					        <c:out value="${f.faqContent }"/> 
							<br>
							<br>
					        <!-- 관리자일때만 뜰 버튼 -->
							<div class="btn-box">
								<input type="hidden" value="${f.faqNo }" name="faqNo"/>
								<button class="btn btn-outline-success" onclick="fn_updateFaq();">수정</button>&nbsp;&nbsp;
								<button class="btn btn-outline-secondary" onclick="fn_deleteFaq();">삭제</button>
							</div> 
							
					      </div>
					    </div>
					    
					  </div>
					  
			   	</c:forEach>
			</div>
			<br>
			<br>
			
			<div id="pageBar">
				${pageBar }
		    </div> 
	        
		</div>
		</div>
	</div>
</section>
<script>
	function fn_updateFaq(){
		let faqNo=$(event.target).parent().children('input[name=faqNo]').val();		
		location.replace("${path}/faq/updateFaq?faqNo="+faqNo);
	}; 
		
	function fn_deleteFaq(){
		let faqNo=$(event.target).parent().children('input[name=faqNo]').val();
		location.replace("${path}/faq/deleteFaq?faqNo="+faqNo);
	}; 

	$(function(){
		$(".cate-list").click(e=>{
			console.log($(e.target).html());
			$.ajax({
				url:"${path}/faq/faqListAjax",
				data:{category:$(e.target).html(),cPage:1,numPerpage:"${numPerpage}"},
			   	type:"get",
			   	dataType:"html",
				success:data=>{
					console.log(data);
					$("#result").html("");
					$("#result").html(data);
				}
			})
		});
		
	});	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
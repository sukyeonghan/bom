<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!--줄바꿈 -->
<% pageContext.setAttribute("newLine", "\n"); %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<style>
	#flexDiv{display:flex; padding: 0px 10% 0px 10%;}
	#board-container{min-width:800px; width:100%; padding-right:100px;}
	/*아코디언 타이틀*/
	a.card-link{font-weight:bolder; color:black;} 
	.card-header{background-color: #F2FFED;border:1px #E0FFDB solid;}
	.card-header div{display: inline-block;}
	.card-header div:nth-of-type(1){width: 50px;}
	.card-header div:nth-of-type(2){width: 100px;color:#45A663;}
	.card-header div:nth-of-type(3){width: 450px;}
	
	/*버튼 가운데정렬*/
	.btn-box{text-align: center;white-space:normal;margin-top:20px;}
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
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/boardMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="board-container" >
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
				  <c:if test="${loginMember.memManagerYn=='Y' }">
					  <div class="text-right">
					  	<button class="btn btn-success" id="faqAddbtn" onclick="location.replace('${path}/faq/faq')">글쓰기</button>     
					  </div>
				  </c:if>
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
						      	<!-- 줄바꿈 표현 -->
						        <div >${fn:replace(f.faqContent, newLine, "<br/>")}</div>
						        <c:if test="${loginMember.memManagerYn=='Y' }">
									<div class="btn-box">
										<input type="hidden" value="${f.faqNo }" name="faqNo"/>
										<button class="btn btn-outline-success" onclick="fn_updateFaq();">수정</button>&nbsp;&nbsp;
										<button class="btn btn-outline-secondary" onclick="fn_deleteFaq();">삭제</button>
									</div> 
								</c:if>
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
			});
		});
		
	});	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
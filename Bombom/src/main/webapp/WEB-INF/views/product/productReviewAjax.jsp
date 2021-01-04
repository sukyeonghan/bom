<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

			        <!-- 구매평 게시글 -->
			        <div id="result">
			        	<div class="container">
				        	 <c:if test="${not empty reviewlist }">	
				        		 <ul class="accordion_wrap">
					        		 <c:forEach items="${reviewlist}" var="r">
									    <li class="accordion_inner">
									    <!-- 타이틀 -->
									      <div class="accordion_title">
									      	<div class="col-9">
									      		<!-- 별점 불러오기 -->
									      		<c:forEach begin="1" end="${r.revScore}" step="1" varStatus="vs"> 
									      			<img src="${path}/resources/images/product/star.png" style="width:20px;height:20px;margin:0 0 5px -3px;">
									      		</c:forEach>
									      		<c:forEach begin="1" end="${5-r.revScore}" step="1">
									      		 	<img src="${path}/resources/images/product/starblank.png" style="width:20px;height:20px;margin:0 0 5px -3px;">
									      		</c:forEach>
										      	<span><c:out value="${r.revScore}"/></span><br>
										      	<img src="${path }/resources/upload/profile/${r.memPro}" style="max-width:30px; height:30px;border-radius:50%;">&nbsp;
											      <span><strong><c:out value="${r.memNick}" /></strong></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span><fmt:formatDate type="both" timeStyle="short" value="${r.revDate }"/></span><br>
											     <c:out value="${r.revContent}"/>
									      	</div>
									      	<div class="col-2"><c:if test="${r.revImage!=null }"><img src="${path}/resources/upload/review/${r.revImage }" style="height:100%;"/></c:if></div>
									      	<div class="col-1 plusminus"></div>
									      </div>
									      <!-- 상세보기 -->
									      <div class="accordion_content">
									      	<div>
										        <!-- 작성자와 로그인한 사람이 같을경우 수정, 삭제 버튼 생성 -->
										        <c:if test="${loginMember.memNo==r.memNo }">
										        	<div style="display:inline-block;float:right;">
										        		<input type="hidden" name="revNo" value="${r.revNo}">
											        	<input type="button" class="btn btn-outline-success btn-sm updateView" data-toggle="modal" data-target="#updateReview" value="수정">
											        	<span style="display:none"><c:out value="${r.revNo}"/></span>
													    <span style="display:none"><c:out value="${r.memNick}"/></span>
													    <span style="display:none"><c:out value="${r.revScore}"/></span>
													    <span style="display:none"><c:out value="${r.revContent}"/></span>
													    <span style="display:none"><c:out value="${r.revImage}"/></span>
													    <span style="display:none"><fmt:formatDate type="both" timeStyle="short" value="${r.revDate }"/></span>
													    <span style="display:none"><c:out value="${r.memPro}"/></span>
						        						<input type="button" class="btn btn-outline-success btn-sm deleteReviewCk" data-confirm="구매평을 삭제하시겠습니까?" value="삭제">
										        	</div>
										        </c:if>
										        <br><br>
										        <c:if test="${r.revImage!=null }"><img src="${path}/resources/upload/review/${r.revImage }" style="max-width:40%; height:auto;min-width:auto;"/></c:if>
									      	</div>
									      </div>
									    </li>
									</c:forEach>    
								</ul>
								<div class="pageBar">
									<span>${pageBar }</span>
						    	</div>
							</c:if>
							<c:if test="${empty reviewlist }">
						    	등록된 구매평이 없습니다
						    </c:if>		    
			        	</div>
			        </div>
		    	</div><!-- 구매평 끝 -->
		    	
		    	<script>
		    	//구매평 아코디언
		    	//window.onload = init();
		    	function init() {
		    	    const accordion_items = document.querySelectorAll(".accordion_title");
		    	    for (var i = 0; i < accordion_items.length; i++) {
		    	      accordion_items[i].addEventListener("click", function () {
		    	        this.nextElementSibling.classList.toggle("show");
		    	        this.classList.toggle("active");
		    	        if (this.classList.contains("active")) {
		    	          this.nextElementSibling.style.height =
		    	            this.nextElementSibling.children[0].clientHeight + 40 + "px";
		    	        } else {
		    	          this.nextElementSibling.style.height = 0;
		    	        }
		    	      });
		    	    }
		    	  }
		    	</script>
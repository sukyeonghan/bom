<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!--줄바꿈 -->
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

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
    <script>
	    function fn_updateFaq(){
			let faqNo=$(event.target).parent().children('input[name=faqNo]').val();		
			location.replace("${path}/faq/updateFaq?faqNo="+faqNo);
		}; 
		function fn_deleteFaq(){
			let faqNo=$(event.target).parent().children('input[name=faqNo]').val();
			location.replace("${path}/faq/deleteFaq?faqNo="+faqNo);
		}; 
    </script>

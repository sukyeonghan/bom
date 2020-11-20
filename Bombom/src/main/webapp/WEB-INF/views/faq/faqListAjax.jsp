<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

      <!-- 제품관리 테이블 -->
     <div id="reply-table-wrap">
     <table id="reply-table" class="table table-hover" >
     <thead>
     <tr>
     <th>신고된 회원</th>
     <th>신고사유</th>
     <th>원문내용</th>
     <th>신고날짜</th>
     <th>신고처리현황</th>
     </tr>
     </thead>
     <tbody>
     <c:forEach var="b" items="${list }">
     <tr>
     <td><c:out value="${b.mem_nick}"/></td>
     <td><c:out value="${b.com_reason }"/></td>
     <td><c:out value="${b.reply_content }"/></td>
     <td><fmt:formatDate value="${b.com_date}" pattern="yyyy-MM-dd"/></td>
      <td> <span><c:out value="${b.com_status }"/></span>
      <input type="hidden" value="${b.memNo }" name="reply_id"/>
      <input type="hidden" value="${b.reply_id }" name="reply_id"/>
      <c:if test="${b.com_status eq 'N' }">
      <button class="btn btn-info memWarnYnBtn">신고접수</button>
      </c:if>
      <c:if test="${b.com_status eq 'Y' }">
      <button class="btn btn-outline-info memWarnYnBtn">신고거절</button>
     				 </c:if>
     			</td>
			</tr>
    	 </c:forEach>
   	<thead>
 </table>  
     <br>
     </div>
     
     	<!-- 페이징바 -->
				 <div class="pageBar" >	
					${pageBar }
				</div>
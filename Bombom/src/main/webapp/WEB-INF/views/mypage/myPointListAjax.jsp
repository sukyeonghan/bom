<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<table class="table table-hover">
    <thead>
      <tr>
        <th>날짜</th>
        <th>사유/내용</th>
        <th>포인트내역</th>
      </tr>
    </thead>
    <tbody>
    <c:if test="${not empty list}">
    	<c:forEach items="${list}" var="p">
	      <tr>
	        <td><fmt:formatDate type="both" timeStyle="short" value="${p.pointDate }"/></td>
	        <td>
	        	<!-- 주문번호 여부 체크 -->
	        	<c:if test ="${fn:contains(p.pointContent, '주문번호')}">
		        	<c:set var="start" value="${fn:indexOf(p.pointContent,'주문번호') }"/>
		        	<c:set var="end" value="${fn:indexOf(p.pointContent,')') }"/>
		        	<c:set var="orderNo" value="${fn:substring(p.pointContent,start+5,end) }"/>
		        	<a href="${path }/mypage/orderDetail?orderNo=${orderNo}"> 
		        		<c:out value="${p.pointContent }"/>
		        	</a>
	        	</c:if>
	        	
	        	<c:if test ="${not fn:contains(p.pointContent, '주문번호')}">
	        		<c:out value="${p.pointContent }"/>
	        	</c:if>
	        </td>
	        <td class="pointChange">
	        	<c:if test="${p.pointChange ge 0 }">
	        		<span style="color:green;"><c:out value="+${p.pointChange}봄"/></span>
	        	</c:if>
	        	<c:if test="${p.pointChange lt 0 }">
	        		<span style="color:red;"><c:out value="${p.pointChange}봄"/></span>
	        	</c:if>
	        </td>
	      </tr>
      	</c:forEach>
      </c:if>
      <c:if test="${empty list }">
      		<tr>
      			<td colspan="3"> 검색된 결과가 없습니다.</td>
      		</tr>
      </c:if>
    </tbody>
</table>
<br>

<div id="pageBar">
	${pageBar }
</div>  


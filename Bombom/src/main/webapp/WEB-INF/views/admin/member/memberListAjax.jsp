<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<table id="memberTbl" class="table table-hover">
<thead>
	<tr>
		<th>이메일</th>
		<th>닉네임</th>
		<th>적립금</th>
		<th>악성댓글</th>				
		<th>탈퇴여부</th>				
		<th>관리자여부</th>				
	</tr>
</thead>
<tbody>
	<c:forEach items="${list }" var="member" varStatus="vs">
		<tr>
			<td><c:out value="${member.memEmail }"/></td>
			<td><c:out value="${member.memNick }"/></td>
			<td><fmt:formatNumber type="number" value="${member.memPoint }"/></td>
			<c:if test="${member.memWarnCount >= 10}">
				<td id="black" >
				<a href="#" data-toggle="tooltip" data-placement="top" class="warnA" title="신고당한 횟수: ${member.memWarnCount}번">
				<strong class="text-danger">커뮤니티차단</strong></a></td>
			</c:if>
			<c:if test="${member.memWarnCount < 10}">
				<td><c:out value="(${member.memWarnCount}/10)"/></td>
			</c:if>
			<td><c:out value="${member.memStatus}"/></td>
			<td>
				<span><c:out value="${member.memManagerYn}"/></span>&nbsp;&nbsp;
				<input type="hidden" value="${member.memNo }" name="memNo"/>
				<c:if test="${member.memManagerYn eq 'N'}">
					<button class="btn btn-info managerYnBtn">권한부여</button>
				</c:if>
				<c:if test="${member.memManagerYn eq 'Y'}">
					<button class="btn btn-outline-info managerYnBtn">권한회수</button>
				</c:if>
			</td>
		</tr>
	</c:forEach>
	</tbody>
</table>
<br>
<div id="pageBar">
	${pageBar }
</div> 
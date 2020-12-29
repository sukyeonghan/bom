<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

			        <!-- 상품문의 게시글 -->
			        <div id="result">
				        <div class="container">
						    <c:if test="${not empty list }">	
					        <table class="table" style=" table-layout: fixed;">
						        <thead>
						        	<tr>
						        		<td style="width:10%;">상태</td>
						        		<td style="width:65%;">내용</td>
						        		<td style="width:20%;">문의날짜</td>
						        		<td style="width:15%;">작성자</td>
						        	</tr>
						        </thead>
								<c:forEach items="${list}" var="i">
						        	<thead>
						        		<tr>
						        			<td>
						        				<c:out value="${i.inqAnswerYn=='Y'?'답변완료':'답변대기'}"/>
						        			</td>					        		
						        			<td style="width:100%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						        				<c:if test="${i.inqSecret=='N'}">
						        					<a href="#" data-toggle="modal" data-target="#inquiryView" data-no='<c:out value="${i.inqNo}"/>' data-content='<c:out value="${i.inqContent }"/>'
						        						data-answeryn='<c:out value="${i.inqAnswerYn}"/>' data-date='<fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/>' data-memnick='<c:out value="${i.memNick}"/>'
						        						data-answer='<c:out value="${i.inqAnswer}"/>' data-answerdate='<fmt:formatDate type="both" timeStyle="short" value="${i.inqAnswerDate}"/>'
						        						data-secret='<c:out value="${i.inqSecret}"/>' data-memno='<c:out value="${i.memNo}"/>' data-loginno='<c:out value="${loginMember.memNo}"/>'>
						        						<c:out value="${i.inqContent }"/>
						        					</a>
						        				</c:if>
						        				<c:if test="${i.inqSecret=='Y' and (loginMember.memNo==i.memNo or loginMember.memManagerYn=='Y')}">
						        					<img src="${path}/resources/images/product/lock.png" style="width:20px;height:20px;">
						        					<a href="#" data-toggle="modal" data-target="#inquiryView" data-no='<c:out value="${i.inqNo}"/>' data-content='<c:out value="${i.inqContent }"/>'
						        						data-answeryn='<c:out value="${i.inqAnswerYn}"/>' data-date='<fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/>' data-memnick='<c:out value="${i.memNick}"/>'
						        						data-answer='<c:out value="${i.inqAnswer}"/>' data-answerdate='<fmt:formatDate type="both" timeStyle="short" value="${i.inqAnswerDate}"/>'
						        						data-secret='<c:out value="${i.inqSecret}"/>' data-memno='<c:out value="${i.memNo}"/>' data-loginno='<c:out value="${loginMember.memNo}"/>'>
						        						<c:out value="${i.inqContent }"/>
						        					</a>
						        				</c:if>
						        				<c:if test="${(i.inqSecret=='Y' and loginMember.memNo!=i.memNo and loginMember.memManagerYn=='N') or (i.inqSecret=='Y' and loginMember.memNo==null and loginMember.memManagerYn=='N')}">
						        					<img src="${path}/resources/images/product/lock.png" style="width:20px;height:20px;">
						        					<a href="#" onclick="secretCk();">
						        					<c:out value="${i.inqContent }"/></a>
						        				</c:if>					        		
						        			</td>
						        			<td><fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/></td>
						        			<td>
						        				<c:out value="${i.memNick}"/>
						        			</td>
						        		</tr>
						        	</thead>
						        </c:forEach>
						    	</table>
						        <div class="pageBar">
									<span>${pageBar }</span>
						    	</div>
					        </c:if>
					        <c:if test="${empty list }">
					        <table>
					        	<thead>
					        		<tr>
					        			<td colspan="4">등록된 문의가 없습니다</td>
					        		</tr>
					        	</thead>
					        </table>
					        </c:if>
				        </div><!-- 상품문의 게시글 끝 -->			        
			    	</div><!-- result 끝 -->
			    	
	
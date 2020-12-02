<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!-- <div id="result"> -->
			        <div class="container col-lg-11">
				        <table class="table">
					        <thead>
					        	<tr>
					        		<td style="width:60%;">내용</td>
					        		<td style="width:15%;">문의날짜</td>
					        		<td style="width:15%;">작성자</td>
					        		<td style="width:10%;">상태</td>
					        	</tr>
					        </thead>
					    <c:if test="${not empty list }">	
							<c:forEach items="${list}" var="i">
					        	<thead>
					        		<tr>
					        			<td>
					        				<c:if test="${i.inqSecret=='N'}">
					        					<a href="${path}/product/inquiryView?inqNo=${i.inqNo}" onclick="open(this.href,'','top=100px,left=300px,width=600px,height=400px,scollbars=no');return false;">
					        						<c:out value="${i.inqContent }"/>
					        					</a>
					        				</c:if>
					        				<c:if test="${i.inqSecret=='Y'}">
					        					<img src="${path}/resources/images/product/lock.png" style="width:20px;height:20px;"> 
					        					비밀글입니다
					        				</c:if>
					        			</td>
					        			<script>
						        			//상품문의 상세창
						        			function inquiry_view(){
						        				const url="${path}/product/inquiryView?inqNo=${i.inqNo}";
						        				const status = "top=100px, left=300px, widht=600px; height=400px";
						        				open(url,"",status);
						        			}
					        			
					        			</script>
					        			
					        			
					        			<td><c:out value="${i.inqDate }"/></td>
					        			<td>
					        				<c:out value="${i.memNick}"/>
					        			</td>
					        			<td>
					        				<c:if test="${i.inqAnswerYn=='N'}">
					        					답변대기
					        				</c:if>
					        				<c:if test="${i.inqAnswerYn=='Y'}">
					        					답변완료
					        				</c:if>
					        			</td>
					        		</tr>
					        	</thead>
					        </c:forEach>
				        </c:if>
				        <c:if test="${empty list }">
				        	<thead>
				        		<tr>
				        			<td colspan="4">등록된 문의가 없습니다</td>
				        		</tr>
				        	</thead>
				        </c:if>
				        </table>
			        </div><!-- 상품문의 게시글 끝 -->
			        <div id="pageBar">
						${pageBar }
			    	</div>
<!-- </div> -->


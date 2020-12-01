<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	table#memberTbl th{text-align:center;}
	table#memberTbl td{vertical-align: middle;}
	table#memberTbl td{text-align:center;}
	table#memberTbl td:nth-of-type(1){text-align:left;}
	table#memberTbl td:nth-of-type(3){text-align:right;}
	
	.warnA:hover{text-decoration: none;}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container" class="container">
	<div class="media">
		<!--관리자 내비게이션바 -->
		<div id="" class=" mr-3 admin-nav">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link select" href="${path }/">회원관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/admin/moveProduct">제품관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">주문관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">1:1문의관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">이벤트관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">커뮤니티관리</a>
		    </li>
		  </ul>
		</div>
		
		<div id="admin-container" class="media-body">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">회원관리</h3> 
			<div class="table-responsive ">
				<table id="memberTbl" class="table table-hover">
					<thead>
						<tr>
							<th>이메일</th>
							<th>닉네임</th>
							<th>적립금</th>
							<th>악성댓글</th>				
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
								<td>
									<c:out value="${member.memManagerYn}"/>&nbsp;&nbsp;
									<input type="hidden" value="${member.memNo }" name="memNo"/>
									<c:if test="${member.memManagerYn eq 'N'}">
										<button class="btn btn-info admin">권한부여</button>
									</c:if>
									<c:if test="${member.memManagerYn eq 'Y'}">
										<button class="btn btn-outline-info member">권한회수</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div id="pageBar">
					${pageBar }
	    		</div> 
			</div>
			
			<!-- 검색 -->
			
		</div>
	</div>
</section>
<script>
	$(function(){
		 $('[data-toggle="tooltip"]').tooltip();   
	})

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
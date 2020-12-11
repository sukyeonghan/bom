<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<style>
	#flexDiv{display:flex; padding: 0px 10% 0px 10%;}
	#mypage-container{min-width:800px; width:100%;}
	.right{text-align: right;}
	#mypage-container table{text-align:center;}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container">
			<div style="display:flex; justify-content: space-between; margin-bottom:20px;">
				<h3>적립금</h3> 
				<h5>총 적립금:&nbsp;<strong><fmt:formatNumber type="number" value="${loginMember.memPoint }"/></strong>봄</h5>
			</div>
			<table class="table table-hover">
			    <thead>
			      <tr>
			        <th>날짜</th>
			        <th>사유/내용</th>
			        <th>포인트내역</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:forEach items="${list}" var="p">
				      <tr>
				        <td><fmt:formatDate type="both" timeStyle="short" value="${p.pointDate }"/></td>
				        <td>
				        	<c:out value="${p.pointContent }"/>
				        	<c:if test="${p.orderNo != null}">
				        		<a href="#"><c:out value="(주문번호: ${p.orederNo })"/></a>
				        	</c:if>
				        </td>
				        <td class="pointChange"><fmt:formatNumber type="number" value="${p.pointChange }"/></td>
				      </tr>
			      	</c:forEach>
			    </tbody>
			</table>
			<div id="pageBar">
				${pageBar }
	    	</div> 
		</div>
		
		
		
	</div>
</section>
<script>
	//포인트 내역이 양수,음수에 따라 표시,글자색 달리하기
	$(".pointChange").each((i,item)=>{
           let text=$(".pointChange").eq(i).html();
           let a=text.substr(0,1);
           if(a=="-"){
           	$(".pointChange").eq(i).html(text+"봄");
			$(".pointChange").eq(i).css("color","red");
           }else{
           	$(".pointChange").eq(i).html("+"+text+"봄");
			$(".pointChange").eq(i).css("color","green");
           }
       });
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
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
	.table th,.table td{text-align:center; }  
	.table td{vertical-align: middle;}
	.table td[class=addressTd]{text-align:left; } 
	.sm{font-size: 0.8em; color:gray;}
</style>

<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container"  >
			<div style="display:flex; justify-content: space-between; margin-bottom:20px;">
				<h3>배송지관리</h3> 
				<button class="btn btn-success" onclick="fn_addShip();">배송지 등록</button>
			</div>
			<div class="table-responsive ">
			<table class="table table-hover">
			    <thead>
			      <tr>
			        <th>배송지</th>
			        <th>주소</th>
			        <th>연락처</th>
			        <th>수정/삭제</th>
			      </tr>
			    </thead>
			    <tbody>
			    	<c:if test="${!empty list}">
				    	<c:forEach items="${list}" var="s">
					      <tr class="">
					        <td class="">
						        <strong><c:out value="${s.shipLocalName }"/></strong><br>
						        
						        <c:out value="${s.shipRecipient}"/><br>
						        
						        <c:if test="${s.shipYn == 'Y'}">
							        <span class="badge badge-pill badge-success">기본배송지</span>
					        	</c:if>
					        	
					        </td>
					        <td class="addressTd">
					        	<span class="sm">(우) <c:out value="${s.shipZipCode }"/></span><br>
					        	<c:out value="${s.shipAddress }"/><br>
					        	<c:out value="${s.shipDetailAddress}"/>
					        	<c:out value="${s.shipExtraAddress }"/><br>
					        </td>
					        <td><c:out value="${s.shipPhone }"/></td>
					        <td>
					        	<input type="hidden" value="${s.shipNo }" name="shipNo">
					        	<button class="btn btn-outline-success updateBtn">수정</button>
					        	<button class="btn btn-outline-secondary" onclick="location.replace('${path}/ship/deleteShip?shipNo=${s.shipNo }')">삭제</button>
					        </td>
					      </tr>
				      	</c:forEach>
			      	</c:if>
			      	<c:if test="${empty list }">
			      		<tr>
			      			<td colspan="4">등록된 배송지가 없습니다.</td>
			      		<tr>
			      	</c:if>
			    </tbody>
			  </table>
			</div>
		</div>
	</div>
	<form action="" name="insertShip" method="post">
		<input type="hidden" name="memNo" value="${loginMember.memNo }">
	</form>
	
</section>

<script>
	
	function fn_addShip(){
		var memNo=$("input[name=memNo]").val();
		const url="${path}/ship/insertShip"; 
        const title="insertShip";
        const status="width=480px,height=605px,top=100px,left=500px";
        window.open(url,title,status);
        
        insertShip.target=title;
        insertShip.action=url;
        insertShip.memNo.value=memNo;
        insertShip.submit();
	
	}
	
$(function(){
	$(".updateBtn").click(e=>{
		var shipNo=$(e.target).parent().children("input[name=shipNo]").val();
		const url="${path}/ship/updateShip?shipNo="+shipNo;
		const status="width=480px,height=605px,top=100px,left=500px";
        window.open(url,"",status);

	});
});


	
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
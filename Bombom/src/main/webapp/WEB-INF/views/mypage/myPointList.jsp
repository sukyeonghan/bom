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
	/*좌측메뉴*/
	#mypage-nav{padding-right:100px;}
	#mypage-nav a{color:black;font-weight:bolder;}
	#mypage-nav a:hover{color: #45A663;}

	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	.right{text-align: right;}
	.media-body table{text-align:center;}
</style>
<section id="container" class="container">
	<div class="media">
		<!-- 좌측 메뉴 -->
		<div id="mypage-nav" class=" mr-3">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link" href="${path }/mypage/orderStatus">주문내역</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/qna">1:1문의</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link" href="${path }/mypage/myActivity">나의 활동</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link" href="${path }/mypage/stamp">스탬프</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/zzimList">찜목록</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/updateMember">회원정보수정</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/shipList">배송지관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/myPointList">적립금</a>
		    </li>
		  </ul>
		</div>
		
		<!--좌측메뉴선택시 화면 -->
		<div id="mypage-container" class="media-body">
			<h3>적립금</h3> 
			<br>
			<h5 class="right">총 적립금:&nbsp;<strong><fmt:formatNumber type="number" value="${loginMember.memPoint }"/></strong>봄</h5>
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
           if(text<0){
           	$(".pointChange").eq(i).html("-"+text+"봄");
			$(".pointChange").eq(i).css("color","red");
           }else{
           	$(".pointChange").eq(i).html("+"+text+"봄");
			$(".pointChange").eq(i).css("color","green");
           }
       });
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
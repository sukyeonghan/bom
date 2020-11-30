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
	
	/*스탬프 찍기칸*/
	#stampBigdiv{width:100%; text-align:center; margin-top:20px;}
	.stamp{width: 19%; padding: 3%; display: inline-table;}
	.stamp.up:hover{
		  position: relative;
		  top: 5px;
		  animation: bounce .3s ease infinite alternate;
	}
	@keyframes bounce {100% {top: -5px;}}
	#giftBtn{margin-top: 30px; padding: 10px; font-size: 20px;}
	/*모달창*/
	img#stamp-modal-img{width:80%;}
	.nickColor{color:#45A663; font-size: 1.2em; }
	#StampCheckBtn{margin:0; padding: 10px;}
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
			
			<img alt="스탬프안내사항" src="${path }/resources/images/stamp/stampInfo.png" width="100%">
			<c:if test="${loginMember.memBuyCount >= 10}">
				<div style="text-align:center;">
					<button id="giftBtn" class="btn btn-success btn-block" data-toggle="modal" data-target="#stampModal">선물받으러 가자!</button>
				</div>
			</c:if>
			<!-- 스탬프칸 -->
			<div id="stampBigdiv">
				<c:forEach begin="1" end="${loginMember.memBuyCount }" step="1" varStatus="vs">
					<td><img class="stamp up" alt="엣헴이도장" src="${path }/resources/images/stamp/stamp${vs.index}.png"></td>
				</c:forEach>
				<c:forEach begin="1" end="${10-loginMember.memBuyCount }" step="1">
					<td><img class="stamp" alt="잠금도장" src="${path }/resources/images/stamp/stamp0.png"></td>
				</c:forEach>
			</div>
			
		</div>
		
		
		<!-- The Modal -->
		  <div class="modal fade" id="stampModal">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      	
		        <div class="modal-header">		
            		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
            			<span aria-hidden="true">X</span>
            		</button>
            	</div>
            	<!-- Modal body -->
		        <div class="modal-body" style="text-align:center;">
		        	<br>
		        	<h4><strong class="nickColor"><c:out value="${loginMember.memNick }"/></strong>님 축하합니다!</h4>
		        	<br>
		        	<%
		        		int bom=0;
		        		int r=(int)(Math.random() *100*100);
		        		if(r<=20){
		        			bom=1000;
		        		}else if(20<r&&r<=70){
		        			bom=3000;
		        		}else{
		        			bom=5000;
		        		}
		        	
		        	%>
		        	<c:if test="<%=bom=1000 %>">
		        		<img id="stamp-modal-img" src="${path }/resources/images/stamp/stamp10ok1.png" alt="축하합니다. 1000봄 지급됩니다.">
		        	</c:if>
		        		<c:if test="<%=bom=3000 %>">
		        	<img id="stamp-modal-img" src="${path }/resources/images/stamp/stamp10ok2.png" alt="축하합니다. 3000봄 지급됩니다.">
		        		</c:if>
		        	<c:if test="<%=bom=5000 %>">
		        		<img id="stamp-modal-img" src="${path }/resources/images/stamp/stamp10ok3.png" alt="축하합니다. 5000봄 지급됩니다.">
		        	</c:if>
		        </div>
		        
		        <!-- Modal footer -->
		        <div class="modal-footer">
		          <form action="/mypage/stamp10" method="post">
		          	<input type="hidden" value="<%=bom %>" name="pointChange">
		          	<input type="hidden" value="${loginMember.memNo }" name="memNo">
		          	<button type="submit" id="StampCheckBtn" class="btn btn-success btn-block">확인</button>
		          </form>
		        </div>
		        
		      </div>
		    </div>
		  </div>
		
		
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
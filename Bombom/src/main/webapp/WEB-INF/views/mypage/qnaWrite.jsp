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
	
	/*버튼 가운데정렬*/
      .btn-box{text-align: center;}
        }
    /* 테두리 */
        div#qna-container{
          width:80%;
          padding:20px;
          margin:auto;
          border:1px #45A663 solid ;
          border-radius: 10px;
        }    
	
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
		<div id="qna-container" class="media-body">
			<form action="${path }/mypage/insertQna" method="post">
            <h3>1:1 문의글 작성</h3>
            <br>
            <c:if test="${loginMember!=null }">
            	<input type="hidden" value="${loginMember.memNo }" name="qnaWriter">
			</c:if>
            <!--문의 카테고리  -->
            <div class="form-group">
              <select class="form-control" id="category" name="qnaCategory" required>
              	<option value="" disabled selected>카테고리 선택</option>
                <option value="주문/결제" >주문/결제</option>
                <option value="배송">배송</option>
                <option value="취소/환불">취소/환불</option>
                <option value="기타">기타</option>
              </select>
            </div> 
           
            <!-- 제목 -->
            <div class="form-group">
              <input type="text" class="form-control" id="title" placeholder="제목" name="qnaTitle" required/>
            </div>
            
            <div class="form-group">
              <textarea
                class="form-control"
                rows="10"
                id="contents"
                placeholder="문의할 내용을 작성해주세요."
                name="qnaContent"
                required
              ></textarea>
            </div>
            <div class="btn-box">
              <button type="button" class="btn btn-outline-secondary" onclick="location.replace('${path}/mypage/qna')">목록으로</button>
              <button type="submit" class="btn btn-success">작성완료</button>
        	</div>
        	</form>
         </div>
            
 </div>
</section>
<script>


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
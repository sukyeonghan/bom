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
	
	/* 글쓰기 버튼 오른쪽정렬 */
    #btn-container {
      text-align: right;
    }
    /* 페이지 들어갈 곳 */
    #page-bar {
      text-align: center;
      margin-top: 30px;
    }
    /*제목 호버  */
	td>a:hover{
	color: #3b9156;
	text-decoration: none;
	}
	/*삭제버튼 */
	.deleteBtn{
		text-align: center;
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
          <h3>1:1문의</h3>
          <br />
          <table class="table">
            <thead>
              <tr>
                <th>번호</th>
                <th>문의유형</th>
                <th>제목</th>
                <th>문의날짜</th>
                <th>답변여부</th>
              </tr>
            </thead>
            <tbody>
             <c:if test="${empty list }">
	        	<thead>
	        		<tr>
	        			<td colspan="5">등록된 문의가 없습니다</td>
	        		</tr>
	        	</thead>
		      </c:if>
            <c:forEach items="${list}" var="q">
            <c:if test="${q.qnaWriter eq loginMember.memNo}" >
              <tr>
                <td><c:out value="${q.rownum}"/></td>
                <td><c:out value="${q.qnaCategory}" /></td>
                <td><a href="" data-toggle="modal" data-target="#qnaView" class="qnaTitle"><c:out value="${q.qnaTitle}" /></a></td>
                <td><fmt:formatDate type="date" value="${q.qnaDate }"/></td>
                <td>
               		<c:out value="${q.qnaYn=='Y'?'답변완료':'답변대기' }"/>
                </td>
                <td style="visibility:hidden;"><c:out value="${q.qnaContent }"/></td>
                <td hidden><c:out value="${q.qnaAnswer }"/></td>
                <td hidden><fmt:formatDate type="both" timeStyle="short" value="${q.qnaAnswerDate }"/></td>
                <td hidden><c:out value="${q.qnaNo }"></c:out></td>
              </tr>
            </c:if>
       		</c:forEach>
            </tbody>
          </table>
          <div id="page-bar">${pageBar }</div>
    	  <div id="btn-container">
   			  <button type="button" class="btn btn-success" onclick="location.replace('${path}/mypage/qnaWrite')">문의작성</button>
     	  </div>
          
        <!--1:1문의 모달창 -->
		  <div class="modal fade" id="qnaView" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		    <div class="modal-dialog">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h5 class="modal-title qTitle"></h5>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
          <!-- Modal body -->
	        <div class="modal-body container">
	        	<!-- 문의 카테고리 -->
	        	<div class="form-group">
           		   <input type="text" class="form-control qCategory" readonly/>
            	</div>
            <!--문의내용  -->
           		 <div class="form-group">
		              <textarea
		                class="form-control qContent"
		                rows="5"
		                readonly
		              ></textarea>
            	</div>

	       <!-- 상품문의 관리자 답변 내용 -->
	      		 <div class=answerContainer>
	       			<strong><span>관리자 답변</span></strong>&nbsp;&nbsp;<span class="answerDate"></span><br>
			       	  <div class="form-group">
				            <textarea
				              class="form-control qAnswer"
				              rows="5"
				              readonly
				            ></textarea>
		             </div>
		         </div>
	        		<div class="deleteBtn">
	        		   	<input type="hidden" class="qNo" name="qnaNo" readonly>
	        			<input type="button" class="btn btn-outline-success btn-sm deleteQna " value="삭제"><br>
					</div>
		    </div>
	         
	      	  </div>
			</div>
		</div>
	     
	
    </div>
</div>	
</section>
<script>
				//제목 클릭시 모달창으로 세부내용 보여줌 
	        	$(".qnaTitle").click(function(){
	        		let tr=$(this).parent().parent();
	        		let td= tr.children();
	        		
	        		let qnaNo=td.eq(8).text();
	        		let category = td.eq(1).text();
	        		let title=td.eq(2).text();
	        		let qnaYn=td.eq(4).text();
	        		let content=td.eq(5).text();
	        		let qnaAnswer=td.eq(6).text();
	        		let answerDate=td.eq(7).text();
	        		$(".qNo").val(qnaNo);
	        		$(".qCategory").val(category); //카테고리
	        		$(".qTitle").text(title); //문의제목
	        		$(".qContent").val(content); //문의내용
	        		$(".qAnswer").val(qnaAnswer); //관리자답변
	        		$(".answerDate").text(answerDate); //관리자 답변날짜
	        		
	        		//관리자 답변여부에 따라 보여주기/숨기기
	        		if(qnaYn.match('답변대기')){
	        			$(".answerContainer").hide();
	        		}else{
	        			$(".answerContainer").show();
	        		}
	        	
	        		//삭제
		        	$(".deleteQna").click(function(e){
		        		e.stopPropagation();
						let check = confirm("삭제하시겠습니까?");
        				let qnaNo = $(e.target).parent().children('input[name=qnaNo]').val();
        				console.log(qnaNo);
	    				if(check){
	    					location.replace("${path}/mypage/deleteQna?qnaNo="+qnaNo);
	    				}
	        			

		        	});
	        		
	        	});
				
			
	        	
				
	        	</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
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
	 /*제목 호버  */
	td>a:hover{
	color: #3b9156;
	text-decoration: none;
	}
	/*수정,삭제버튼 */
	.btnBox{
	display: flex;
	justify-content:center;
	}
	.insertQna, .editQna{
	margin-left:10px;
	width:63px;
	height: 29px;
	}
	.deleteQna{
	width: 74px;
	height: 29px;
	}	
	
 	 /* 테이블 */
     .table th, .table td{
       text-align:center;
       vertical-align:middle;
     }
     .table .th{
       vertical-align:middle;
     }

</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="1:1문의" />
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
		     	 <a class="nav-link non-select" href="${path }/admin/order">주문관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/admin/qnaList">1:1문의관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">이벤트관리</a>
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
                <th>문의자</th>
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
              <tr>
                <td><c:out value="${q.rownum}"/></td>
                <td><c:out value="${q.qnaCategory}" /></td>
                <td><a href="" data-toggle="modal" data-target="#qnaView" class="qnaTitle" onclick="fn_qnaDetail();"><c:out value="${q.qnaTitle}" /></a></td>
                <td><c:out value="${q.qnaWriter }"/></td>
                <td><fmt:formatDate type="both" timeStyle="short" value="${q.qnaDate }"/></td>
                <td><c:out value="${q.qnaYn}" /></td>
                <td style="display:none"><c:out value="${q.qnaContent }"/></td>
                <td style="display:none"><c:out value="${q.qnaAnswer }"/></td>
                <td style="display:none"><fmt:formatDate type="both" timeStyle="short" value="${q.qnaAnswerDate }"/></td>
                <td style="display:none"><c:out value="${q.qnaNo }"></c:out></td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
          <div id="page-bar">${pageBar }</div>
          <div id="btn-container">
            <button type="button" class="btn btn-success" onclick="location.replace('${path}/admin/qnaDelete')">선택삭제</button>
          </div>
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
           		   <input type="text" class="form-control qCategory" disabled/>
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
	      		 <form name="frm_qnaAnswer" action="${path }/admin/qnaAnswer" onsubmit="return fn_answerCk()">
	      		 <div class=answerContainer>
	       			<strong><span>관리자 답변</span></strong>&nbsp;&nbsp;<span class="answerDate"></span><br>
			       	  <div class="form-group">
				            <textarea
				              class="form-control qAnswer"
				              rows="5"
				              name="qnaAnswer"
				            
				            ></textarea>
		             </div>
		         </div>
	        		<div class="btnBox">
	        		   	<input type="hidden" class="qNo" name="qnaNo" readonly>
	        			<input type="button" class="btn btn-outline-success btn-sm deleteQna " value="문의글 삭제"><br>	        			
	        		   	<input type="submit" class="btn btn-success btn-sm insertQna " value="답변등록"><br>
	        		   	<input type="hidden" class="btn btn-success btn-sm editQna " value="답변수정">

					</div>
	        	 </form>
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
			
			
			let category=td.eq(1).text();
			let title=td.eq(2).text();
			let qnaYn=td.eq(5).text();
			let content=td.eq(6).text();
			let qnaAnswer=td.eq(7).text();
			let answerDate=td.eq(8).text();
			let qnaNo=td.eq(9).text();
			
			$(".qNo").val(qnaNo); //문의 고유번호
			$(".qCategory").val(category); //카테고리
			$(".qTitle").text(title); //문의제목
			$(".qContent").val(content); //문의내용
			$(".qAnswer").val(qnaAnswer); //관리자답변
			$(".answerDate").text(answerDate); //관리자 답변날짜 
			
			//관리자 답변이 있으면 수정버튼 보이고, 없으면 숨기기 
			if(qnaYn.match("Y")){
				$(".qAnswer").attr("disabled",true);
				$(".editQna").attr("type","button");
				$(".insertQna").hide();
			}else{
				$(".qAnswer").attr("disabled",false);
				$(".editQna").attr("type","hidden");
				$(".insertQna").show();
			}
			//답변 수정할때 
			if(qnaYn.match("Y")){
			$(".editQna").click(function(){
				$(".qAnswer").removeAttr("disabled");
				$(".editQna").attr("type","hidden");
				$(".insertQna").show();
			})
			}
			
		});
		

		
		function fn_answerCk(){
			if($(".qAnswer").val()=="") {
				swal("답변을 입력해주세요");
				return false;
			}
			return true;
		}
	
		
</script>




<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
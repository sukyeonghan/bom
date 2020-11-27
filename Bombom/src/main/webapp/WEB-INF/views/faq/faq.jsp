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
	#left-nav{padding-right:100px;}
	#left-nav a{color:black;font-weight:bolder;}
	#left-nav a:hover{color: #45A663;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	h3{text-align: center;}
	div#main-container{
		width:80%;
		padding:40px;
		margin:auto;
		border:1px #45A663 solid ;
		border-radius: 10px;
	}
	/*버튼 가운데정렬*/
	.btn-box{text-align: center;}
	/*버튼크기고정*/
	.btn{width: 100px;}
</style>
<section id="container" class="container">
	
	<div class="media">
	
		<!-- 좌측 메뉴 -->
		<div id="left-nav" class=" mr-3">
		  <ul class="nav flex-column">
		    <li class="nav-item">
		      <a class="nav-link" href="${path }/notice/noticeList">공지사항</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link " href="${path }/faq/faqList">자주묻는질문</a>
		    </li>
		  </ul>
		</div>
	

	<div id="main-container" class="media-body">
		<h3>자주묻는 질문 등록/수정</h3>
		<br>
		<!-- faq값이 없을 때는 등록, faq 값이 넘어왔을떄는  수정 -->
		<c:if test="${empty faq }">
			<form name="faqFrm" action="${path }/faq/insertFaq" onsubmit="return fn_check()">
		</c:if>
		<c:if test="${not empty faq }">
			<form name="faqFrm" action="${path }/faq/updateFaqEnd" onsubmit="return fn_check()">
		</c:if>
			<c:if test="${not empty faq }">
				<input type="hidden" value="${faq.faqNo }" name="faqNo">
			</c:if>
			

			<select id="cate" name="faqCategory" class="form-control"  required> 
					<option value=" " disabled selected>카테고리선택</option>
					<option value="주문/결제" ${faq.faqCategory eq "주문결제"?"selected":""} >주문/결제</option>
					<option value="배송" ${faq.faqCategory eq "배송"?"selected":""}>배송</option>
					<option value="취소/환불" ${faq.faqCategory eq "취소/환불"?"selected":""}>취소/환불</option>
					<option value="기타" ${faq.faqCategory eq "기타"?"selected":""}>기타</option>
			</select>
	
				<br>
				<input type="text" class="form-control" name="faqTitle" placeholder="제목을 입력해주세요" value='<c:out value="${faq.faqTitle }"/>' required>
				<br>
				<textarea class="form-control" rows="10" name="faqContent" placeholder="내용을 입력해주세요" required><c:out value="${faq.faqContent }"/></textarea>
				<br>
				<div class="btn-box">
					
					<input type="button" class="btn btn-outline-success" value="목록으로" onclick="location.replace('${path }/faq/faqList')">&nbsp;&nbsp;
					
					<c:if test="${empty faq }">
						<input type="submit" class="btn btn-success" value="등록">
					</c:if>
					<c:if test="${not empty faq }">
						<input type="submit" class="btn btn-success" value="수정 ">
					</c:if>

				</div>
				
			</form>
		</div>
	</div>
</section>
<script>
	
	function fn_check(){
		
		if(faqFrm.faqCategory.value==" ") {
			swal("카테고리를 선택해주세요.");
			return false;
		}
		return true;
	}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
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
	h3{text-align: center;}
	section{margin-top:220px;}
	div#faq-container{
		width:80%;
		padding:20px;
		margin:auto;
		border:1px #45A663 solid ;
		border-radius: 10px;
	}
	div#btn-box{
		text-align: center;
	}
</style>
<section id="content" class="container">
	
	<h3>자주묻는 질문 등록/수정</h3>
	<br>
		<div id="faq-container">
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
			<c:if test="${empty faq }">
				<select id="cate" name="faqCategory" class="form-control"  required> 
					<option value=" " disabled selected>카테고리선택</option>
					<option value="주문/결제">주문/결제</option>
					<option value="배송">배송</option>
					<option value="취소/환불">취소/환불</option>
					<option value="기타">기타</option>
				</select>
			</c:if>
			
			<!-- 수정시 카테고리 선택되어 출력하게 하기 -->
			<c:if test="${not empty faq }">
				<select id="cate" name="faqCategory" class="form-control"  required> 
					<option value="주문/결제" ${faq.faqCategory eq "주문결제"?"selected":""} >주문/결제</option>
					<option value="배송" ${faq.faqCategory eq "배송"?"selected":""}>배송</option>
					<option value="취소/환불" ${faq.faqCategory eq "취소/환불"?"selected":""}>취소/환불</option>
					<option value="기타" ${faq.faqCategory eq "기타"?"selected":""}>기타</option>
				</select>
			</c:if>
			
			
				<br>
				<input type="text" class="form-control" name="faqTitle" placeholder="제목을 입력해주세요" value='<c:out value="${faq.faqTitle }"/>' required>
				<br>
				<textarea class="form-control" rows="10" name="faqContent" placeholder="내용을 입력해주세요" required><c:out value="${faq.faqContent }"/></textarea>
				<br>
				<div id="btn-box">
					
					<input type="button" class="btn btn-outline-success" value="목록으로" onclick="location.replace('${path }/faq/faqList')">&nbsp;&nbsp;
					
					<c:if test="${empty faq }">
						<input type="submit" class="btn btn-success" value="등록">
					</c:if>
					<c:if test="${not empty faq }">
						<input type="submit" class="btn btn-success" value="수정">
					</c:if>

				</div>
				
			</form>
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
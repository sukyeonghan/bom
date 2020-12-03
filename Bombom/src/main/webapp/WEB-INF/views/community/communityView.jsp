<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="notice" value="공지사항 본인 상세보기" />
</jsp:include>
<style>
h3 {
	text-align: center;
}

section {
	margin-top: 220px;
}

div#community-container {
	width: 80%;
	padding: 20px;
	margin: auto;
	border: 1px #45A663 solid;
	border-radius: 10px;
}

div#btn-box {
	text-align: center;
}
</style>
<section id="content" class="container">
	
	<h3> <c:out value="${community.cmWriter}"/> 님의 다시봄 </h3>
	<br>
	<div id="community-container">
		
		
			
				<input type="hidden" value="${community.cmNo }" name="cmNo">

				<br>
				<input type="text" class="form-control" name="cmTitle" placeholder="제목을 입력해주세요" value='<c:out value="${community.cmTitle }"/>' required>
				<br>
				<textarea id="editor" class="form-control" rows="10" name="cmContent" placeholder="내용을 입력해주세요" required><c:out value="${community.cmContent }"/></textarea>
				<br>
				
				<!-- 해당 게시글 작성자에게만 수정 / 삭제 버튼 보인다 --> 
				
				<div id="btn-box">
				 <c:if test="${loginMember.memNo eq community.cmWriter }">
					<input type="hidden" value="${community.cmNo }"
						name="cmNo" />
						<button class="btn btn-outline-success"
							onclick="fn_updateCommunity();">수정</button>
						<button class="btn btn-outline-secondary"
							onclick="fn_deleteCommunity();">삭제</button>
							</c:if>
				</div>

		</div>
		
</section>
<script>
function fn_updateNotice(){
		let noticeNo=$(event.target).parent().children('input[name=noticeNo]').val();		
		location.replace("${path}/notice/updateNotice?noticeNo="+noticeNo);
	}; 
		
	function fn_deleteCommunity(){
		let cmNo=$(event.target).parent().children('input[name=cmNo]').val();
		location.replace("${path}/community/deleteCommunity?cmNo="+cmNo);
	}; 
	</script>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
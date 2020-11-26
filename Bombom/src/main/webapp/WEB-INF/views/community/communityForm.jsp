<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<script type="text/javascript" src="${path}/resources/ckeditor/ckeditor.js" charset="utf-8"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="커뮤니티 등록" />
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
/* ckeditor */
.ck.ck-editor {
	max-width: 1000;
}

.ck-editor_editable {
	min-height: 500px;
}
</style>
<section id="content" class="container">
	<h3>
		당신의 <a href="${path }">다시:봄</a> 을 공유해주세요 :-)
	</h3>
	<c:if test="${not empty community }">
			<form name="communityFrm" action="${path }/community/updateCommunityEnd" onsubmit="return fn_check()">
		</c:if>
	<c:if test="${not empty community }">
				<input type="hidden" value="${community.cmNo }" name="cmNo">
			</c:if>
	
	<br>
	<div id="community-container" class="media-body">
	<form name="communityFrm" action="${path }/community/insertCommunity" onsubmit="return fn_check()">
		<br> <input type="text"
			class="form-control" name="cmTitle" placeholder="제목을 입력해주세요" value='<c:out value="${community.cmTitle }"/>' required><br>
		<%-- <input type="hidden" class="form-control" name="cmDate" value="${community.cmDate }"> <br> --%>
		<input type="hidden" name="cmWriter" value="${loginMember.memNo }" >
		<input type="number" class="form-control" name="cmLike"
			placeholder="좋아요" required> <br> <input type="number"
			class="form-control" name="cmView" placeholder="조회" required>
		<br> <input type="text" class="form-control" name="cmThumbnail"
			placeholder="썸네일" required> <br> <input type="text"
			class="form-control" name="cmWriter" placeholder="닉네임" value="${loginMember.memNick }" readonly>
		<br>
		<div class="input-group-prepend" style="padding: 0px;">
			<span class="input-group-text">썸네일</span>
		</div>
		<!-- <div class="custom-file">
                    <input type="file" class="custom-file-input" name="upFile" id="upFile1">
                    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
                </div> -->
		<br> <br>
		<p>다시봄 내용</p><br>
		<textarea name="cmContent" id="cmContent" rows="10" cols="100"></textarea>
		<br>
		<div id="btn-box">

			<input type="button" class="btn btn-outline-success" value="목록으로"
				onclick="location.replace('${path }/community/communityList')">&nbsp;&nbsp;
                 
                <c:if test="${empty community }">
				<input type="submit" class="btn btn-success" value="등록">
				</c:if>
				<input type="hidden" value="${community.cmNo }"
						name="cmNo" />
						<button class="btn btn-outline-success"
							onclick="fn_updateCommunity();">수정</button>
				
			</div>
		</div>
</section>
<script>

$(function(){
	CKEDITOR.replace('cmContent',{
		filebrowserUploadUrl:'${path }/adm/fileupload.do'
	});
});     					
    

function fn_check(){
	
	return true;
}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
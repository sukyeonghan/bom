<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<script src="//cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="커뮤니티 등록" />
</jsp:include>
<script src="${path }/WEB-INF/views/ckeditor/ckeditor.js"></script>
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
.title{
font-weight: 800;
font-size: 35px;
}
</style>
<section id="content" class="container">
	<h3>
		<c:out value="${loginMember.memNick}" />
		님의 다시:봄 을 공유해주세요 :-)
	</h3>
	<c:if test="${not empty community }">
		<form name="communityFrm" action="${path }/community/updateCommunityEnd" onsubmit="return fn_check()">
	</c:if>
	
	<c:if test="${not empty community }">
		<input type="hidden" value="${community.cmNo }" name="cmNo">
	</c:if>
	<br>
	<div id="community-container" class="media-body">
		<form name="communityFrm" action="${path }/community/insertCommunity" enctype="multipart/form-data" method="post" onsubmit="return fn_check()">
			<br> 
			<input type="text" class="form-control w3-input title" name="cmTitle" placeholder="제목을 입력해주세요" required>
			  <br>
				
			<br>
				<input type="file" id="image" name="upFile" onchange="setThumbnail(event);"/>
				<br>
				 <div id="image_container"></div>  
				 <br>
				 <script> function setThumbnail(event) { 
					      var reader = new FileReader(); reader.onload = function(event) { 
					      var img = document.createElement("img"); 
					      img.setAttribute("src", event.target.result); 
					      img.setAttribute("width","750px");
					      img.setAttribute("height","500px"); //이미지 크기 고정
					      document.querySelector("div#image_container").appendChild(img); 
					      }; 
					      reader.readAsDataURL(event.target.files[0]); 
					      } 
				 </script>
   

			<br>
				<input type="hidden" class="form-control w3-input" name="cmWriter" value="${loginMember.memNo }"> <br>

			<input type="hidden" class="form-control" name="cmLike" value="0">
			 <br> 
			<input type="hidden" value="0" name="cmView" placeholder="조회" required>
			<br> 
			<p>다시봄 내용</p>
			<br>
			<textarea name="cmContent" id="cmContent" rows="5" cols="60"></textarea>
			<script>
				//ckeditor 적용
				CKEDITOR.replace("cmContent");
			</script>
			
			<br><br>
			<div id="btn-box">
				<input type="button" class="btn btn-outline-success" value="목록으로"
					onclick="location.replace('${path }/community/communityList')">&nbsp;&nbsp;

				<c:if test="${empty community }">
					<input type="submit" class="btn btn-success" value="등록">
				</c:if>
			</div>
	</div>
</section>

<script>
	function fn_check() {

		return true;
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
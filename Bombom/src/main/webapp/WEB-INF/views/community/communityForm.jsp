<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

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
.title{
font-weight: 800;
font-size: 35px;
}
/*사진 미리보기 div*/
    .proDiv{
    	border:1px solid black;
    	width:850px;
    	height:300px;
    	position:relative;
    	background:url(${path }/resources/images/stamp/stamp4.png);
    	background-size:50%;
    	background-position:center;
    	}
    	
    	.proImg{
    	width:850px;
    	height:300px
    	}
</style>
<!-- CK에디터. CDN -->
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script> 
<script>
$(document).ready(function () {
     CKEDITOR.replace( 'cmContent', {//해당 이름으로 된 textarea에 에디터를 적용
         width:'100%',
         height:'450px',
         filebrowserImageUploadUrl:'${path}/ckeditor/imageUpload' //여기 경로로 파일을 전달하여 업로드 시킨다.
      });
       
     CKEDITOR.on('dialogDefinition', function( ev ){
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
      
        switch (dialogName) {
            case 'image': //Image Properties dialog
                //dialogDefinition.removeContents('info');
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                break;
        		}
         });  
     
     CKEDITOR =   CKEDITOR.replace(/<br\/>/ig, "\n");
     CKEDITOR =   CKEDITOR.replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "");


     CKEDITOR =  CKEDITOR.replace(/(<([^>]+)>)/gi, "");
     CKEDITOR =   CKEDITOR.replace(/&nbsp;/gi,"");

    return  CKEDITOR;
             
});
</script>

<section id="content" class="container">
	<h3>
		<c:out value="${loginMember.memNick}" />
		님의 다시:봄 을 공유해주세요 :-)
	</h3>
	<c:if test="${empty community }">
		<form name="communityFrm" action="${path }/community/insertCommunity" enctype="multipart/form-data" method="post" onsubmit="return fn_check()">
		</c:if>
	<c:if test="${not empty community }">
		<form name="communityFrm" action="${path }/community/updateCommunityEnd" enctype="multipart/form-data" method="post" onsubmit="return fn_check()">
	</c:if>
	
	<c:if test="${not empty community }">
		<input type="hidden" value="${community.cmNo }" name="cmNo">
	</c:if>
	<br>
	<div id="community-container" class="media-body">
			<br> 
			<input type="text" class="form-control w3-input title" name="cmTitle" placeholder="제목을 입력해주세요" maxlength="50" value='<c:out value="${community.cmTitle }"/>' required>
			  <br>
				
			 <!-- 게시글 썸네일 등록 -->
			 <h4> 예쁜 썸네일을 등록해주세요 :) </h4>
	 <div id="thumbContainer">
		 <div class="proDiv" id="1">
		<c:if test="${not empty community.cmThumbnail }">
		<img class="proImg" src="${path }/resources/upload/community/${community.cmThumbnail}">
		<input type="hidden" name="firstImg" value="${community.cmThumbnail}">
		</c:if>
			 <input type="file" class="proPic" name="upFile" id="input1" accept="image/gif, image/jpeg, image/png" style="display:none;">
			 <input type="button" class="close" value="x">
		 </div>
	 </div>

			<br>
				<input type="hidden" class="form-control w3-input" name="cmWriter" value="${loginMember.memNo }"> <br>

			<input type="hidden" class="form-control" name="cmLike" value="0">
			 <br> 
			<input type="hidden" value="0" name="cmView" placeholder="조회" required>
			<br> 
			<br>
			<p>다시봄 내용</p>
			<br>
			<textarea name="cmContent" id="cmContent" rows="5" cols="60" ><c:out value="${community.cmContent }"/></textarea>
			<script>
				//ckeditor 적용
			  	ClassicEditor
			  	.create(document.querySelector('#cmContent'))
			  	.catch(error=>{
			  		console.error(error);
			  	});
	
			</script>
			
			<br><br>
			<div id="btn-box">
				<input type="button" class="btn btn-outline-success" value="목록으로"
					onclick="location.replace('${path }/community/communityList')">&nbsp;&nbsp;

				<c:if test="${empty community }">
					<input type="submit" class="btn btn-success" value="등록">
				</c:if>
				<c:if test="${not empty community }">
				  <input type="submit" class="btn btn-success" value="수정">
				</c:if>
			</div>
	</div>
	</form>
</section> 

<script>
	function fn_check() {

		return true;
	}
	//이미지 업로드 
	$(function(){
	       //div 클릭시 파일업로드
	       $(".proDiv").on("click",e=>{
	           //input file만 선택
	           var file=$(e.target).children().first();
	           file.click();
	    
	       });	
	       
	       //파일 업로드시 이미지 체인지
	       $(".proPic").on("change",e =>{ 
	         
	            let reader=new FileReader();
	              let div=$(e.target).parent();
	              //이전 사진 삭제
	            $(e.target).prev().remove();

	             reader.onload=e=>{
	              let img=$("<img>",{"src":e.target.result,width:"850px",height:"300px",onclick:"fn_upload(this);"});
	              img.addClass("proImg");
	              div.prepend(img); 

	          }
	          reader.readAsDataURL($(e.target)[0].files[0]);
	       }); 
	    
	});	       
	
	//사진 눌렀을 떄 다시 파일 업로드
	  function fn_upload(e){
	    $(e).next().click();

	}  
	//이미지 삭제 버튼
	  $(function(){
	      $(".close").on("click",e=>{	  
	          //이미지 삭제
	          $(e.target).prev().prev().remove();
	          //input file value삭제
	          console.log($(e.target).prev());
	          $(e.target).prev().val("");
	         });
	  });
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
 <link rel="stylesheet" href="${path }/resources/css/community/likeBtn.css"> 
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="notice" value="커뮤니티 상세보기" />
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

.title {
	font-weight: 800;
	font-size: 30px;
}

/* textarea {
	width: 100%;
} */

.reply_reply {
	border: 2px solid #FF50CF;
}

.reply_modify {
	border: 2px solid #FFBB00;
}
/* 좋아요 버튼 */
.btn-like {
	color: transparent;
	text-shadow: 0 0 2px rgba(255, 255, 255, .7), 0 0 0 #000;
	background-color: white;
	border: 0;
	outline: 0;
}

.btn-like:hover {
	text-shadow: 0 0 0 #ea0;
}

.btn-like.done {
	color: inherit;
	text-shadow: 0;
}

.btn-like.done:hover {
	color: transparent;
	text-shadow: 0 0 0 #777;
}
/*댓글테이블*/
table#tbl-comment {
	width: 90%;
	margin: 0 auto;
	border-collapse: collapse;
	clear: both;
}

table#tbl-comment tr td {
	padding: 12px 23px 10px 0;
	text-align: left;
	line-height: 120%;
}

table#tbl-comment tr {
	width: 100%;
}

table#tbl-comment button.btn-reply {
	display: none;
}

table#tbl-comment button.btn-delete {
	display: none;
}

table#tbl-comment tr:hover {
	background: lightgray;
}

table#tbl-comment tr:hover button.btn-reply {
	display: inline;
}

table#tbl-comment tr:hover button.btn-delete {
	display: inline;
}

table#tbl-comment tr.level2 {
	color: gray;
	font-size: 14px;
}

table#tbl-comment span.reply-writer {
	color: navy;
	font-size: 14px;
	padding-right: 10px;
}

table#tbl-comment span.comment-date {
	color: green;
	font-size: 14px;
}

table#tbl-comment tr.level2 td:first-of-type {
	padding-left: 40px;
}

table#tbl-comment tr.level2 p.reply-writer {
	color: #8e8eff;
	font-size: 14px
}

table#tbl-comment tr.level2 p.comment-date {
	color: #ff9c8a;
	font-size: 10px
}
/*가운데서 좌우로 펼쳐지는 라인 에니메이션*/
.reply-btnbox {
	color: #333;
	text-decoration: none;
	display: inline-block;
	padding: 15px 0;
	position: relative;
	cursor: pointer;
}

.reply-btnbox:after {
	background: none repeat scroll 0 0 transparent;
	bottom: 0;
	content: "";
	display: block;
	height: 2px;
	left: 50%;
	position: absolute;
	background: green;
	transition: width 0.3s ease 0s, left 0.3s ease 0s;
	width: 0;
}

.reply-btnbox:hover:after {
	width: 100%;
	left: 0;
}

table#tbl-comment textarea {
	margin: 4px 0 0 0;
}

/* 좋아요버튼  관련 css*/
.fa {
	font-size: 40px;
	cursor: pointer;
	user-select: none;
}

.fa:hover {
	color: darkblue;
}

.replyDiv {
	margin-left: 20px;
	display: none;
}
/* The container */
.containerReply {
	display: block;
	position: relative;
	padding-left: 35px;
	margin-bottom: 12px;
	cursor: pointer;
	font-size: 22px;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
}

/* Hide the browser's default checkbox */
.containerReply input {
	position: absolute;
	opacity: 0;
	cursor: pointer;
	height: 0;
	width: 0;
}

/* Create a custom checkbox */
.checkmark {
	position: absolute;
	top: 0;
	left: 0;
	height: 25px;
	width: 25px;
	background-color: #eee;
}

/* On mouse-over, add a grey background color */
.containerReply:hover input ~ .checkmark {
	background-color: #ccc;
}

/* When the checkbox is checked, add a blue background */
.containerReply input:checked ~ .checkmark {
	background-color: #2196F3;
}

/* Create the checkmark/indicator (hidden when not checked) */
.checkmark:after {
	content: "";
	position: absolute;
	display: none;
}

/* Show the checkmark when checked */
.containerReply input:checked ~ .checkmark:after {
	display: block;
}

/* Style the checkmark/indicator */
.containerReply .checkmark:after {
	left: 9px;
	top: 5px;
	width: 5px;
	height: 10px;
	border: solid white;
	border-width: 0 3px 3px 0;
	-webkit-transform: rotate(45deg);
	-ms-transform: rotate(45deg);
	transform: rotate(45deg);
}
/* 모달 창 중앙정렬하기 */
.modal {
	text-align: center;
}

@media screen and (min-width: 768px) {
	.modal:before {
		display: inline-block;
		vertical-align: middle;
		content: " ";
		height: 100%;
	}
}

.modal-dialog {
	display: inline-block;
	text-align: left;
	vertical-align: middle;
}

}

</style>
<section id="content" class="container">

	<!-- 커뮤니티 섹션 시작 -->
	<div id="community-container">
		<div class="thumbnail">
			<img
				src="${path }/resources/upload/community/${community.cmThumbnail}"
				width="800" height="300">
		</div>
		<input type="hidden" value="${community.cmNo }" name="cmNo" id="cmNo"> <br>
		<input type="text" class="form-control w3-input title" name="cmTitle"
			placeholder="제목을 입력해주세요"
			value='<c:out value="${community.cmTitle }"/>' required><br>

		<div>
			<fmt:formatDate pattern="yyyy-MM-dd" value="${community.cmDate }" />
			<p>
				<img src="${path }/resources/upload/profile/${community.memPro}"
					class="rounded-circle" id="profileImg" alt="기본프로필" width="50"
					height="50">
				<c:out value="${community.memNick}" />
			</p>
		</div>

		<br>
		<div id="editor"><c:out value="${community.cmContent }" /></div>
				
				<script>
				var text = $("#editor").val();
				console.log(text);
				var tagRemove = text.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
				console.log(tagRemove);
				</script>
		<br>		
		
<%-- 		<label> Like </label> <i onclick="myFunction(this)"
				value="${community.cmContent }" /></textarea><br> --%>

		<!-- 좋아요 -->
		<label> Like </label>
		<div class='middle-wrapper'>
		  <div class='like-wrapper'>
		    <a class='like-button'>
		      <span class='like-icon'>
		        <div class='heart-animation-1'></div>
		        <div class='heart-animation-2'></div>
		      </span>
		      	좋아요 &nbsp;<span class="cmLike"><c:out value="${community.cmLike }" /></span>
		    </a>
		  </div>
		</div>
		<br>


		<!-- 해당 게시글 작성자에게만 수정 / 삭제 버튼 보인다 -->

		<div id="btn-box">
			<c:if test="${loginMember.memNo eq community.cmWriter or loginMember.memManagerYn == 'Y' }">
				<input type="hidden" value="${community.cmNo }" name="cmNo" />
				<button class="btn btn-outline-success"
					onclick="fn_updateCommunity();">수정</button>
				<button class="btn btn-outline-secondary"
					onclick="fn_deleteCommunity();">삭제</button>
			</c:if>
		</div>
		<script>
		function fn_updateCommunity() {
			let cmNo = $(event.target).parent()
					.children('input[name=cmNo]').val();
			location.replace("${path}/community/updateCommunity?cmNo=" + cmNo);
		};

		function fn_deleteCommunity() {
			let cmNo = $(event.target).parent().children('input[name=cmNo]').val();
			location.replace("${path}/community/deleteCommunity?cmNo=" + cmNo);
		};
		</script>

		<!-- 댓글 달기  -->

		<label>Comment</label>
		
		 <div class="comment-editor">
			<textarea name="reply-content" id="reply-content" cols="100" rows="3"></textarea>
			<!-- 로그인 하셔야 댓글 글쓰기가 가능합니다, 로그인 하시겠습니까? -->
			<div class="text-right">
				<c:if test="${loginMember!=null }">
					<input type="hidden" name="memNo" value="${loginMember.memNo}" id="memNo">
					<button class="btn-insert btn btn-outline-success">등록</button>
				</c:if>
				
				<c:if test="${loginMember==null }">
					<button type="button" class="btn-successloginCheck">글쓰기</button>
				</c:if>
			</div>
		</div>
		

    <div id="replyAjax">   </div>
    
		
	<div id="btn-box">
		<input type="button" class="btn btn-outline-success" value="목록으로"
			onclick="location.replace('${path }/community/communityList')">
	</div>
</section>
<script>

// 화면이 켜질때 동시에 시작하는 함수
/* $(document).ready(function(){
	console.log(document.getElementById("cmNo")); // 아이디 접근하는 스크립트 
	console.log($("#cmNo").val())  //값을 데려오는지 확인하는 식 
	console.log($("#memNo").val())
	console.log($("#reply-content").val())
})
 */
//$("cmNo") : 제이쿼리 아이디 접근하는 스크립트. 


	 $(".btn-insert").click(e=>{
		 console.log(e.target);
		 console.log($("#reply-content").val())
		 
		 if($("#reply-content").val()==""){
			 swal("댓글을 입력해주세요");
			 return false;
		 }
		 
		var cmNo = $("#cmNo").val();
			 console.log(cmNo);
	    var memNo = $("#memNo").val();
	    var replyContent = $("#reply-content").val();
	    $("#reply-content").val(""); //댓글 등록후 비워줌
    
		 $.ajax({
			 url:"${path }/community/insertReply",
			 data: {cmNo:cmNo,memNo:memNo,replyContent:replyContent},
			 success:data => {
				 $("#replyAjax").html(data);
		 
			 }
		 }); 
		
		
	}); 
	

	//좋아요 확인용 value
	var value;
	//좋아요한 글인지 확인
	$(document).ready(function(){
	 	$.ajax({
			url:"${path}/community/checkLike",
			dataType:"json",
			success:data=>{
				if(data!=null){
					 $(data).each(function(i,v){
					  //좋아요한 글이면 버튼 눌러진 상태로 띄우기
					  if(data.indexOf("${community.cmNo }")!=-1){
		            	$(".like-button").addClass('liked');
		            	value=1;
					  }
		            });
				}
			}
		});
	
		
		//커뮤니티 댓글 띄우기
		$.ajax({
			url:"${path }/community/communityReplyList",
			data:{cmNo:"${community.cmNo }"},
			success:data=>{
				$("#replyAjax").html(data);
			}
		});
		
		
		
		
	});
	//알림 관련 메세지
	let alarmMsg="${loginMember.memNick}님이 회원님의 '${community.cmTitle}' 글을 좋아합니다.";//좋아요를 누른 사람의 닉네임,글 제목
	//좋아요 버튼
	$('.like-wrapper').on('click', function(e) {
		$(e.target).toggleClass('liked');
		//좋아요 누른 상태
		if($(e.target).hasClass('liked') === true) value=1;
		//좋아요 취소 상태
		else value=0;

		$.ajax({
			url:"${path}/community/insertLike",
			data:{cmNo:"${community.cmNo }",likeCount:"${community.cmLike }",value:value,receiverNo:"${community.cmWriter}",message:alarmMsg},
			dataType:"json",
			success:data=>{
				//좋아요 수 출력 
				$(".cmLike").text(data.likeCount);
				//좋아요 됐으면 클릭된 상태로 띄우기
				if(data.likeNo.indexOf("${community.cmNo }")!=-1){
	            	$(".like-button").addClass('liked');
				}
				//알림 보내기
				if(sock && value==1){
	   				console.log("소켓생성됨:"+sock);
	   				let socketMsg = "communityLike,${loginMember.memNick},${loginMember.memNo},${community.cmWriter},''";
	   				console.log("알림전송내역 : " + socketMsg);
	   				sock.send(socketMsg);
	   			}
			}
		});

	});


</script>

<style>
	/*커뮤니티 좋아요 버튼*/
	body {
	  font-size: 16px;
	}
	
	a {
	  cursor: pointer;
	}
	
	.middle-wrapper {
	  display: -webkit-box;
	  display: flex;
	  -webkit-box-pack: center;
	  /*  justify-content: center; */
	  -webkit-box-align: center;
	   align-items: center;
	  /* width: 100%; */
	  /* height: 95vh; */
	}
	
	.like-wrapper {
	  display: -webkit-box;
	  display: flex;
	  justify-content: space-around;
	  -webkit-box-orient: horizontal;
	  -webkit-box-direction: normal;
	  flex-flow: row wrap;
	  /* width: 50%; */
	}
	
	.like-button {
	  border: 2px solid #c7c7c7;
	  border-radius: 40px;
	  padding: .45rem .75rem;
	  color: #878787;
	  font-weight: bold;
	  display: -webkit-box;
	  display: flex;
	  -webkit-box-align: center;
	          align-items: center;
	  -webkit-box-pack: center;
	          justify-content: center;
	  font-size: 1rem;
	  -webkit-transition: all 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	  transition: all 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275);
	  -webkit-filter: grayscale(100%);
	          filter: grayscale(100%);
	  -webkit-user-select: none;
	     -moz-user-select: none;
	      -ms-user-select: none;
	          user-select: none;
	}
	.like-button.liked {
	  color: #ff6e6f;
	  border-color: currentColor;
	  -webkit-filter: grayscale(0);
	          filter: grayscale(0);
	}
	.like-button:hover {
	  border-color: currentColor;
	  text-decoration:none;
	}
	
	.like-icon {
	  width: 18px;
	  height: 16px;
	  display: inline-block;
	  position: relative;
	  margin-right: .25em;
	  font-size: 1.5rem;
	  background: url("data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjEiIGhlaWdodD0iMTgiIHZpZXdCb3g9IjAgMCAyMSAxOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBkPSJNMTAuMTAxIDQuNDE3UzguODk1LjIwNyA1LjExMS4yMDdjLTQuNDY1IDAtMTAuOTY3IDYuODQ2IDUuMDgyIDE3LjU5MkMyNS4yMzcgNy4wMyAxOS42NjUuMjAyIDE1LjUwMS4yMDJjLTQuMTYyIDAtNS40IDQuMjE1LTUuNCA0LjIxNXoiIGZpbGw9IiNGRjZFNkYiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjwvc3ZnPg==") no-repeat center;
	  background-size: 100%;
	  -webkit-animation: heartUnlike 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartUnlike 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	}
	
	.liked .like-icon {
	  -webkit-animation: heartPulse 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartPulse 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	}
	.liked .like-icon [class^="heart-animation-"] {
	  background: url("data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjEiIGhlaWdodD0iMTgiIHZpZXdCb3g9IjAgMCAyMSAxOCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48cGF0aCBkPSJNMTAuMTAxIDQuNDE3UzguODk1LjIwNyA1LjExMS4yMDdjLTQuNDY1IDAtMTAuOTY3IDYuODQ2IDUuMDgyIDE3LjU5MkMyNS4yMzcgNy4wMyAxOS42NjUuMjAyIDE1LjUwMS4yMDJjLTQuMTYyIDAtNS40IDQuMjE1LTUuNCA0LjIxNXoiIGZpbGw9IiNGRjZFNkYiIGZpbGwtcnVsZT0iZXZlbm9kZCIvPjwvc3ZnPg==") no-repeat center;
	  background-size: 100%;
	  display: block;
	  position: absolute;
	  top: 0;
	  left: 0;
	  width: 16px;
	  height: 14px;
	  opacity: 0;
	}
	.liked .like-icon [class^="heart-animation-"]::before, .liked .like-icon [class^="heart-animation-"]::after {
	  content: '';
	  background: inherit;
	  background-size: 100%;
	  width: inherit;
	  height: inherit;
	  display: inherit;
	  position: relative;
	  top: inherit;
	  left: inherit;
	  opacity: 0;
	}
	.liked .like-icon .heart-animation-1 {
	  -webkit-animation: heartFloatMain-1 1s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartFloatMain-1 1s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	}
	.liked .like-icon .heart-animation-1::before, .liked .like-icon .heart-animation-1::after {
	  width: 12px;
	  height: 10px;
	  visibility: hidden;
	}
	.liked .like-icon .heart-animation-1::before {
	  opacity: .6;
	  -webkit-animation: heartFloatSub-1 1s 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartFloatSub-1 1s 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	}
	.liked .like-icon .heart-animation-1::after {
	  -webkit-animation: heartFloatSub-2 1s 0.15s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartFloatSub-2 1s 0.15s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	  opacity: .75;
	}
	.liked .like-icon .heart-animation-2 {
	  -webkit-animation: heartFloatMain-2 1s 0.1s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartFloatMain-2 1s 0.1s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	}
	.liked .like-icon .heart-animation-2::before, .liked .like-icon .heart-animation-2::after {
	  width: 10px;
	  height: 8px;
	  visibility: hidden;
	}
	.liked .like-icon .heart-animation-2::before {
	  -webkit-animation: heartFloatSub-3 1s 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartFloatSub-3 1s 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	  opacity: .25;
	}
	.liked .like-icon .heart-animation-2::after {
	  -webkit-animation: heartFloatSub-4 1s 0.15s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	          animation: heartFloatSub-4 1s 0.15s cubic-bezier(0.175, 0.885, 0.32, 1.275) both;
	  opacity: .4;
	}
	
	@-webkit-keyframes heartPulse {
	  0% {
	    -webkit-transform: scale(1);
	            transform: scale(1);
	  }
	  50% {
	    -webkit-transform: scale(1.5);
	            transform: scale(1.5);
	  }
	}
	
	@keyframes heartPulse {
	  0% {
	    -webkit-transform: scale(1);
	            transform: scale(1);
	  }
	  50% {
	    -webkit-transform: scale(1.5);
	            transform: scale(1.5);
	  }
	}
	@-webkit-keyframes heartUnlike {
	  50% {
	    -webkit-transform: scale(0.75);
	            transform: scale(0.75);
	  }
	}
	@keyframes heartUnlike {
	  50% {
	    -webkit-transform: scale(0.75);
	            transform: scale(0.75);
	  }
	}
	@-webkit-keyframes heartFloatMain-1 {
	  0% {
	    opacity: 0;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    opacity: 1;
	    -webkit-transform: translate(0, -25px) rotate(-20deg);
	            transform: translate(0, -25px) rotate(-20deg);
	  }
	}
	@keyframes heartFloatMain-1 {
	  0% {
	    opacity: 0;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    opacity: 1;
	    -webkit-transform: translate(0, -25px) rotate(-20deg);
	            transform: translate(0, -25px) rotate(-20deg);
	  }
	}
	@-webkit-keyframes heartFloatMain-2 {
	  0% {
	    opacity: 0;
	    -webkit-transform: translate(0) rotate(0) scale(0);
	            transform: translate(0) rotate(0) scale(0);
	  }
	  50% {
	    opacity: .9;
	    -webkit-transform: translate(-10px, -38px) rotate(25deg) scale(1);
	            transform: translate(-10px, -38px) rotate(25deg) scale(1);
	  }
	}
	@keyframes heartFloatMain-2 {
	  0% {
	    opacity: 0;
	    -webkit-transform: translate(0) rotate(0) scale(0);
	            transform: translate(0) rotate(0) scale(0);
	  }
	  50% {
	    opacity: .9;
	    -webkit-transform: translate(-10px, -38px) rotate(25deg) scale(1);
	            transform: translate(-10px, -38px) rotate(25deg) scale(1);
	  }
	}
	@-webkit-keyframes heartFloatSub-1 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(13px, -13px) rotate(30deg);
	            transform: translate(13px, -13px) rotate(30deg);
	  }
	}
	@keyframes heartFloatSub-1 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(13px, -13px) rotate(30deg);
	            transform: translate(13px, -13px) rotate(30deg);
	  }
	}
	@-webkit-keyframes heartFloatSub-2 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(18px, -10px) rotate(55deg);
	            transform: translate(18px, -10px) rotate(55deg);
	  }
	}
	@keyframes heartFloatSub-2 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(18px, -10px) rotate(55deg);
	            transform: translate(18px, -10px) rotate(55deg);
	  }
	}
	@-webkit-keyframes heartFloatSub-3 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(-10px, -10px) rotate(-40deg);
	            transform: translate(-10px, -10px) rotate(-40deg);
	  }
	  100% {
	    -webkit-transform: translate(-50px, 0);
	            transform: translate(-50px, 0);
	  }
	}
	@keyframes heartFloatSub-3 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(-10px, -10px) rotate(-40deg);
	            transform: translate(-10px, -10px) rotate(-40deg);
	  }
	  100% {
	    -webkit-transform: translate(-50px, 0);
	            transform: translate(-50px, 0);
	  }
	}
	@-webkit-keyframes heartFloatSub-4 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(2px, -18px) rotate(-25deg);
	            transform: translate(2px, -18px) rotate(-25deg);
	  }
	}
	@keyframes heartFloatSub-4 {
	  0% {
	    visibility: hidden;
	    -webkit-transform: translate(0) rotate(0);
	            transform: translate(0) rotate(0);
	  }
	  50% {
	    visibility: visible;
	    -webkit-transform: translate(2px, -18px) rotate(-25deg);
	            transform: translate(2px, -18px) rotate(-25deg);
	  }
</style>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
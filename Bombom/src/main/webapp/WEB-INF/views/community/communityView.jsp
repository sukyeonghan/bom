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

textarea {
	width: 100%;
}

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
.btn-reply{
  color: #333;
  text-decoration: none;
  display: inline-block;
  padding: 15px 0;
  position: relative;
}
.btn-reply:after {    
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
.btn-reply:hover:after { 
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
.replyDiv{
margin-left:20px;
display:none;
}

}

</style>
<section id="content" class="container">
	<div id="community-container">

		<div class="thumbnail">
			<img
				src="${path }/resources/upload/community/${community.cmThumbnail}"
				width="800" height="300">
		</div>
		<input type="hidden" value="${community.cmNo }" name="cmNo"> <br>
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
		<textarea id="editor" class="form-control" rows="10" name="cmContent"
			placeholder="내용을 입력해주세요" required><c:out
				value="${community.cmContent }" /></textarea><br>
		
		<!-- 좋아요 -->		
<%-- 		 <label> Like </label> <i onclick="myFunction(this)"
			class="fa fa-thumbs-up"></i>
		<c:out value="${community.cmLike }" />
		<br> <br> --%>

		<!-- 테스트 -->
		<div class='middle-wrapper'>
		  <div class='like-wrapper'>
		    <a class='like-button'>
		      <span class='like-icon'>
		        <div class='heart-animation-1'></div>
		        <div class='heart-animation-2'></div>
		      </span>
		      좋아요 <c:out value="${community.cmLike }" />
		    </a>
		  </div>
		</div>
		<br>


		<!-- 해당 게시글 작성자에게만 수정 / 삭제 버튼 보인다 -->

		<div id="btn-box">
			<c:if test="${loginMember.memNo eq community.cmWriter }">
				<input type="hidden" value="${community.cmNo }" name="cmNo" />
				<button class="btn btn-outline-success"
					onclick="fn_updateCommunity();">수정</button>
				<button class="btn btn-outline-secondary"
					onclick="fn_deleteCommunity();">삭제</button>
			</c:if>
		</div>

		<!-- 댓글 달기  -->

		<label>Comment</label>

		<div class="comment-editor">
			<textarea name="reply-content" id="reply-content" cols="40" rows="3"></textarea>
			<button id="btn-insert">등록</button>
		</div>

		<table id="tbl-comment">
			<!-- 댓글 리스트 출력하기 -->
			<c:forEach items="${replyList }" var="reply">
				<c:if test="${reply.depth == 0}">
					<tr class="level1">
						<td><img
							src="${path}/resources/upload/profile/${reply.mem_pro}"
							width="30px" height="30px"> <span class="reply-writer"><strong><c:out
										value="${reply.mem_nick }" /></strong></span> <span class="comment-date"><fmt:formatDate
										pattern="yyyy. MM. dd HH:mm" value="${reply.register_datetime }" /></span> <br> <br>
							<div>
								<c:out value="${reply.reply_content }" />
							</div>
							<div>
								<span class="btn-reply">답글달기</span>&nbsp;&nbsp;<span>신고하기</span>
							</div>
							<div class="replyDiv" style="display:none;">
								<textarea name="reply-content" id="reply-content" cols="40"
									rows="3"></textarea>
								<button class="btn-insert2">답글 등록</button>
							</div></td>
					</tr>

				</c:if>
				<c:if test="${reply.depth!=0 }">
					<tr class="level2" id="level2">
						<td><img
							src="${path}/resources/upload/profile/${reply.mem_pro}"
							width="30px" height="30px"> <span class="reply-writer"><c:out
									value="${reply.mem_nick }" /></span> <span><c:out
									value="${reply.register_datetime }" /></span> <br>
							<div>
								<c:out value="${reply.reply_content }" />
							</div> <span>신고하기</span></td>
						<td></td>
					</tr>
				</c:if>
			</c:forEach>
		</table>

	</div>
	<br>
	<div id="btn-box">
		<input type="button" class="btn btn-outline-success" value="목록으로"
			onclick="location.replace('${path }/community/communityList')">
	</div>
</section>

<script>
	//좋아요 버튼
	$('a.like-button').on('click', function(e) {
	  $(this).toggleClass('liked');
	  
	});
	//좋아요 ajax
	function myFunction(x) {
		x.classList.toggle("fa-thumbs-down");	
		//숫자 카운트,member에 insert
		$.ajax({
			url:"${path}/community/insertLike",
			data:{memNo:"${loginMember.memNo}",cmNo:"${community.cmNo }",likeCount:"${community.cmLike }"},
			dataType:"json",
			sucess:data=>{
				//글번호insert결과값, 카운트 수 
				
			}
		});
	}
  

	function fn_updateNotice() {
		let noticeNo = $(event.target).parent()
				.children('input[name=noticeNo]').val();
		location.replace("${path}/notice/updateNotice?noticeNo=" + noticeNo);
	};

	function fn_deleteCommunity() {
		let cmNo = $(event.target).parent().children('input[name=cmNo]').val();
		location.replace("${path}/community/deleteCommunity?cmNo=" + cmNo);
	};
	
	//댓글 시작
	$(document)
			.ready(
					function() {
						
						var status = false; //수정과 대댓글을 동시에 적용 못하도록
						//댓글 저장
						$("#btn-insert")
								.click(
										function() {
											//널 검사
											if ($("#reply-content").val()
													.trim() == "") {
												alert("내용을 입력하세요.");
												$("#reply-content").focus();
												return false;
											}
											var reply_content = $(
													"#reply-content").val()
													.replace("\n", "<br>"); //개행처리

											var objParams = {
												board_id : "${community.cmNo}",
												parent_id : " ", //참조할 댓글번호
												depth : "0",
												reply_writer : "${loginMember.memNo}",
												reply_content : reply_content
											};

											//저장 값 셋팅
											$
													.ajax({
														type : "POST",
														url : "${path }/board/reply/save",
														data : objParams, //key 와 value값을 보낸다
														dataType : "json",
														success : function(data) {
															console.log(data);
															alert(data.message);
															let tr = $('<tr class="level1">');
															let td = $('<td>');
															let img = $(
																	'<img width="30px" height="30px">')
																	.attr(
																			"src",
																			"${path}/resources/upload/profile/"
																					+ data.mem_pro);
															let span = $(
																	'<span class="reply-writer">')
																	.html(
																			data.mem_nick);
															
															var b = data.register_datetime
															var date = new Date(b);
															var year = date.getFullYear();
															var month = date.getMonth()+1
															var day = date.getDate();
															var hh=date.getHours();
															var mm=date.getMinutes();
															
															if(month<10){
																month ="0"+month;
															}
															if(day<10){
																day ="0"+day;
															}
															
															var today=year+". "+month+". "+day+" "+hh+":"+mm;
															
															let span2 = $(
																	'<span class="comment-date">')
																	.html(
																		
																		today);
															let br = $('<br>');
															let div = $('<div>')
																	.html(
																			data.reply_content);
															let br2=$('<br>');
															let btnDiv = $('<div>');
															let span3 = $(
																	'<span id="btn-insert2" class="btn-reply">')
																	.html(
																			"답글달기");
															let span4 = $(
																	'<span>')
																	.html(
																			"신고하기"); //신고하기 
															let replyDiv=$('<div>').prop("class","replyDiv");
																			
															replyDiv.css("display","none");
															let textarea=$('<textarea cols="40" rows="3">');		
															let btn2=$('<button class="btn-insert2">').html("답글등록")
															btnDiv.append(
																	span3,
																	span4);
															td.append(img)
															td.append(span)
															td.append(span2);
															td.append(br,br2);
															td.append(div);
															td.append(btnDiv);
														    replyDiv.append(textarea);
															replyDiv.append(btn2);
															td.append(replyDiv);
															
															tr.append(td);

															$(".level1")
																	.first()
																	.before(tr);
															//댓글 초기화
															$("#reply-content")
																	.val("");
														}
													})
											//답글 달기		
										$("#btn-insert2")
								.click(
										function() {
											//널 검사
											if ($("#reply-content").val()
													.trim() == "") {
												alert("내용을 입력하세요.");
												$("#reply-content").focus();
												return false;
											}
											var reply_content = $(
													"#reply-content").val()
													.replace("\n", "<br>"); //개행처리

											var objParams = {
												board_id : "${community.cmNo}",
												parent_id : " ", //참조할 댓글번호
												depth : "0",
												reply_writer : "${loginMember.memNo}",
												reply_content : reply_content
											};

											//저장 값 셋팅
											$
													.ajax({
														type : "POST",
														url : "${path }/board/reply/save",
														data : objParams, //key 와 value값을 보낸다
														dataType : "json",
														success : function(data) {
															console.log(data);
															alert(data.message);
															let tr = $('<tr class="level1">');
															let td = $('<td>');
															let img = $(
																	'<img width="30px" height="30px">')
																	.attr(
																			"src",
																			"${path}/resources/upload/profile/"
																					+ data.mem_pro);
															let span = $(
																	'<span class="reply-writer">')
																	.html(
																			data.reply_writer);
															let span2 = $(
																	'<span class="comment-date">')
																	.html(
																			data.register_datetime);
															let br = $('<br>');
															let div = $('<div>')
																	.html(
																			data.reply_content);
															let btnDiv = $('<div>');
															let span3 = $(
																	'<span id="btn-insert2" class="btn-reply">')
																	.html(
																			"답글달기");
															let span4 = $(
																	'<span>')
																	.html(
																			"신고하기"); //신고하기 
															btnDiv.append(
																	span3,
																	span4);
															td.append(img)
															td.append(span)
															td.append(span2);
															td.append(br);
															td.append(div);
															td.append(btnDiv);
															tr.append(td);

															$(".level1")
																	.first()
																	.before(tr);
															//댓글 초기화
															$("#reply-content")
																	.val("");
														}
													})
													
										});
	
							});
					});
	
	//대댓글 등록창
$(document).on("click",".btn-reply",e=>{
	$(e.target).parent().next(".replyDiv").toggle(800);
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
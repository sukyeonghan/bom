<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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

/* 좋아요버튼  */
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
</style>
<section id="content" class="container">

	<!-- 커뮤니티 섹션 시작 -->
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
				value="${community.cmContent }" /></textarea>
				
				<!-- 좋아요 -->
		<br> <label> Like </label> <i onclick="myFunction(this)"
			class="fa fa-thumbs-up"></i>
		<c:out value="${community.cmLike }" />
		<br> <br>
		
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

		<!-- 댓글 달기  -->

		<label>Comment</label>

		<div class="comment-editor">
			<textarea name="reply-content" id="reply-content" cols="40" rows="3"></textarea>
			<!-- 로그인 하셔야 댓글 글쓰기가 가능합니다, 로그인 하시겠습니까? -->
			<div class="text-right">
				<c:if test="${loginMember!=null }">
					<input type="hidden" name="memNo" value="${loginMember.memNo}">
					<button class="btn-insert">등록</button>
				</c:if>
				<c:if test="${loginMember==null }">
					<button type="button" class="btn btn-success loginCheck">글쓰기</button>
				</c:if>
			</div>
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
									pattern="yyyy. MM. dd HH:mm"
									value="${reply.register_datetime }" /></span> <br> <br>
							<div>
								<c:out value="${reply.reply_content }" />
							</div>
				
							<div>
							   <!--  로그인 했을 경우 버튼 활성화 -->
								<div class="text-right">
									<c:if test="${loginMember!=null }">
										<input type="text" name="reply_id" id="replyId"
										value="${reply.reply_id }"	/>
										<input type="hidden" id="replyWriter" name="reply_writer" value="${reply.reply_writer }"/>
										<input type="hidden" name="memNo" value="${loginMember.memNo}">
										<span class="reply-btnbox btn-reply">답글달기</span>&nbsp;&nbsp; 
										<span data-toggle="modal" data-target="#reportModal"
											class="reply-btnbox replyModal">신고하기 </span>&nbsp;&nbsp;
							       		<button onclick="fn_deleteReply();">삭제하기</button>
									</c:if>
									
								<!--  로그인 하지 않았을 경우 로그인 체크 -->
									<c:if test="${loginMember==null }">
										<span class="reply-btnbox btn-reply loginCheck">답글달기</span>&nbsp;&nbsp; <span
											class="loginCheck">신고하기</span>&nbsp;&nbsp;
								<button class="loginCheck">삭제하기</button>
									</c:if>
								</div>
							</div>
							
		

							<div class="replyDiv" style="display: none;">
								<textarea name="reply-content2" class="reply-content2" cols="40"
									rows="3"></textarea>
								<input type="hidden" name="reply_id" class="replyId"
									value="${reply.reply_id}" />
								<button class="btn-insert2">답글등록</button>
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
							</div> <span>신고하기</span>&nbsp;&nbsp;<span>삭제하기</span>
						<td></td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		
	   						<!-- 신고하기 클릭했을 때 뜨는 모달 창 -->
							<div class="modal" id="reportModal">
								<div class="modal-dialog">
									<div class="modal-content">
										<!-- Modal Header -->
										<div class="modal-header">
											<h1 class="modal-title">신고 사유를 선택해주세요</h1>
											<button type="button" class="close" data-dismiss="modal">&times;</button>
										</div>

										<!-- Modal body -->
										<div class="modal-body">
											<form action="${path }/admin/community/reportReply"
												name="reportFrm" method="post">
												<label class="containerReply">주제와 맞지 않음 <input
													type="checkbox" name="report" value="주제와 맞지 않음">
													<span class="checkmark"></span>
												</label><br> <label class="containerReply">정보가 부정확함 <input
													type="checkbox" name="com_reason" value="정보가 부정확함"> <span
													class="checkmark"></span>
												</label><br> <label class="containerReply">지나친 광고성 게시물
													<input type="checkbox" name="com_reason" value="지나친 광고성 게시물">
													<span class="checkmark"></span>
												</label><br> <label class="containerReply">욕설/비방이 심함 <input
													type="checkbox" name="com_reason" value="욕설/비방이 심함">
													<span class="checkmark"></span>
												</label><br> <label class="containerReply">기타 <input
													type="checkbox" name="com_reason" value="기타"> <textarea
														name="com_reason" cols="20" rows="3"></textarea> <span
													class="checkmark"></span>
												</label>  
												<input type="text" name="reply_writer" class="replyWriter">
												<input
													type="hidden" name="com_status" value="Y" />  <br> 
												<button type="submit" class="reporty"
													class="btn btn-success">신고하기</button>
												 <input type="text" class="replyId" name="reply_id">	
											</form>

										</div>
										<script>
											$(".reporty").click(function(){
												console.log(com_reason + reply_writer + com_status + reply_id)
											})
										</script>
										<!-- Modal footer -->
										<div class="modal-footer">
											<button type="button" class="btn btn-danger"
												data-dismiss="modal">닫기</button>
										</div>

									</div>
								</div>
							</div>

	</div>
	<br>
	<div id="btn-box">
		<input type="button" class="btn btn-outline-success" value="목록으로"
			onclick="location.replace('${path }/community/communityList')">
	</div>
</section>

<script>
     
     //모달에 고유값을 클릭했을 때 
     $(".replyModal").click(function(){
    	 let replyId = $(this).parent().children('input[name="reply_id"]').val(); //변수에 답글번호를 가져온다.
    	 let replyWriter = $(this).parent().children('input[name="reply_writer"]').val();
    	 console.log(replyId);
    	 
    	 $(".replyId").val(replyId); //모달창에 답글 번호 쏴주기 
    	 $(".replyWriter").val(replyWriter)
    	 
     })
     
	//좋아요 ajax 
	function myFunction(x) {
		x.classList.toggle("fa-thumbs-down");	
	};
	
	function fn_updateNotice() {
		let noticeNo = $(event.target).parent()
				.children('input[name=noticeNo]').val();
		location.replace("${path}/notice/updateNotice?noticeNo=" + noticeNo);
	};

	function fn_deleteCommunity() {
		let cmNo = $(event.target).parent().children('input[name=cmNo]').val();
		location.replace("${path}/community/deleteCommunity?cmNo=" + cmNo);
	};
	
	
    function fn_deleteReply(){
    	var msg = confirm("댓글을 삭제합니다"); //댓글 삭제 메세지
    	if(msg == true){ //확인을 누 경우
    		let reply_id = $(event.target).parent().children('input[name=reply_id]').val();
        	location.replace("${path}/community/deleteReply?reply_id=" + reply_id); 
    	}
    	else{
    		return false; //삭제 취소
    	}
    	
    };
	                   //댓글 시작
	                   $(document).ready(function() {
						var status = false; //수정과 대댓글을 동시에 적용 못하도록
						//댓글 저장
						$(".btn-insert")
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
											$.ajax({
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
																	.html(data.mem_nick);
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
																	.html(data.reply_content);
															let br2=$('<br>');
															let btnDiv = $('<div>');
															let span3 = $(
																	'<span class="btn-reply" class="btn-reply">')
																	.html("답글달기");
															let span4 = $(
																	'<span>')
																	.html(
																			"신고하기"); //신고하기 
														    let span5 =$('<span>').html("삭제하기");				
															let replyDiv=$('<div>').prop("class","replyDiv");				
															replyDiv.css("display","none");
															let textarea=$('<textarea cols="40" rows="3">');
															let input=$('<input type="hidden" name="replyId" class="replyId">').html(data.reply_id);
															let btn2=$('<button class="btn-insert2">').html("답글등록")
															btnDiv.append(
																	span3,
																	span4,span5);
															td.append(img)
															td.append(span)
															td.append(span2);
															td.append(br,br2);
															td.append(div);
															td.append(btnDiv);
														    replyDiv.append(textarea);
														    replyDiv.append(input);
															replyDiv.append(btn2);
															td.append(replyDiv);
															tr.append(td);

															$(".level1")
																	.first()
																	.before(tr);
															//댓글 초기화
															$(" #reply-content")
																	.val("");
														}
													})
							                    });
                                         });

	                 //대댓글 등록창
	               	$(document).on("click",".btn-reply",e=>{
	               		$(e.target).parent().next(".replyDiv").toggle(800);
	               	});
	                 
	               	//댓글에 답글 달기		
	               $(".btn-insert2")
								.click(
										e=> {
											//널 검사
											if ($(".reply-content2").val()
													.trim() == "") {
												alert("내용을 입력하세요.");
												$(".reply-content2").focus();
												return false;
											}		
											
											var reply_content2 = $(
													".reply-content2").val()
													.replace("\n", "<br>"); //개행처리
													
										 var reply_content = $(".reply-content2").val(); //jquery 
										 
										 var id = $(e.target).prev().val(); //parent_id  
													
											var objParams = {
												board_id : "${community.cmNo}", //jstl
												parent_id : id, //참조할 댓글번호
												depth : "1",
												reply_writer : "${loginMember.memNo}",
												reply_content : reply_content
											};
													
											//저장 값 셋팅
														$.ajax({
													    type : "POST",
														url : "${path }/board/reply/save",
														data : objParams, //key 와 value값을 보낸다
														dataType : "json",
														success : function(data) {
						  								console.log(data);
														alert(data.message);
															let tr = $('<tr class="level2">');
															let td = $('<td>');
															let img = $(
																	'<img width="30px" height="30px">')
																	.attr(
																			"src",
																			"${path}/resources/upload/profile/"
																					+ data.mem_pro);
															let span = $(
																	'<span class="reply-writer">')
																	.html(data.mem_nick);
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
																	.html(data.reply_content);
															let br2=$('<br>');
															let btnDiv = $('<div>');
  														    let span4 = $(
																	'<span>')
																	.html(
																			"신고하기"); //신고하기 
															btnDiv.append(		
																	span4);
															td.append(img)
															td.append(span)
															td.append(span2);
															td.append(br,br2);
															td.append(div);
															td.append(btnDiv);
															tr.append(td);
															
															$(".level2")
															.first()
															.before(tr);
															
													//댓글 초기화
													$(".reply-content2")
															.val("");
													
														}
														
											})
			

										});

	           	//댓글 로그인 체크
	           	$(function() {
	           		$(".loginCheck").click(function() {
	           			swal("로그인을 먼저 해주세요");
	           		});
	           	});
	           	
	           	
	           	
	           	
	               		
	               
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
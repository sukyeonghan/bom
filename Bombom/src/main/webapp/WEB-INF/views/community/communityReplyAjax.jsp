<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />




<table id="tbl-comment">
	<!-- 댓글 리스트 출력하기 -->
	<c:forEach items="${replyList }" var="reply">
		<c:if test="${reply.depth == 0}">
			<tr class="level1">
				<td>
				<img src="${path}/resources/upload/profile/${reply.mem_pro}" width="30px" height="30px"> 
				<span class="reply-writer"><strong><c:out value="${reply.mem_nick }" /></strong></span> 
				<span class="comment-date"><fmt:formatDate pattern="yyyy. MM. dd HH:mm" value="${reply.register_datetime }" /></span>
				<br> <br>
				<c:if test="${reply.com_status eq null }">
				<div> <c:out value="${reply.reply_content }" /> </div>
				</c:if>
				<c:if test="${reply.com_status eq 'Y' }">
				<div> 부절절한 댓글 입니다. </div>
				</c:if>
					<div>
						<!--  로그인 했을 경우 버튼 활성화 -->
						<div class="text-right">
								<input type="hidden" name="reply_id" id="replyId"
									value="${reply.reply_id }" />
								<input type="hidden" id="replyWriter" name="reply_writer"
									value="${reply.reply_writer }" />
								<input type="hidden" name="memNo" value="${loginMember.memNo}">
								<input type="hidden" name="cmNo" value="${community.cmNo }" id="cmNo">
								<c:if test="${reply.childReply eq null }">
								<span class="reply-btnbox btn-reply">답글달기</span>&nbsp;&nbsp;
								</c:if> 
								<c:if test="${loginMember.memNick ne reply.mem_nick }">
								<span data-toggle="modal" data-target="#reportModal" class="reply-btnbox replyModal">
								신고하기 
								</span>
								</c:if>&nbsp;&nbsp;
			       				<span class="reply-btnbox" onclick="fn_deleteReply();">삭제하기</span>
						</div>
					</div>
					<div class="replyDiv" style="display: none;">
						<textarea name="reply-content2" class="reply-content2" cols="60"
							rows="3"></textarea>
						<input type="hidden" name="reply_id" class="replyId"
							value="${reply.reply_id}" />
						<button class="btn-insert2 btn btn-outline-success" onclick="rereply(event);">답글등록</button>
					</div>
					</td>
			</tr>
		</c:if>
		<c:if test="${reply.childReply!=null}">
			<tr class="level2" id="level2">
				<td><img
					src="${path}/resources/upload/profile/${reply.childReply.mem_pro}"
					width="30px" height="30px"> <span class="reply-writer"><c:out
							value="${reply.childReply.mem_nick }" /></span> <span><c:out
							value="${reply.childReply.register_datetime }" /></span> <br>
					<div>
						<c:out value="${reply.childReply.reply_content }" />
					</div>
						<div>
						<div class="text-right">
								<input type="hidden" name="reply_id" id="replyId"
									value="${reply.reply_id }" />
								<input type="hidden" id="replyWriter" name="reply_writer"
									value="${reply.reply_writer }" />
								<input type="hidden" name="memNo" value="${loginMember.memNo}" id="memNo">
								<input type="hidden" name="cmNo" value="${community.cmNo }" id="cmNo">
									<c:if test="${loginMember.memNick ne reply.mem_nick }">
								<span data-toggle="modal" data-target="#reportModal"
									    class="reply-btnbox replyModal">신고하기 
							    </span>
								</c:if>
								  &nbsp;&nbsp;
					       		<span class="reply-btnbox" onclick="fn_deleteReply();">삭제하기</span>
						</div>
					</div>
				<td></td>
			</tr>
		</c:if>
	</c:forEach>
</table>


  
				<!-- 페이징바 -->
				 <div class="pageBar" >	
					${pageBar }
				</div>
				
<script>
//$(document).on("click",".btn-insert2",e=>{
 function rereply(e){
    console.log("click2");	
    
    var cmNo = $("#cmNo").val();
    console.log(cmNo);  
    var memNo = "${loginMember.memNo}";
    console.log(memNo);
    var replyId = $(e.target).prev().val();
    var replyContent = $(e.target).prev().prev().val();
    console.log(e.target);
    e.stopPropagation();
   
    $.ajax({
    	url:"${path}/community/insertReReply",
    	data:{board_id:cmNo,mem_no:memNo,parent_id:replyId,reply_content:replyContent},
    	success: data => {
    		if(data>0){
    			location.href="${path}/community/communityView.do?cmNo="+cmNo;
   
    		}
    		
    	}
    });
    
    
    
 };
</script>

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
				<form action="${path }/community/reportReply" name="reportFrm" method="post">
					<label class="containerReply">주제와 맞지 않음 
						<input type="checkbox" name="com_reason" value="주제와 맞지 않음"> 
						<span class="checkmark"></span>
					</label><br> 
					<label class="containerReply">정보가 부정확함 
						<input type="checkbox" name="com_reason" value="정보가 부정확함"> 
						<span class="checkmark"></span>
					</label><br>
					<label class="containerReply">지나친 광고성 게시물 
						<input type="checkbox" name="com_reason" value="지나친 광고성 게시물"> 
						<span class="checkmark"></span>
					</label><br> 
					<label class="containerReply">욕설/비방이 심함 
						<input type="checkbox" name="com_reason" value="욕설/비방이 심함"> 
						<span class="checkmark"></span>
					</label><br> 
					<label class="containerReply">기타 
						<input type="checkbox" name="com_reason" value="기타"> 
						<textarea name="com_reason" cols="20" rows="3"></textarea> 
						<span class="checkmark"></span>
					</label> 
					<input type="hidden" name="com_status" value="Y" />
					<input type="hidden" class="cmNo" name="board_id">
					<input type="hidden" class="replyId" name="reply_id" >
					<button type="submit" class="reporty btn btn-outline-success">
						신고하기
					</button>
				</form>

			</div>
			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			</div>

		</div>
	</div>
</div>

<script>
							
							//댓글 로그인 체크
				           	$(function() {
				           		$(".loginCheck").click(function() {
				           			swal("로그인을 먼저 해주세요");
				           		});
				           	});
				           	
							 //모달에 고유값을 클릭했을 때 
						     $(".replyModal").click(function(){
						    	 let replyId = $(this).parent().children('input[name="reply_id"]').val(); //변수에 답글번호를 가져온다.
						    	 let replyWriter = $(this).parent().children('input[name="reply_writer"]').val();
						    	 console.log(replyId);
						    	 let cmNo = $("#cmNo").val();
						    	 console.log(cmNo);
						    	 
						    	 $(".cmNo").val(cmNo);
						    	 $(".replyId").val(replyId); //모달창에 답글 번호 쏴주기 
						    	 $(".replyWriter").val(replyWriter)
						    	 
						     })
						     
      	function fn_deleteReply(){
    	var msg = confirm("댓글을 삭제합니다"); //댓글 삭제 메세지
    	if(msg == true){ //확인을 누 경우
    		var cmNo = $("#cmNo").val();
    	    console.log(cmNo);
    		let reply_id = $(event.target).parent().children('input[name=reply_id]').val();
        	location.replace("${path}/community/deleteReply?cmNo="+cmNo+"&reply_id=" + reply_id); 
    	}
    	else{
    		return false; //삭제 취소
    	}
    	
    };
						
  	
  	//대댓글 등록창
  	$(".btn-reply").click(function(){
  		if($(this).parent().parent().next(".replyDiv").css('display')=='none'){
  			$(this).parent().parent().next(".replyDiv").css('display','block');
  		}else{
  			$(this).parent().parent().next(".replyDiv").css('display','none');
  		}
  		});
  	
  	
    
    
	</script>

<br>
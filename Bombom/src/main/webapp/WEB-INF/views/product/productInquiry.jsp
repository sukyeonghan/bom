<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<style>
/*상품문의 박스 스타일*/
div.wrap-category {
	margin: 7px 0px 7px 0px;
	text-align: left;
}
.span_textarea {
	position: relative;
	padding: 8px;
	width: auto;
	border: lightslategray 1px solid;
	border-radius: 4px;
	display: inline-block;
	width: 100%;
	height: 200px;
}
textarea {
	width: 99%;
	height: 80%;
	resize: none;
	border: none;
}
textarea:focus {
	outline: none;
}
textarea.inqContent {
	width: 100%;
	height: 100%;
	resize: none;
	border: none;
	margin: 7px 0 7px 0;
}
textarea.answer {
	width: 100%;
	height: 100%;
	resize: none;
	border: none;
	margin: 7px 0 7px 0;
}
/* 상품문의 모달창 */
#modalClick {
	cursor: pointer;
}
.pageBar{
	text-align: center;
}
</style>
		    	<!-- 상품문의 시작 -->
				<input type="hidden" id="pdtNo" value="${pdtNo }"/>
			        <!--상품문의 작성창-->
			        <form name="frm_inquiry" action="${path}/product/insertInquiry" onsubmit="return fn_check()">
				        <div class="writebox_wrap container" style="float:none; margin:10px 0 10px 0;">
				            <button type="button" class="btn btn-success showBox">상품문의</button>
					        <div class="wrap-category" style="display:none;">
						        <span class="span_textarea">
							        <textarea name="inqContent" id="inqContent" placeholder="문의내용을 입력해주세요" onKeyUp="javascript:fnChkByte1(this,'500')"></textarea>
									<div style="float:right;">
										<span id="byteInfo1">0</span>/500bytes
								        <label>
						 		        	<img id="lockUnlock" src="${path}/resources/images/product/unlock.png" name="inqSecret" style="width:25px;height:25px;">
								        	<input type="hidden" id="secret" name="inqSecret" value="N">
								        </label>
								        <c:if test="${loginMember!=null }">
								        	<input type="hidden" name="pdtNo" value="${pdtNo}">
								        	<input type="hidden" name="memNo" value="${loginMember.memNo}">
								        	<input type="submit" class="btn btn-success" value="등록" style="right:0;">
								        </c:if>
								        <c:if test="${loginMember==null }">
								        	<input type="button" class="btn btn-success loginCheck" value="등록" style="right:0;">
								        </c:if>
						        	</div>
						        </span>
					        </div>
				        </div>
			        </form><!-- 상품문의 작성창 끝 -->
			        
			        <!-- 상품문의 게시글 -->
			        <div id="result">
				        <div class="container">
						    <c:if test="${not empty list }">	
					        <table class="table" style=" table-layout: fixed;">
						        <thead>
						        	<tr>
						        		<td style="width:10%;">상태</td>
						        		<td style="width:65%;">내용</td>
						        		<td style="width:20%;">문의날짜</td>
						        		<td style="width:15%;">작성자</td>
						        	</tr>
						        </thead>
								<c:forEach items="${list}" var="i">
						        	<thead>
						        		<tr>
						        			<td>
						        				<c:out value="${i.inqAnswerYn=='Y'?'답변완료':'답변대기'}"/>
						        			</td>					        		
						        			<td style="width:100%;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;">
						        				<c:if test="${i.inqSecret=='N'}">
						        					<a href="#" data-toggle="modal" data-target="#inquiryView" data-no='<c:out value="${i.inqNo}"/>' data-content='<c:out value="${i.inqContent }"/>'
						        						data-answeryn='<c:out value="${i.inqAnswerYn}"/>' data-date='<fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/>' data-memnick='<c:out value="${i.memNick}"/>'
						        						data-answer='<c:out value="${i.inqAnswer}"/>' data-answerdate='<fmt:formatDate type="both" timeStyle="short" value="${i.inqAnswerDate}"/>'
						        						data-secret='<c:out value="${i.inqSecret}"/>' data-memno='<c:out value="${i.memNo}"/>' data-loginno='<c:out value="${loginMember.memNo}"/>'>
						        						<c:out value="${i.inqContent }"/>
						        					</a>
						        				</c:if>
						        				<c:if test="${i.inqSecret=='Y' and loginMember.memNo==i.memNo }">
						        					<img src="${path}/resources/images/product/lock.png" style="width:20px;height:20px;">
						        					<a href="#" data-toggle="modal" data-target="#inquiryView" data-no='<c:out value="${i.inqNo}"/>' data-content='<c:out value="${i.inqContent }"/>'
						        						data-answeryn='<c:out value="${i.inqAnswerYn}"/>' data-date='<fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/>' data-memnick='<c:out value="${i.memNick}"/>'
						        						data-answer='<c:out value="${i.inqAnswer}"/>' data-answerdate='<fmt:formatDate type="both" timeStyle="short" value="${i.inqAnswerDate}"/>'
						        						data-secret='<c:out value="${i.inqSecret}"/>' data-memno='<c:out value="${i.memNo}"/>' data-loginno='<c:out value="${loginMember.memNo}"/>'>
						        						<c:out value="${i.inqContent }"/>
						        					</a>
						        				</c:if>
						        				<c:if test="${i.inqSecret=='Y' and loginMember.memNo!=i.memNo}">
						        					<img src="${path}/resources/images/product/lock.png" style="width:20px;height:20px;">
						        					<a href="#" onclick="secretCk();">
						        					<c:out value="${i.inqContent }"/></a>
						        				</c:if>					        		
						        			</td>
						        			<td><fmt:formatDate type="both" timeStyle="short" value="${i.inqDate }"/></td>
						        			<td>
						        				<c:out value="${i.memNick}"/>
						        			</td>
						        		</tr>
						        	</thead>
						        </c:forEach>
						    	</table>
						        <div class="pageBar">
									<span>${pageBar }</span>
						    	</div>
					        </c:if>
					        <c:if test="${empty list }">
					        <table>
					        	<thead>
					        		<tr>
					        			<td colspan="4">등록된 문의가 없습니다</td>
					        		</tr>
					        	</thead>
					        </table>
					        </c:if>
				        </div><!-- 상품문의 게시글 끝 -->			        
			    	</div><!-- result 끝 -->
			        
			      <!-- 상품문의 모달창 -->
				  <div class="modal fade" id="inquiryView" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
				    <div class="modal-dialog">
				      <div class="modal-content">
				      
				        <!-- Modal Header -->
				        <div class="modal-header">
				          <h5 class="modal-title">상품문의</h5>
				          <button type="button" class="close" data-dismiss="modal">X</button>
				        </div>
				        
				        <!-- Modal body --> 
				        <div class="modal-body container">
				        	<!-- 상품문의 내용 -->
				        	<strong><span id="memNick"></span></strong>&nbsp;&nbsp;<span id="inqDate"></span>&nbsp;&nbsp;&nbsp;&nbsp;
				        	<input type="hidden" name="inqNo" class="inqNo"/>
							<div id="btn_secret" style="display:inline-block;">
					        	<input type="button" class="btn btn-outline-success btn-sm fn_updateInquiry" value="수정">
					        	<input type="button" class="btn btn-outline-success btn-sm deleteInquiryCk" data-confirm="문의를 삭제하시겠습니까?" value="삭제"><br>
				        	</div>
				        	<textarea class="inqContent" name="inqContent" id="textCk" style="background-color:#fff;" disabled></textarea>
				        	<hr>
				        	<!-- 상품문의 관리자 답변 내용 -->
				        	<strong><span>관리자</span></strong>&nbsp;&nbsp;<span class="answerDate"></span>&nbsp;&nbsp;&nbsp;&nbsp;
				        	<!-- 관리자로 로그인 했을시&&답변이 있을경우에만 수정,삭제창 생김 -->
				        	<c:if test="${loginMember.memManagerYn=='Y'}">
				        		<div id="secret2" style="display:inline-block;">
					        		<input type="button" class="btn btn-outline-success btn-sm fn_updateInquiryAnswer" value="수정">
					        		<input type="button" class="btn btn-outline-success btn-sm deleteAnswerCk" data-confirm="답변을 삭제하시겠습니까?" value="삭제"><br>
				        		</div>
				        	</c:if>
				        	<textarea class="answer" name="inqAnswer" id="textAnswerCk" style="background-color:#fff;" disabled></textarea>
				        </div>
				        <!-- 모달창 상품문의 답변창 시작, 관리자일 경우에만 답변창 생김-->
				        <c:if test="${loginMember.memManagerYn=='Y'}">
					        <div id="answerCheck">
						        <form name="frm_inquiryAnswer" action="${path}/inquiry/insertInquiryAnswer" onsubmit="return fn_answerCheck()">
							        <div class="writebox_wrap container" style="float:none; margin:10px 0 10px 0;">
									    <span class="span_textarea" style="height:150px; ">
											<textarea name="inqAnswer" class="inqAnswer" placeholder="답변을 입력해주세요" style="height:70%;"></textarea>
											<div style="float:right;">
												<c:if test="${loginMember!=null }">
													<input type="hidden" name="memNo" value="${loginMember.memNo}">
													<input type="hidden" name="inqNo" class="inqNo"/>
													<input type="hidden" name="pdtNo" value="${pdtNo}">
													<input type="submit" class="btn btn-success" value="등록" style="right:0;">
												</c:if>
												<c:if test="${loginMember==null }">
													<input type="button" class="btn btn-success loginCheck" value="등록" style="right:0;">
												</c:if>
										    </div>
									    </span>
							        </div>
						        </form>
					        </div>
				        </c:if><!-- 모달창 상품문의 답변창  끝 -->			        	
				      </div>
				    </div>
				  </div><!-- 상품문의 모달창 끝! -->
				
				
				
<script>
	$(function() {
		$(".showBox").click(function() {
			//상품문의 클릭 시 박스 보였다가 안보였다가 이벤트
			if ($(this).next().css("display") == "none") {
				$(this).next().show(1000);
			} else {
				$(this).next().hide(1000);
			}
		});
	});
			
	
	
	//상품문의 자물쇠그림바꾸기 + 비밀글 파라미터값 넘기기
	$("#lockUnlock").click(function() {
		$(this).attr("src", function(index, attr) {
			if(attr.match("unlock")) {
				$("#secret").attr("value",function(index,attr){ 
					if(attr.match("N")){
						console.log("Y");
						return attr.replace("N","Y");
					}
				});
				return attr.replace("unlock.png", "lock.png");
			} else {
				$("#secret").attr("value",function(index,attr){
					if(attr.match("Y")){
						console.log("N");
						return attr.replace("Y","N");
					}
				});
				return attr.replace("lock.png", "unlock.png");
			}
		});
	});
	
	//상품문의 Byte 수 체크 제한
	function fnChkByte1(obj, maxByte) {
	  var str = obj.value;
	  var str_len = str.length;
	  var rbyte = 0;
	  var rlen = 0;
	  var one_char = "";
	  var str2 = "";
	  for(var i = 0; i<str_len; i++) {
	    one_char = str.charAt(i);
	    if(escape(one_char).length > 4) {
	      rbyte += 3; //한글2Byte
	    }else{
	      rbyte++; //영문 등 나머지 1Byte
	    }
	    if(rbyte <= maxByte){
	      rlen = i + 1; //return할 문자열 갯수
	    }
	  }
	  if(rbyte > maxByte) {
	    // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    swal("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.");
	    str2 = str.substr(0, rlen); //문자열 자르기
	    obj.value = str2;
	    fnChkByte1(obj, maxByte);
	  }else{
	    document.getElementById("byteInfo1").innerText = rbyte;
	  }
	}   
	
	
	//구매하기,장바구니,찜하기,상품문의 클릭 시 로그인 체크
	$(function() {
		$(".loginCheck").click(function() {
			swal("로그인을 먼저 해주세요");
		});
	});
	
	
	//상품문의 클릭 시 입력확인
	function fn_check(){
		if(frm_inquiry.inqContent.value==""){
			swal("문의내용을 입력해주세요");
			return false;
		}
		return true;
	}	
	
	//상품문의 페이징
	$(function(){
		$(".pageBar").click(e=>{
			//console.log($(e.target).val());
			$.ajax({
				url:"${path}/product/productInquiryAjax",
				data:{cPage:"${cPage}",numPerpage:"${numPerPage}",pdtNo:"${pdtNo}"},
				type:"get",
				dataType:"html",
				success:data=>{
					//console.log(data);
					$("#result").html("");
					$("#result").html(data);
				}
			});
		});
	});	
	
	//상품문의 상세보기 답변입력확인
	function fn_answerCheck(){
		if(frm_inquiryAnswer.inqAnswer.value==""){
			swal("답변을 입력해주세요");
			return false;
		}
		return true;
	}	
	
	//상품문의 답변삭제
	$(".deleteInquiryCk").on("click",function(e){
		e.preventDefault();
		var choice = confirm($(this).attr('data-confirm'));
		if(choice){
			let inqNo = $(event.target).parents().children('input[name=inqNo]').val();
			let pdtNo = $("#pdtNo").val();
			location.replace("${path}/inquiry/deleteInquiry?inqNo="+inqNo+"&pdtNo="+pdtNo);
		}
	});
	
	//상품문의 관리자 답변삭제
	$(".deleteAnswerCk").on("click",function(e){
		e.preventDefault();
		var choice = confirm($(this).attr('data-confirm'));
		if(choice){
			let inqNo = $(event.target).parents().children('input[name=inqNo]').val();
			let pdtNo = $("#pdtNo").val();
			location.replace("${path}/inquiry/deleteInquiryAnswer?inqNo="+inqNo+"&pdtNo="+pdtNo);
		}	
	});
	
	//비밀글 접근제한
	function secretCk(){
		swal("작성자와 관리자만 접근할 수 있는 글입니다");
	}
	//상품문의 수정버튼 클릭 시 
	$(".fn_updateInquiry").click(function(){
		//수정 -> 수정완료버튼으로 바꾸고, textarea 활성화
		if($("textarea[id=textCk]").attr("disabled")){
			$(this).attr("value",function(index,attr){
				if(attr.match("수정")){
					console.log("수정완료");
					return attr.replace("수정","수정완료");
				}
			});
			$("textarea[id=textCk]").attr("style","border:lightslategray 1px solid;border-radius:4px;padding:8px;");
			return $("textarea[id=textCk]").removeAttr("disabled");
		}else{
			//수정완료 누를 시 수정한 내용 update
			$(this).attr("value",function(index,attr){
				if(attr.match("수정완료")){
					let pdtNo = $("#pdtNo").val();
					let inqNo = $(event.target).parents().children('input[type=hidden][name=inqNo]').val();
					let inqContent = $(event.target).parents().children('textarea[name=inqContent]').val();
					location.replace("${path}/inquiry/updateInquiry?inqNo="+inqNo+"&pdtNo="+pdtNo+"&inqContent="+inqContent);
				}
			});
			$("textarea[id=textCk]").attr("style","background-color:#fff;");
			return $("textarea[id=textCk]").attr("disabled","");
		}
	});	
	
	//상품문의 관리자답변 수정버튼 클릭 시 
	$(".fn_updateInquiryAnswer").click(function(){
		//수정 -> 수정완료버튼으로 바꾸고, textarea 활성화
		if($("textarea[id=textAnswerCk]").attr("disabled")){
			$(this).attr("value",function(index,attr){
				if(attr.match("수정")){
					console.log("수정완료");
					return attr.replace("수정","수정완료");
				}
			});
			$("textarea[id=textAnswerCk]").attr("style","border:lightslategray 1px solid;border-radius:4px;padding:8px;");
			return $("textarea[id=textAnswerCk]").removeAttr("disabled");
		}else{
			//수정완료 누를 시 수정한 내용 update
			$(this).attr("value",function(index,attr){
				if(attr.match("수정완료")){
					let pdtNo = $("#pdtNo").val();
					let inqNo = $(event.target).parents().children('input[type=hidden][name=inqNo]').val();
					let inqAnswer = $(event.target).parents().children('textarea[name=inqAnswer]').val();
					location.replace("${path}/inquiry/updateInquiryAnswer?inqNo="+inqNo+"&inqAnswer="+inqAnswer+"&pdtNo="+pdtNo);
				}
			});
			$("textarea[id=textAnswerCk]").attr("style","background-color:#fff;");
			return $("textarea[id=textAnswerCk]").attr("disabled","");
		}
	});
	
	//상품문의 상세보기 모달창
	$(document).ready(function(){
		$("#inquiryView").on("show.bs.modal",function(event){ //modal 윈도우가 오픈할 때 아래 옵션 적용
			var a = $(event.relatedTarget); //이벤트 적용시 모달 윈도우 오픈하는 a 태그
			var inqNo = a.data("no");
			var inqContent = a.data("content"); //a태그에서 data-content 값을 inqContent에 저장
			var inqDate = a.data("date");
			var memNick = a.data("memnick");
			var answerYn = a.data("answeryn");
			var answer = a.data("answer");
			var answerDate = a.data("answerdate");
			var inqSecret = a.data("secret");
			var memNo = a.data("memno");
			var loginno = a.data("loginno");
			var modal = $(this);
				
			//로그인 한 사람==게시글 작성자 일 경우에만 수정,삭제버튼 생성
	        if(memNo==loginno){
	        	$("div[id=btn_secret]").show();
	        }else{
	        	$("div[id=btn_secret]").hide();
	        }
				
			//관리자로 로그인 시, 1.답변이 있을경우에만 수정,삭제버튼 생성, 2.답변완료 시 답변창 없애기
			if(answerYn=='Y'){
				$("div[id=secret2]").show();
				$("div[id=answerCheck]").hide();
			}else{
				$("div[id=secret2]").hide();
				$("div[id=answerCheck]").show();
			}
			
			modal.find(".inqNo").val(inqNo);
			modal.find(".inqContent").text(inqContent); //모달창에서 .modal-body에 inqContent값을 출력
			modal.find("#inqDate").text(inqDate);
			modal.find("#memNick").text(memNick);
			modal.find(".answerYn").text(answerYn);
			modal.find(".answer").text(answer);
			modal.find(".answerDate").text(answerDate);
			
			
		});
	});	
</script>				
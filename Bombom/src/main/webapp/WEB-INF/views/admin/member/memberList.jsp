<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<style>
	#flexDiv {
	display: flex;
	padding: 0px 10% 0px 10%;
	}
	#admin-container {
		min-width: 800px;
		width: 100%;
		padding-right:60px;
	}
	/*페이지 타이틀*/
	.page-title{margin-bottom:20px;}
	#admin-member-div{
		display:flex;justify-content:space-between;align-items: center;margin-bottom:20px;
	}
	table#memberTbl th{text-align:center; cursor: default;}
	table#memberTbl td{vertical-align: middle; cursor:default;}
	table#memberTbl td{text-align:center;}
	table#memberTbl td:nth-of-type(2){text-align:left;}
	table#memberTbl td:nth-of-type(4){text-align:right;}
	
	.warnA:hover{text-decoration: none;}
	
	#searchBox{text-align:center; margin:auto; height: 40px; width:100%; margin-top: 20px;}
	#searchBox>*{height: 40px;}
	
	.choiceBack{background-color:#E0FFDB; }
	.d-day{color: #45A663; font-size: 15px; margin:0;}
	#mem-modal-tbl{width:100%;}
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
 <!-- CK에디터. CDN -->
<script src="https://cdn.ckeditor.com/4.15.1/standard/ckeditor.js"></script> 
<%-- <script type="text/javascript" src="${path }/resources/ckeditor/ckeditor.js"></script> --%>
<script>
$(document).ready(function () {
     CKEDITOR.replace( 'emailText', {//해당 이름으로 된 textarea에 에디터를 적용
         width:'100%',
         height:'350px',
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
             
});
</script>

<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp" />
		<!-- 우측 메뉴내용 -->
		<div id="admin-container">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">회원관리</h3> 
			<div id="admin-member-div">
				<div>
					<button class="btn btn-success" data-toggle="modal" data-target="#member-mail-Modal" onclick="fn_emailModal();">선택메일전송</button>
				</div>
				<div>
					<select name="filter" class="form-control" onchange="fn_changeSelect();">
						<option value="dateUp">회원가입 과거순</option>
						<option value="dateDown" selected>회원가입 최근순</option>
						<option value="pointUp">적립금 낮은순</option>
						<option value="pointDown">적립금 높은순</option>
						<option value="badUp">악성댓글 낮은순</option>
						<option value="badDown">악성댓글 높은순</option>
						<option value="outDateUp">탈퇴일 과거순</option>
						<option value="outDateDown">탈퇴일 최근순</option>
						<option value="lastDateUp">방문일 과거순</option>
						<option value="lastDateDown">방문일  최근순</option>
						<option value="manager">관리자순</option>    
					</select>
				</div>
			</div>
			<div class="table-responsive" id="result">
				<table id="memberTbl" class="table">
					<thead>
						<tr>
							<th><input type="checkbox" id="allCheckbox"/></th>
							<th>이메일</th>
							<th>닉네임</th>
							<th>적립금</th>
							<th>악성댓글</th>				
							<th>최근방문날짜</th>				
							<th>탈퇴날짜</th>				
							<th>관리자권한</th>								
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="member" varStatus="vs">
							<tr>
							
								<td><input type="checkbox" id="mem${vs.index }" name="sendMemNo" class="mem-check" value="${member.memNo }"/></td>
								<td><c:out value="${member.memEmail }"/></td>
								<td class="memNick-td">
									<c:if test="${member.memManagerYn eq 'Y'}">
										<img src="${path }/resources/images/icon/crown.png" height="25px;">
									</c:if>
									<span><c:out value="${member.memNick }"/></span>
								</td>
								<td><fmt:formatNumber type="number" value="${member.memPoint }"/></td>
								<c:if test="${member.memWarnCount >= 10}">
									<td id="black" >
									<a href="#" data-toggle="tooltip" data-placement="top" class="warnA" title="신고당한 횟수: ${member.memWarnCount}번">
									<strong class="text-danger">커뮤니티차단</strong></a></td>
								</c:if>
								<c:if test="${member.memWarnCount < 10}">
									<td><c:out value="(${member.memWarnCount}/10)"/></td>
								</c:if>
								
								<td>
									<fmt:formatDate type="both" timeStyle="short" dateStyle="short" value="${member.memLastDate }"/>
									<p class="d-day">
										<c:if test="${member.last<=-180 }"><strong style="color:red;">장기미접속자</strong></c:if>
										<c:if test="${member.last<0}">(<c:out value="${member.last }"/>일)</c:if>
									</p>
								</td>
								<td>
									<c:if test="${member.memStatus eq 'Y'}">
										<fmt:formatDate type="date" dateStyle="short" value="${member.memOutDate }"/>
										<c:if test="${member.out<0 }"><p class="d-day">(<c:out value="${member.out }"/>일)</p></c:if>
									</c:if>
								</td>
								<td class="memManagerYnTd">
									<%-- <span><c:out value="${member.memManagerYn}"/></span>&nbsp;&nbsp; --%>
									<input type="hidden" value="${member.memNo }" name="memNo"/>
									<c:if test="${member.memManagerYn eq 'N'}">
										<button class="btn btn-info managerYnBtn">권한부여</button>
									</c:if>
									<c:if test="${member.memManagerYn eq 'Y'}">
										<button class="btn btn-danger managerYnBtn">권한회수</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<br>
				<div id="pageBar">
					${pageBar }
	    		</div> 
	    		
			</div>
			<!-- 검색박스 -->
			<div id="searchBox" >
				<select name="searchType">
					<!-- <option value=" " disabled selected>검색타입</option> -->
					<option value="email">이메일</option>
					<option value="nick">닉네임</option>
					<option value="all" selected>이메일+닉네임</option>
				</select>
				<input type="text" id="keyword" name="keyword" placeholder="검색어를 입력해주세요" size="50" list="data" required>
				<datalist id="data"></datalist>
				<input type="button" class="btn btn-success"  value="검색" onclick="return fn_memberSearch();">
			</div>
		</div>
	</div>
</section>


  <!-- 메일 모달 -->
  <div class="modal fade" id="member-mail-Modal">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
      
        <!-- Modal Header -->
        <div class="modal-header">
          <h4 class="modal-title">메일 전송</h4>
          <button type="button" class="close" data-dismiss="modal">X</button>
        </div>
        
        <!-- Modal body -->
        <div class="modal-body">
          <form  method="post" enctype="multipart/form-data" id="emailSendForm" name="mailSendForm">
          <table id="mem-modal-tbl">
          	<tr>
          		<td colspan="2">
          			<div style="display:flex;justify-content: space-between; margin-bottom: 20px;">
	          			<div>
	          			<button type="button" class="btn btn-info" onclick="fn_allEmail();">전체메일</button>
	          			<button type="button" class="btn btn-info" onclick="fn_longEmail();">장기미접속</button>
	          			<button type="button" class="btn btn-info" onclick="fn_eventEmail();">이벤트알림</button>
	          			</div>
	          			<button type="button" class="btn btn-success" onclick="return fn_send();"><i class="fas fa-share"></i> 보내기</button>
          			</div>
          		</td>
          	</tr>
          	<tr>
          		<th>받는사람</th>
          		<th><input type="text" class="form-control"  name="emailReceiver" required/></th>
          	</tr>
          	<tr>
          		<th>제목</th>
          		<th><input type="text" class="form-control" name="emailSubject" value="[다시:봄]" required/></th>
          	</tr>
          	<tr>
          		<th>파일첨부</th>
          		<th><input type="file" name="emailFile" multiple/></th>
          	</tr>
          	<tr>
          		<td colspan="2">
          			<textarea name="emailText" id="emailText"></textarea>
          		</td>
          	</tr>
          </table>
          </form>
        </div>
        
        <!-- Modal footer -->
        <div class="modal-footer">
         <!--  <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button> -->
        </div>
        
      </div>
    </div>
  </div>
<script>
//필터링 선택시 실행될 함수
function fn_changeSelect(){
	let filter=$("select[name=filter]").val();
	let select=$("select[name=searchType]").val();		
	let keyword=$("#keyword").val();
	if("${select}"!=""){
		select="${select}"
	}
	if("${keyword}"!=""){
		keyword="${keyword}"
	}

 	$.ajax({
		url:"${path}/admin/selectMemberSearch",
		data:{cPage:"${cPage}",numPerpage:"${numPerpage}",searchType:select,keyword:keyword,filter:filter},
		dataType:"html",
		success:data=>{
			$("#result").html("");	
			$("#result").html(data);	
		}
	}); 
	
};
//검색시 실행될 함수
$("#keyword").keyup(function(e){
	if(e.keyCode == 13){fn_memberSearch(); }
});	
function fn_memberSearch(){
	let select=$("select[name=searchType]").val();
	let keyword=$("#keyword").val().trim();
	$("#keyword").val(keyword);
	if(select==" "||select == null) {
		swal("검색타입을 선택해주세요.");
		return false;
	}
	if(keyword.length<1){
		swal("검색어를 입력해주세요.");
		return false;
	}
	
 	$.ajax({
		url:"${path}/admin/selectMemberSearch",
		data:{cPage:"${cPage}",numPerpage:"${numPerpage}",searchType:select,keyword:keyword,filter:"$[filter}"},
		dataType:"html",
		success:data=>{
			$("#result").html("");	
			$("#result").html(data);	
		}
	}); 
	
}
$(function(){

 //툴팁
 $('[data-toggle="tooltip"]').tooltip();   
 
 //매니저권한부여 버튼 클릭시
 $(document).on("click",".managerYnBtn",e=>{
	let adminYn=$(e.target).text(); 
	let yn="";
	let msg="";
	let memNo=$(e.target).prev().val();
	let nick=$(e.target).parent().prevUntil(".memNick-td").children("span").text();
	if(adminYn=="권한부여"){
		yn="Y";
		msg="매니저로 전환하시겠습니까?";
	}else{
		yn="N";
		msg="매니저권한을 회수 하시겠습니까?";
	}
	swal({
 	     text: msg,
 	     icon: "info",
 	     buttons: ["아니오", "네"],
 	}).then((yes) => {
 	     if (yes) {
 	    	$.ajax({
 	    		url:"${path}/admin/updateManagerYn",
 	    		data:{memManagerYn:yn,memNo:memNo},
 	    		dataType:"json",
 	    		async: false,
 	    		success:data=>{
 	    			if(data===true){
 	    				if(adminYn=="권한부여"){
 	    					$(e.target).addClass("btn-danger");
 	    					$(e.target).removeClass("btn-info");
 	    					$(e.target).html("권한회수");		 	    
 	    					let crown=$("<img>").prop("src",'${path}/resources/images/icon/crown.png');
 	    					crown.attr("height","25px");
 	    					$(e.target).parent().parent().children(".memNick-td").prepend(crown);
 	    					
 	    				}else{
 	    					$(e.target).removeClass("btn-danger");
 	    					$(e.target).addClass("btn-info");
 	    					$(e.target).html("권한부여");
 	    					$(e.target).parent().parent().children(".memNick-td").children("img").remove();
 	    				}
 	    				
 	    				
 	    	 	    	let alarmMsg="";
 	    	 	    	
 	    	 	    	if(yn=="Y") {
 	    	 	    		alarmMsg="축하드립니다.관리자가 되었습니다.";
 	    				}else {
 	    					alarmMsg="관리자 권한이 회수되었습니다.";
 	    				}
 	    	 	 	   	//알림 DB저장
 	    	 	 	   	$.ajax({
 	    	 	 	   		type : 'post',
 	    	 	 	   		url : '${path}/member/insertAlarm',
 	    	 	 	   		data : {receiverNo:memNo,message:alarmMsg}, //json을 스트링으로 변환
 	    	 	 	   		dataType : 'json',
 	    	 	 	   		success : function(data){
 	    	 	 	   			if(data===true){
 	    	 	 	   				console.log("ajax갔다옴:"+data);
 	    	 	 	   				if(sock){
 	    	 	 	   					console.log("소켓생성됨:"+sock);
 	    	 	 	   				let socketMsg = "adminYn,관리자,M0,"+ memNo +","+yn;
 	    	 	 	   				console.log("알림전송내역 : " + socketMsg);
 	    	 	 	   				sock.send(socketMsg);
 	    	 	 	   				}
 	    	 	 	   			}
 	    	 	 	   			
 	    	 	 	    
 	    	 	 	   		},
 	    	 	 	   		error : function(err){
 	    	 	 	   			console.log(err);
 	    	 	 	   		}
 	    	 	 	   	});
 	    			}else{
 	    				swal("관리자 권한 변경 실패");
 	    			}
 	    		},error:(error)=>{
 	    			swal("관리자 권한 변경 실패");
 	    		}
 	    		
 	    	});
 	    	
 	    	
 	    	

 	    	
 	     }
 	});
 });
	

//자동완성
$("#keyword").on("keyup",e=>{
 	let key=$("#keyword").val().trim();
	let select=$("select[name=searchType]").val();
	$.ajax({
 		url:"${path}/admin/memberAutoComplete",
 		data:{key:key,type:select},
 		dataType:"json", 
 		success:data=>{
 			$("#data").html("");
 			for(let i=0;i<data.length;i++){
 				if(key.length>3){
	 				if(select == "nick"){
	 					$("#data").append($("<option>").html(data[i]["memNick"])); 
	 				}
	 				if(select == "email"){
	 					$("#data").append($("<option>").html(data[i]["memEmail"])); 	
	 				}
	 				if(select == "all" || select == null){
	 					$("#data").append($("<option label='닉네임'>").html(data[i]["memNick"])); 						
	 					$("#data").append($("<option label='이메일'>").html(data[i]["memEmail"])); 
	 				}	
 				}
 			}		
 		}
 		
 	});
 	
	

 })
 


	 
})



 
 	//행선택시 체크박스 선택
	$(document).on("click","#memberTbl td",e=>{
		$(e.target).parent().children().children("input[type=checkbox]").click();
	});
	//전체선택
	$(document).on("click","#allCheckbox",e=>{
		let v=$(e.target).is(":checked");
		if(v==true){
			$(".mem-check").prop("checked",true);
			$(".mem-check").parent().parent("tr").addClass("choiceBack");
		}else{
			$(".mem-check").prop("checked",false);
			$(".mem-check").parent().parent("tr").removeClass("choiceBack");
		} 
		cssAndCount(); 
	});
	
	$(document).on("change","input[name=sendMemNo]",e=>{
		let a=$(e.target).is(":checked");
		if(a==true){
			$(e.target).parent().parent("tr").addClass("choiceBack");			
		}else{
			$(e.target).parent().parent("tr").removeClass("choiceBack");
		} 
		cssAndCount();
	});
	
	//전체선택 체크박스 선택,해제
	function cssAndCount(){
		let count=$("input[name=sendMemNo]:checked").length;
		let all=$("input[name=sendMemNo]").length;
		if(count==all){
			$("#allCheckbox").prop("checked",true);
		}else{
			$("#allCheckbox").prop("checked",false);
		}
	}
	
	//모달창 열기 전에 선택한 이메일 모달에 띄우기
	function fn_emailModal(s){
		//기존에 입력한 내용 지우고, 기본값 세팅
		$("input[name=emailReceiver]").val("");
		$("input[name=emailSubject]").val("[다시:봄]");
		$("input[name=emailFile]").val("");
		CKEDITOR.instances.emailText.setData('<h3>회원님,안녕하세요. <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>입니다.</h3><br><br> <h3>문의사항이 있으실 경우 <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>홈페이지 내 1:1문의를 이용해주세요. 감사합니다.</h3>'); 
		
		var emails=[];
		for(let i=0; i<$("input[name=sendMemNo]:checked").length;i++){
			//체크된 회원 이메일 배열에 넣기
			emails.push($("input[name=sendMemNo]:checked").parent().next().eq(i).html());
			$("input[name=emailReceiver]").val(emails); //모달 받는 사람에 데이터 넣기 //ge@gmail.com,bom@bom.com형식
		}
	}
	//모달창 내 전체메일 선택시
	function fn_allEmail(){
		$.ajax({
			url:"${path}/admin/memEmailList",
			data:{search:"all"},
			dataType:"text",
			success:data=>{
				$("input[name=emailReceiver]").val(data);
			}
		});
		$("input[name=emailSubject]").val("[다시:봄]");
		CKEDITOR.instances.emailText.setData('<h3>회원님,안녕하세요. <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>입니다.</h3><br><br> <h3>문의사항이 있으실 경우 <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>홈페이지 내 1:1문의를 이용해주세요. 감사합니다.</h3>'); 
	}
	//모달창 내 장기미접속 선택시
	function fn_longEmail(){
		$.ajax({
			url:"${path}/admin/memEmailList",
			data:{search:"long"},
			dataType:"text",
			success:data=>{
				$("input[name=emailReceiver]").val(data);
			}
		});
		$("input[name=emailSubject]").val("[다시:봄] 장기미접속 안내메일입니다");
		CKEDITOR.instances.emailText.setData('<h3>회원님,안녕하세요. <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>입니다.</h3> 회원님께서 최근 6개월간 접속한 기록이 없으셔서 안내 드립니다.<br> 장시간 미접속시 개인정보 위험이 있사오니 방문하시어 개인정보 수정 부탁드립니다. <h3>문의사항이 있으실 경우 <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>홈페이지 내 1:1문의를 이용해주세요. 감사합니다.</h3>'); 

	}
	//모달창 내 이벤트 선택시
	function fn_eventEmail(){
		$("input[name=emailSubject]").val("[다시:봄] 이벤트 안내메일입니다");
		CKEDITOR.instances.emailText.setData('<h3>회원님,안녕하세요. <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>입니다.</h3> 202X년 00월 00일 ~ 00월 00일까지 "00%할인 이벤트"가 시작되오니 오셔서 즐거운 쇼핑 하시길 바랍니다. <h3>문의사항이 있으실 경우 <a href="https://rclass.iptime.org/20PM_BOM_final/">[다시:봄]</a>홈페이지 내 1:1문의를 이용해주세요. 감사합니다.</h3>'); 
	}
	
	
	//메일전송시 실행될 함수
	function fn_send(){
		var emailReceiver=$("input[name=emailReceiver]").val();
		var emailSubject=$("input[name=emailSubject]").val();
		var emailFile=$("input[name=emailFile]").val();
		var emailText=CKEDITOR.instances.emailText.getData(); //CK에디터 내용받아오기
		if(emailReceiver.length < 1 ){
			swal("받을 이메일주소를 입력해 주세요.");
			return false;
		}else if(emailSubject.length <1){
			swal("제목을 입력해 주세요.");
			return false;
		}else if(emailText.length < 1){
			swal("내용을 입력해 주세요.");
			return false;
		}else{
			
			$("#emailText").html(emailText);
		}

		
		var formData=new FormData($("#emailSendForm")[0]);
		/*console.log($("input[name=emailFile]").val()); */
		$.ajax({
			url:"${path}/email/member",
			type:"POST",
			processData: false, // 필수 
			contentType: false, // 필수 
			encType:"multipart/form-data",
			data:formData,
			dataType:"json",
			success:data=>{
				if(data===true){ 
					//모달창 닫기
					$('#member-mail-Modal').modal("hide"); //닫기 
					swal("이메일 전송이 성공하였습니다.");
					
				}else{
					//모달 창 닫기면 안됨
					swal("이메일 전송이 실패하였습니다.");
				}
			},error:error=>{
				console.log(error);
				swal("이메일 전송이 실패했습니다.");
			}
	    		
		}); 
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
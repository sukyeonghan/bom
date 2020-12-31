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
	.page-title{margin-bottom:5%;}
	table#memberTbl th{text-align:center; cursor: default;}
	table#memberTbl td{vertical-align: middle; cursor:default;}
	table#memberTbl td{text-align:center;}
	table#memberTbl td:nth-of-type(2){text-align:left;}
	table#memberTbl td:nth-of-type(4){text-align:right;}
	
	.warnA:hover{text-decoration: none;}
	
	#searchBox{text-align:center; margin:auto; height: 40px; width:100%; margin-top: 20px;}
	#searchBox>*{height: 40px;}
	
	.choiceBack{background-color:#E6E6FA }
	
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp" />
		<!-- 우측 메뉴내용 -->
		<div id="admin-container">
			<!-- 페이지 타이틀 -->
			<div style="display:flex;justify-content:space-between;align-items: center;">
			<h3 class="page-title">회원관리</h3> 
			<select name="filter" onchange="fn_chageSelect();">
				<option value="date" selected>가입순</option>
				<option value="point">적립금순</option>
				<option value="bad">악성댓글순</option>
				<option value="outDate">탈퇴날짜순</option>
				<option value="lastDate">접속날짜순</option>
				<option value="manager">관리자순</option>
			</select>
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
								
								<td><fmt:formatDate type="date" timeStyle="short" value="${member.memLastDate }"/></td>
								<td>
									<c:if test="${member.memStatus eq 'Y'}">
										<fmt:formatDate type="date" timeStyle="short" value="${member.memOutDate }"/>
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
<script>
//필터링 선택시 실행될 함수
function fn_chageSelect(){
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
 	    			}else{
 	    				swal("관리자 권한 변경 실패");
 	    			}
 	    		},error:(error)=>{
 	    			swal("관리자 권한 변경 실패");
 	    		}
 	    		
 	    	});
 	    	
 	    	
 	    	
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
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
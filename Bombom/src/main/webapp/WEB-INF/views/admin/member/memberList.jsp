<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	table#memberTbl th{text-align:center; cursor: default;}
	table#memberTbl td{vertical-align: middle; cursor:default;}
	table#memberTbl td{text-align:center;}
	table#memberTbl td:nth-of-type(1){text-align:left;}
	table#memberTbl td:nth-of-type(3){text-align:right;}
	
	.warnA:hover{text-decoration: none;}
	
	#searchBox{text-align:center; margin:auto; height: 40px; width:100%; margin-top: 20px;}
	#searchBox>*{height: 40px;}
	
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container" class="container">
	<div class="media">
		<!--관리자 내비게이션바 -->
		<div id="" class=" mr-3 admin-nav">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link select" href="${path }/">회원관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/admin/moveProduct">제품관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">주문관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">1:1문의관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">이벤트관리</a>
		    </li>
		  </ul>
		</div>
		
		<div id="admin-container" class="media-body">
			<!-- 페이지 타이틀 -->
			<div style="display:flex;justify-content:space-between;align-items: center;">
			<h3 class="page-title">회원관리</h3> 
			<select name="filter" onchange="fn_chageSelect();">
				<option value="date" selected>가입순</option>
				<option value="point">적립금순</option>
				<option value="bad">악성댓글순</option>
			</select>
			</div>
			<div class="table-responsive" id="result">
				<table id="memberTbl" class="table table-hover">
					<thead>
						<tr>
							<th>이메일</th>
							<th>닉네임</th>
							<th>적립금</th>
							<th>악성댓글</th>				
							<th>탈퇴여부</th>				
							<th>관리자여부</th>				
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list }" var="member" varStatus="vs">
							<tr>
								<td><c:out value="${member.memEmail }"/></td>
								<td><c:out value="${member.memNick }"/></td>
								<td><fmt:formatNumber type="number" value="${member.memPoint }"/></td>
								<c:if test="${member.memWarnCount >= 10}">
									<td id="black" >
									<a href="#" data-toggle="tooltip" data-placement="top" class="warnA" title="신고당한 횟수: ${member.memWarnCount}번">
									<strong class="text-danger">커뮤니티차단</strong></a></td>
								</c:if>
								<c:if test="${member.memWarnCount < 10}">
									<td><c:out value="(${member.memWarnCount}/10)"/></td>
								</c:if>
								<td><c:out value="${member.memStatus}"/></td>
								<td>
									<span><c:out value="${member.memManagerYn}"/></span>&nbsp;&nbsp;
									<input type="hidden" value="${member.memNo }" name="memNo"/>
									<c:if test="${member.memManagerYn eq 'N'}">
										<button class="btn btn-info managerYnBtn">권한부여</button>
									</c:if>
									<c:if test="${member.memManagerYn eq 'Y'}">
										<button class="btn btn-outline-info managerYnBtn">권한회수</button>
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
					<option value=" " disabled selected>검색타입</option>
					<option value="email">이메일</option>
					<option value="nick">닉네임</option>
					<option value="all">이메일+닉네임</option>
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
 	    					$(e.target).addClass("btn-outline-info");
 	    					$(e.target).removeClass("btn-info");
 	    					$(e.target).html("권한회수");		 	    					
 	    					$(e.target).prev().prev().html("Y");
 	    				}else{
 	    					$(e.target).removeClass("btn-outline-info");
 	    					$(e.target).addClass("btn-info");
 	    					$(e.target).html("권한부여");
 	    					$(e.target).prev().prev().html("N");
 	    				}
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

</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" " />
</jsp:include>
<style>
#flexDiv {
	display: flex;
	padding: 0px 10% 0px 10%;
}

#mypage-container {
	min-width: 800px;
	width: 100%;
	padding-right:100px;
}
/*버튼 가운데정렬*/
.btn-box {
	text-align: center;
}

/* 네비바 스타일 */
button {
	background: none;
	border: 0;
	outline: 0;
	cursor: pointer;
}

button:focus {
	border: none;
	outline: none;
}


.tab_menu_btn {

	height: 40px;
	transition: 0.3s all;
}

.tab_menu_btn.on {
	border-bottom: 1px solid #45A663;
	color: #45A663;
}

.tab_menu_btn:hover {
	color: #45A663;
}

.tab_box {
	display: none;
	padding: 25px;
}

.tab_box.on {
	display: block;
}

.tab_box img {
	width: 80%;
}
/*메뉴  */
.containerMenu{
	border-bottom: 2px solid #45A663;
}

/* 페이지 번호 들어갈 곳 */
.pageBar {
	text-align: center;
	margin-top: 30px;
}
/* 테이블 */
.table th:nth-child(3) {
	width: 600px;
}

.table th, .table td {
	text-align: center;
	vertical-align: middle;
}

.table .th {
	vertical-align: middle;
}
/* 해당상품 이동버튼 */
.moveBtn{
	text-align:center;
}
.movePdt{
	margin: 20px 0 20px 0;
}
/*글 내용 말줄임  */
.textLine {
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 400px;
  height: auto;

  }
/*댓글쪽 말줄임  */
.textShort {
  display: block;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
  width: 530px;
  height: auto;

  }

</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp" />
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container">
			<h3>나의활동</h3>
			<br />
			<!-- Nav tabs -->
			<div class="tab_wrap container">
			<div class="tab_menu_container containerMenu">
			    <button class="tab_menu_btn" id="myReview" type="button">구매평</button>
			    <button class="tab_menu_btn" id="myCommunity" type="button" >커뮤니티글</button>
			    <button class="tab_menu_btn" id="myReply" type="button">댓글</button>
		    </div> <!-- tab_menu_container e -->

			<div class="tab_box_container" >
				<br> <br>
				<!-- 구매평 -->
				<div id="result">
					<table class="table">
						<thead>
							<tr>
								<th style="width:5%"><input type="checkbox" id="selectAll" onclick="selectAll();"></th>
								<th style="width:15%">작성날짜</th>
								<th style="width:30%">상품명</th>
								<th>구매평</th>

							</tr>
						</thead>
						<tbody>
							<c:if test="${empty review }">
								<tr>
									<td class="noData" colspan="5">등록된 글이 없습니다.</td>
								</tr>
							</c:if>
							<c:forEach items="${review }" var="r">
								<tr>
									<td>
										<input type="checkbox" name="check" value="check">
										<input type="hidden" name="delNum" value="${r.revNo }">
									</td>
									<td><fmt:formatDate type="date" timeStyle="short"
											value="${r.revDate }" /></td>
									<td><a class="reviewContent" href="${path }/product/productOne?pdtNo=${r.pdtNo}"><c:out value="${r.pdtName}"/></a></td>
									<td class="textLine"><a class="shortReview" data-toggle="modal" data-target="#fullContent" onclick="modelDetail(event);"><c:out value="${r.revContent }"  /></a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="pageBar">${pageBarR }</div>
					<div id="btn-container">
						<button type="button" class="btn btn-success" onclick="deleteMyReview();">선택삭제</button>
					</div>
				</div>	
				<!--구매평 끝  -->
			</div>
		</div>
	</div>
	</div>
</section>
<div class="modal fade" id="fullContent" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal body -->
				<div class="modal-body container">
					<p class="fullReview"></p>
				</div>
			</div>
		</div>
	</div>
<script>

//구매평 눌렀을 때
$("#myReview").click(e=>{
	//console.log($(e.target).html());
	$.ajax({
		url:"${path}/mypage/myReview",
		data:{cPage:"${cPage}",numPerpage:"${numPerpage}"},
		type:"get",
		dataType:"html",
		success:data=>{
			console.log(data);
			$("#result").html("");
			$("#result").html(data);
		}
	});
});

//커뮤니티글 눌렀을 때
$("#myCommunity").click(e=>{
	//console.log($(e.target).html());
	//$("#review").css("font":"white");
	$.ajax({
		url:"${path}/mypage/myCommunity",
		type:"get",
		dataType:"html",
		success:data=>{
			$("#result").html("");
			$("#result").html(data);
			
		}
	});
});

//커뮤니티글 눌렀을 때
$("#myReply").click(e=>{
	//console.log($(e.target).html());
	//$("#review").css("font":"white");
	$.ajax({
		url:"${path}/mypage/myReply",
		type:"get",
		dataType:"html",
		success:data=>{
			$("#result").html("");
			$("#result").html(data);
			
		}
	});
});
/* $(document).on("click",".shortReview"),e=>{
let content=$(e.target).text();
$(".fullReview").text(content);
}*/
//글 내용 눌렀을때 
function modelDetail(e){
	let content=$(e.target).text();
	$(".fullReview").text(content);
}

//전체선택
	let checkAll = "false";
	let items = document.getElementsByName("check");
	function selectAll() {
		
		if (checkAll == "false") {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = true;
			}
			checkAll = "true";
		} else {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = false;
			}
			checkAll = "false";
		}
	}

//구매평선택 삭제
	function deleteMyReview(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			
			var list=new Array();   
	        for (var i=0; i<items.length; i++){
	        	var check=$("input[name=check]").eq(i);
	            if(check.is(":checked")){
	            	//체크 되어있으면 해당 제품번호를 list에 넣기
	 				check.next().each(function(index,item){
	    				list.push($(item).val());
	    			}); 
	            }
	        }
	        
	        location.href='${path}/mypage/deleteMyReview?revNo='+list;
		}else{
			return false;
		}
	    
	}
//커뮤글 선택삭제
	function deleteMyCommunity(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			
			var list=new Array();   
	        for (var i=0; i<items.length; i++){
	        	var check=$("input[name=check]").eq(i);
	            if(check.is(":checked")){
	            	//체크 되어있으면 해당 제품번호를 list에 넣기
	 				check.next().each(function(index,item){
	    				list.push($(item).val());
	    			}); 
	            }
	        }
	        
	        location.href='${path}/mypage/deleteMyCommunity?cmNo='+list;
		}else{
			return false;
		}
	}


//댓글 선택삭제
	function deleteMyReply(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			
			var list=new Array();   
	        for (var i=0; i<items.length; i++){
	        	var check=$("input[name=check]").eq(i);
	            if(check.is(":checked")){
	            	//체크 되어있으면 해당 제품번호를 list에 넣기
	 				check.next().each(function(index,item){
	    				list.push($(item).val());
	    			}); 
	            }
	        }
	        
	        location.href='${path}/mypage/deleteMyReply?replyNo='+list;
		}else{
			return false;
		}
	}
	
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
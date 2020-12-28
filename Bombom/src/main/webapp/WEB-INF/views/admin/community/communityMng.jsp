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
<style>
/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*반응형 없앤 css*/
	#flexDiv {
	display: flex;
	padding: 0px 10%;
   	}
   	
   	#admin-container {
   	min-width: 800px;
   	width: 100%;
   	padding-right:60px;
   	}
   	
   	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	
	/*제품개수와 필터 정렬*/
	.count-filter{
		display:flex;
		justify-content:space-between;
	}
	
	/*정렬*/
	.sort{
	border:none;
	outline:none;
	}
	
	/*상품 관리 테이블*/
	#reply-table{
		width:100%;
		margin-bottom:20px;
		border-collapse: collapse;
		text-align:center;
		/* padding:5px; */
	}
	th{cursor: default;}
	td{vertical-align: middle; cursor:default;}
	td:nth-of-type(3){text-align:left;}
	td:nth-of-type(4){text-align:left;}
	td:nth-of-type(5){text-align:right;}
	
	/*페이지바*/
    .pageBar{
    	margin:5% 0;
    	text-align:center;
    }
    
     /*검색*/
    #search-wrap{
    	display: flex;
    	justify-content: center;
    	align-items: center;
    }
    #search-text{
    	margin:0 15px;
    }
   	
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="communityMng" value="커뮤니티 관리하기" />
</jsp:include>

<section id="container">
<div id="flexDiv">

<!--관리자 내비게이션바 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp"/>


   <div id="admin-container">
   <!-- 페이지 타이틀 -->
			<h3 class="page-title">커뮤니티 관리</h3> 
   
   <div id="result">
   
                   <div class="count-filter">
					<!-- 카테고리별 개수 -->
					<p >댓글 관리</p>
					<!--카테고리 정렬  -->
					<div class="select-box">
						<select class="sort" id="filter" name="filter" onchange="listChange(this.value)">
							<option value="">전체</option>
							<option value="N">N</option>
							<option value="Y">Y</option>
						</select>
					</div>
				</div>
				
     
   					<div id="listupAjax"></div>
     
				
              <!-- 검색 -->
				<div id="search-wrap">
					<!-- 검색 카테고리 -->
					<div class="select-box">
						<select class="searchSort" name="searchSort" >
							<option value="아이디">아이디</option>
						</select>
					</div>
					<input type="text" id="search-text" name="keyword" size="30">
					<button class="btn btn-success" id="search-btn">검색</button>
				</div>
     
   </div>
  
  </div>
</div>
</section>

<script>

$("#search-btn").click(e=>{
	var keyword = $("#search-text").val();
	$.ajax({
		url : "${path}/admin/community/communityMngAjax",
		data:{order:"",keyword:keyword},
		success: data =>{
			 $("#listupAjax").html(data);
		}
	})
	
})

//화면이 켜졌을 때 바로 실행되는 함수
$(function(){
     //정렬
     $.ajax({
    	 url:"${path}/admin/community/communityMngAjax",
    	 data:{order:"",keyword:""},
    	 success:data=>{
    		 $("#listupAjax").html(data);
    	 }
     })
});

function listChange(value){
	console.log(value);
	
	
	$.ajax({
		url:"${path }/admin/community/communityMngAjax",
		data:{order:value},
		success: data=>{
			$("#listupAjax").html(data);
		}
	});
	
}

//신고접수 버튼 클릭시
$(document).on("click",".memWarnYnBtn",e=>{
	let memWarnYn=$(e.target).text();
	let yn="";
	let msg="";
	let reply_id=$(e.target).prev().val();
	let reply_mem_no=$(e.target).prev().prev().val();
	if(memWarnYn=="신고접수"){
		yn="Y";
		msg="댓글 신고를 접수하시겠습니까?";
	}else{
		yn="N";
		msg="댓글 신고를 거절 하시겠습니까?";
	}
	swal({
		text:msg,
		icon:"info",
		buttons:["아니오","네"],
	}).then((yes) => {
		if(yes){
			$.ajax({
				url:"${path }/admin/community/warnMemberYn",
				data:{com_status:yn,reply_id:reply_id,mem_no:reply_mem_no},
				dataType:"json",
				async: false,
				success:data=>{
					console.log(data);
					if(data.result===true){
						if(memWarnYn=="신고접수"){
							//신고접수 승인시
							$(e.target).addClass("btn-outline-info");
							$(e.target).removeClass("btn-info");
							$(e.target).html("신고거절");
							$(e.target).prev().prev().html("Y");
							//경고수가 10개도달시 알림보내기
							let warnCount=data.replyWriter.memWarnCount;
							let writerNo=data.replyWriter.memNo;
							console.log(warnCount);
							console.log(writerNo);
							if(warnCount==10){
								$.ajax({
						 	   		type : 'post',
						 	   		url : '${path}/member/insertAlarm',
						 	   		data : {receiverNo:writerNo,message:"커뮤니티 권한이 박탈되었습니다."}, 
						 	   		dataType : 'json',
						 	   		success : function(data){
						 	   			if(data===true){
						 	   				if(sock){
						 	   				let socketMsg = "communityOut,관리자,M0,"+writerNo+","+"0";
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
							
						 }else{
							//신고접수 거절시
							$(e.target).removeClass("btn-outline-info");
							$(e.target).addClass("btn-info");
							$(e.target).html("신고접수");
							$(e.target).prev().prev().html("N");
						}  
 	    			}else{
 	    				swal("신고 접수 실패");
 	    			}
 	    		},error:(error)=>{
 	    			swal("신고 접수 실패");
 	    		}
 	    		
 	    	});

 	     }
 	});
 });

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
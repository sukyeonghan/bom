<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<style>
	/*좌측메뉴*/
	#mypage-nav{padding-right:100px;}
	#mypage-nav a{color:black;font-weight:bolder;}
	#mypage-nav a:hover{color: #45A663;}

	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	.right{text-align: right;}
	
	/*찜폴더리스트*/
	#zzimListDiv{display: flex; width:100%; box-sizing:border-box; flex-wrap: wrap; flex-direction: row;}
	#zzimListDiv>*{box-sizing:border-box; cursor: pointer;}
	#zzimListDiv>div:hover{ background-color: #C0C0C0;}
	/*찜폴더*/
	.zzimFolder{ position: relative; width:28%; background-color: #DCDCDC; margin: 2% 0% 2% 5%; min-width: 200px;}
	.addZzimFolder{border: 3px green dashed; background-color:#FFFFFF;}
	/*폴더배경*/
	.zzimImgDiv{
		width:100%;height:100%;
		overflow:hidden; margin:0 auto;
	}
	.zzimImgDiv>img{opacity: 0.4;}
	.zzimImgDiv>img:hover{transform:scale(1.1); transition:transform 0.5s linear; }
	/*폴더 내 텍스트창*/
	.zzimInfo {
	    position: absolute;
	    z-index: 3;
	    left: 50%; top: 50%;
	    transform: translate(-50%,-50%); /* X 축과 Y 축을 따라 지정된 거리만큼 요소를 이동 */
	    text-align: center;font-size: 1.3em; font-weight: bolder;
	    width: 100%;
	}
	/*추가버튼*/
	.add{
		padding: 0; 
		background-color:#45A663; 
		border-radius: 100%; 
		margin:auto;vertical-align: middle; 	 
    	width: 40px;height: 40px;
	}
	.add>p{line-height: 40px;color:white; font-size: 40px; font-weight: bolder; padding:2px;}
	a:hover{color:#ffffff;}
	.delZzimCkbox{position: absolute;right:5%;top:5%; font-size: 20px; height:10%; width:10%;z-index: 90; display:none;}
	.checkFilter{position:absolute; width:100%;height:100%; z-index: 80; background-color: #ffffff; opacity:0.5; display:none; z-index: 30; }
	#delBoxOpen{font-weight:bolder;color: #45A663;cursor: pointer; }
	#delBox{display:none;}
	#delBox>*{margin-left: 20px;}
</style>
<section id="container" class="container">
	<div class="media">
		<!-- 좌측 메뉴 -->
		<div id="mypage-nav" class=" mr-3">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link" href="${path }/mypage/orderStatus">주문내역</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/qna">1:1문의</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link" href="${path }/mypage/myActivity">나의 활동</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link" href="${path }/mypage/stamp">스탬프</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/zzimList">찜목록</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/updateMember">회원정보수정</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/shipList">배송지관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link" href="${path }/mypage/myPointList">적립금</a>
		    </li>
		  </ul>
		</div>
		
		<!--좌측메뉴선택시 화면 -->
		<div id="mypage-container" class="media-body">
			<div><h3>찜목록</h3></div> 
			<div id="delBoxOpen" class="right">폴더삭제</div>
			<div id="delBox" class="right">
				<span id="allChoice">전체선택</span>
				<span id="remove">선택삭제</span>
				<span id="cancel">취소</span>
			</div>
			<form name="zzimDelFrm">
			<div id="zzimListDiv">
				<!-- 폴더추가상자 -->
				<div class="zzimFolder addZzimFolder" data-toggle="modal" data-target="#zzimFolderModal">
					<div class="zzimInfo">
						<p>폴더추가</p>
						<div class="add"><p>+</p></div>
					 </div>			
				</div>
				
				<c:forEach items="${zzimList}" var="zzim">
					<!--각 찜 폴더 -->
					<div class="zzimFolder">
						<div class="checkFilter"></div>
						<input type="checkbox" class="delZzimCkbox" name="delZzimNo" value="${zzim.zzimNo }">
						<a href="${path }/zzim/selectZzimContent?zzimNo=${zzim.zzimNo }&zzimName=${zzim.zzimName}">
							<div class="zzimImgDiv">
 								<c:if test="${zzim.zzimFolderImg != null}">
								<img src="${path }/resources/upload/product/${zzim.zzimFolderImg };" width="100%">
								</c:if>
								<div class="zzimInfo">
									<p><c:out value="${zzim.zzimName }"/></p>
									<p><i class="fas fa-heart"></i> <c:out value="${zzim.zzimContentCount }"/></p>
								</div>
							</div>		
						</a>
					</div>
				</c:forEach>
				
			</div>
		
		</form>
		</div>
		
		  <!-- The Modal -->
		  <div class="modal fade" id="zzimFolderModal">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title">폴더 만들기</h4>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body" >
	    	   		<form name="zzimFolderFrm">
	    	   		<div style="display:flex;">
			         		<input type="hidden" name="memNo" value="${loginMember.memNo }">
			         		<input type="text" class="form-control" name="zzimName" size="10" placeholder="폴더이름을 선택해주세요. (10자 이내 한글 ,영어,숫자만 가능)" required>
			         		&nbsp;&nbsp;
			         		<input type="submit" class="btn btn-success" id="addFolderBtn" value="만들기" onclick="return fn_addFoler();">
			        </div>
			        </form>
		        </div>
		       
		        
		      </div>
		    </div>
		  </div>
		  
	</div>
</section>
<script>
	var height=$(".zzimFolder").width();
	$(".zzimFolder").css("height",height);
	$( window ).resize( function() {
		var height=$(".zzimFolder").width();
		$(".zzimFolder").css("height",height);
    });


	function fn_addFoler(){
		
		var zzimName=$("input[name=zzimName]").val();
		var nameCheck = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/;
		if(zzimName.length<1 || zzimName.length>10){
			swal("폴더명은 한글자 이상 10이내만 가능합니다.");
			return false;
		}
		
		if(!nameCheck.test(zzimName)){
			swal("한글,숫자,영문만 폴더명으로 가능합니다.");
			return false;
		}
		
		$.ajax({
			url:"${path }/zzim/insertZzim",
			data:{memNo:"${loginMember.memNo}",zzimName:zzimName},
			type:"get",
			dataType:"html",
			success:data=>{
				//새로운 찜폴더 폴더리스트 맨앞에 추가하기
				$(".zzimFolder").first().prev().html(data);
			}
		});
		
	}
	
$(function(){	
	//모달창에 포커싱주기
	$("#zzimFolderModal").on("shown.bs.modal", function () { $("input[name=zzimName]").focus(); });
	
	//폴더삭제 선택시.
	$("#delBoxOpen").on("click",e=>{
		$(e.target).hide();
		//폴더삭제 메뉴 나나타기
		$("#delBox").css("display","block");
		//삭제용체크박스
		$(".delZzimCkbox").css("display","block");
		
		$(".zzimImgDiv *,.zzimImgDiv").click(e=>{
			let del=$("#delBox").css("display");
			if(del=="block"){
				$(e.target).parents(".zzimFolder").find("a").attr("onclick","return false");
				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","block");
				$(e.target).parents(".zzimFolder").find(".delZzimCkbox").prop("checked",true);
			}else{
				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","none");
			}
   	   	});
		
		$(".checkFilter").click(e=>{
   	   		$(e.target).next().prop("checked",false);
   	   		$(e.target).css("display","none");
   	   	}); 
		
		
		$("#cancel").click(e=>{
			$(e.target).parents("#delBox").css("display","none");
			$(".checkFilter").css("display","none");
	   		$("a").attr("onclick","return true");
			$(".delZzimCkbox").prop("checked",false);
	   		$(".delZzimCkbox").css("display","none");
			$("#delBoxOpen").css("display","block");
		});

	});
	
   	$(".delZzimCkbox").click(e=>{
		let tf=$(e.target).prop("checked");
		 if(tf){
			$(e.target).prev().show();
		}else{
			$(e.target).prev().hide();
		}  
	});
   	//전체선택.해제
   	$("#allChoice").click(e=>{
   		let text=$("#allChoice").text();
   		if(text=="전체선택"){
   			$(".delZzimCkbox").prop("checked",true);
   	   		$(".checkFilter").css("display","block");
   	   		$("#allChoice").text("전체선택해제");
   		}else{
   			$(".delZzimCkbox").prop("checked",false);
   	   		$(".checkFilter").css("display","none");
   	   		$("#allChoice").text("전체선택");
   		}
   	});
	
   	//선택한 폴더 삭제
   	$("#remove").click(e=>{
   		var zzimNoList = [];
	 	$("input[name=delZzimNo]:checked").each(function(i){  
	 		zzimNoList.push($(this).val());
	 	});
	 	if(zzimNoList.length == 0){
   			swal("삭제할 폴더를 선택해주세요");
   			return;
   		}
	 	
		swal({
			  title: "선택한 폴더를 삭제하시겠습니까?",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
		})
		.then((willDelete) => {
		  if (willDelete) {
			
			let frm=document.forms.zzimDelFrm;
		   	frm.action="${path}/zzim/deleteZzim";
		   	frm.method="post";
		   	frm.submit();	
		   
		  } else {return;}
		});
		
   	});
})

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
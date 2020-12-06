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
	
	/*찜폴더 타이틀*/
	#zzimTitle{text-align:center; margin-bottom: 30px; font-size: 30px;}
	#zzimTitle>*{margin: 3px; text-decoration: none;}
	#zzimTitle>span{cursor:default;}
	/*찜폴더리스트*/
	#zzimListDiv{display: flex; width:100%; box-sizing:border-box; flex-wrap: wrap;}
	#zzimListDiv>*{box-sizing:border-box;}
	/*찜상품폴더*/
	.zzimFolder{ position: relative; width:27%; margin: 2% 0% 2% 5%; min-width: 200px;}
	/*찜상품이미지*/
	.zzimImgDiv{width:100%;height:100%;overflow:hidden; margin:0 auto}
	.zzimImgDiv>img:hover{transform:scale(1.1);transition:transform 0.5s linear; }
	/*상품이름*/
	.nameP{position:absolute; left:5; bottom:5; margin:0; color:white; width:100%; }
	
	.pdtNoCkBox{position:absolute; top:10px;left: 10px; width: 10%; height:10%; z-index: 90; display: none;}
	.checkFilter{position:absolute; width:100%;height:100%; z-index: 80; background-color: #ffffff; opacity:0.5; display:none; }
	#edit>span{font-weight:bolder;color: #45A663;cursor: pointer;}
	#editBox{display:none; }
	#editBox>*{margin-left: 30px; color: #45A663; font-weight:bolder; cursor: pointer;}
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
			<div id="zzimTitle">
				<a href="${path }/mypage/zzimList"><span>찜목록</span></a>
				<span><i class="fas fa-angle-right"></i></span>
				<span><c:out value="${zzimFolderName }"/></span>
			</div>
			<div class="right" id="edit"><span><i class="fas fa-tools"></i> 편집</span></div>
			<div id="editBox" class="right">
				<span id="folderNameUpdate" data-target="#updateZzimModal" data-toggle="modal" >폴더이름변경</span>
				<span id="folderRemove" onclick="fn_deleteFolder();">폴더삭제</span>
				<span id="deleteZc">상품삭제</span>
				<span id="edit-cancle" style="color:gray;">취소</span>
			</div>
			<hr>
			
			<form name="zcDelFrm">
			<input type="hidden" value="${zzimFolderName }" name="zzimName"/>
			<input type="hidden" value="${zzimNo }" name="zzimNo"/>
			<!-- 찜 목록 전체 틀 -->
			<div id="zzimListDiv">
				<c:forEach items="${zcList}" var="zc">
					<!--각각의 찜 폴더 -->
					<div class="zzimFolder">
						<div class="checkFilter"></div>
						<input type="checkbox" class="pdtNoCkBox" name="pdtNoCkBox" value="${zc.pdtNo }">
						<a href="#">
							<div class="zzimImgDiv">
								<img src="${path }/resources/upload/product/${zc.zzimPdtImage };" alt="${zc.zzimPdtName }" width="100%">
							</div>	
							<p class="nameP"><c:out value="${zc.zzimPdtName }"/></p>
						</a>
					</div>
				</c:forEach>
			</div>
			</form>
			
		</div>
		
		
		 <!-- The Modal -->
		  <div class="modal fade" id="updateZzimModal">
		    <div class="modal-dialog modal-dialog-centered">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title" style="text-align: center;">폴더 이름 변경</h4>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body" >
	    	   		<form name="updateZzimFrm">
		    	   		<div style="display:flex;">
			         		<input type="hidden" name="zzimNo" value="${zzimNo}">
			         		<input type="text" class="form-control" name="zzimName" placeholder="${zzimFolderName }" required>
			         		&nbsp;&nbsp;
			         		<input type="submit" class="btn btn-success" id="updateZzimNameBtn" value="확인" onclick="return fn_updateZzimName();">
				        </div>
			        </form>
		        </div>
		       
		        
		      </div>
		    </div>
		  </div>
		
	</div>
</section>
<script>
	
//폴더이름 유효성검사
function fn_updateZzimName(){
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
		url:"${path}/zzim/updateZzimName",
		data:{zzimName:zzimName, zzimNo:"${zzimNo}"},
		success:data=>{
			if(data === true){	
				alert("폴더이름이 변경되었습니다.");
				$("#zzimTitle>span:nth-of-type(2)").html("");
				$("#zzimTitle>span:nth-of-type(2)").text(zzimName);
			}else{
				alert("폴더이름변경실패");
			}
		},error:function(request,status,error){
			alert("폴더이름변경실패");
		}
	});
}
//폴더삭제
function fn_deleteFolder(){
  swal({
	  title: "폴더를 삭제하시겠습니까?",
	  icon: "warning",
	  buttons: true,
	  dangerMode: true,
  }).then((willDelete)=>{
	  if(willDelete){
		  location.replace('${path}/zzim/deleteZzimOne?zzimNo=${zzimNo }');
	  }else{return;}
  });
	
}

$(function(){
	//창크기 변할떄마다 정사각형으로 폴더 만들기
	var height=$(".zzimFolder").width();
	$(".zzimFolder").css("height",height);
	$( window ).resize( function() {
		var height=$(".zzimFolder").width();
		$(".zzimFolder").css("height",height);
	});
	//제품이름 마우스오버시에만 나오게 하기
	$(".nameP").hide();
   	$(".zzimImgDiv").on({
       	"mouseenter":e=>{
    	   $(e.target).parent().next().show();
       	},"mouseleave":e=>{
       		$(e.target).parent().next().hide();
       	}
	});
   
   	//편집선택시 
   	$("#edit>span").click(e=>{
   		$("#edit").css("display","none");
   		$("#editBox").css("display","block");
   		$(".pdtNoCkBox").css("display","block");
   		
   		$(".zzimImgDiv>img,.zzimImgDiv").click(e=>{
   			let editBox=$("#editBox").css("display");
   			if(editBox=="block"){
	   			//편집모드일때
   				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","block");
				$(e.target).parents(".zzimFolder").find("a").attr("onclick","return false");
   	   	   		$(e.target).parents(".zzimFolder").find(".pdtNoCkBox").prop("checked",true);
   			}else{ 
   				//편집모드가 꺼져있을때
   				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","none");
   	   	   		$(e.target).parents(".zzimFolder").find(".pdtNoCkBox").prop("checked",false);
   			}
  
   	   		
   	   	})
   	   	$(".checkFilter").click(e=>{
   	   		$(e.target).next().prop("checked",false);
   	   		$(e.target).css("display","none");
   	   	})
   		
   	});
   	
   //취소선택시 가존에 편집화면에서 나오는 것 다 지우기, 가리기
   	$("#edit-cancle").click(e=>{
   		$("#editBox").css("display","none");
   		$(".checkFilter").css("display","none");
   		$(".pdtNoCkBox").prop("checked",false);
   		$(".pdtNoCkBox").css("display","none");
   		$("#edit").css("display","block");
   		$("a").attr("onclick","return true");
   	});
   	
   //체크박스를 선택했을때 필터박스 나타나게하기
   $(".pdtNoCkBox").click(e=>{
	   let tf=$(e.target).prop("checked");
	   if(tf){
		   $(e.target).prev().css("display","block");
	   }else{
		   $(e.target).prev().css("display","none");
	   }
	   
   });
   
   $("#deleteZc").click(e=>{
	  var pdtNoList=[];
	  $("input[name=pdtNoCkBox]:checked").each(function(i,v){
		 pdtNoList.push($(this).val()); 
	  });
	  if(pdtNoList.length==0){
		  swal("삭제할 상품을 선택해주세요.");
		  return;
	  }
	  swal({
		  title: "선택한 상품을 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: true,
		  dangerMode: true,
	  })
	  .then((willDelete)=>{
		  if(willDelete){
			  let frm=document.forms.zcDelFrm;
			  frm.action="${path}/zzim/deleteZzimContent";
			  frm.method="post";
			  frm.submit();
		  }else{return;}
	  });
	   
   });
   

})
	
  
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
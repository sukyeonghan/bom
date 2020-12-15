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
	#flexDiv{display:flex; padding: 0px 10% 0px 10%;}
	#mypage-container{min-width:800px; width:100%; padding-right:100px;}
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
	.nameP{position:absolute; left:5px; bottom:5px; margin:0; color:white; width:100%; z-index:100; font-weight:bolder;}
	/*체크박스*/
	.zzimContentNoCkBox{position:absolute; top:10px;left: 10px; width: 10%; height:10%; z-index: 90; display: none;}
	/*체크박스 선택시 필터링박스*/
	.checkFilter{position:absolute; width:100%;height:100%; z-index: 80; background-color: #ffffff; opacity:0.5; display:none; }
	/*편집관련*/
	#edit>span{font-weight:bolder;color: #45A663;cursor: pointer;}
	#editBox{display:none; }
	#editBox>*{margin-left: 30px;font-weight:bolder; cursor: pointer;}
	#folderNameUpdate,#folderMove,#allChoice{color:#45A663;}
	#allChoiceX,#deleteZc,#folderRemove,#edit-cancle{color:#7E7E7E;}
	#folderRemove{color:red;}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container"  >
			<div id="zzimTitle">
				<a href="${path }/mypage/zzimList"><span>찜목록</span></a>
				<span><i class="fas fa-angle-right"></i></span>
				<span><c:out value="${zzimName }"/></span>
			</div>
			<div style="height:30px;"><span id="ckCount" style="display:none;"></span></div>
			<div class="right" id="edit"><span><i class="fas fa-tools"></i> 편집</span></div>
			<div id="editBox" class="right" style="display:none;">
				<span id="folderNameUpdate" data-target="#updateZzimModal" data-toggle="modal" >폴더이름변경</span>
				<span id="folderMove">상품폴더이동</span>
				<span id="allChoice">상품전체선택</span>
				<span id="allChoiceX" style="display:none;">전체선택해제</span>
				<span id="deleteZc">선택상품삭제</span>
				<span id="folderRemove" onclick="fn_deleteFolder();">해당폴더삭제</span>
				<span id="edit-cancle">취소</span>
			</div>
			<hr>
			
			<form name="zcDelFrm">
			<input type="hidden" value="${zzimName }" name="zzimName"/>
			<input type="hidden" value="${zzimNo }" name="zzimNo"/>
			<!-- 찜 목록 전체 틀 -->
			<div id="zzimListDiv">
				<c:forEach items="${zcList}" var="zc">
					<!--각각의 찜 폴더 -->
					<div class="zzimFolder">
						<div class="checkFilter"></div>
						<input type="checkbox" class="zzimContentNoCkBox" name="zzimContentNoCkBox" value="${zc.zzimContentNo }">
						<a href="${path }/product/selectProductOne?pdtNo=${zc.pdtNo}">
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
		    	   	<div style="display:flex;">
		         		<input type="hidden" name="zzimNo" value="${zzimNo}">
		         		<input type="text" class="form-control" name="updateZzimName" id="updateZzimName"  placeholder="${zzimName }" required>
		         		&nbsp;&nbsp;
		         		<input type="button" class="btn btn-success" id="updateZzimNameBtn" value="확인" onclick="fn_updateZzimName();">
				    </div>
			    </div>
		       
		        
		      </div>
		    </div>
		  </div>
		
		
		<!-- The Modal -->
		  <div class="modal fade" id="zzimModal">
		    <div class="modal-dialog modal-dialog-scrollable">
		      <div class="modal-content">
		      
		        <!-- Modal Header -->
		        <div class="modal-header">
		          <h4 class="modal-title" style="text-align: center;">이동할 폴더를 선택해주세요.</h4>
		          <button type="button" class="close" data-dismiss="modal">X</button>
		        </div>
		        
		        <!-- Modal body -->
		        <div class="modal-body" id="zzimListBody">
		    	   		
		        </div>
		       
		        
		      </div>
		    </div>
		  </div>
	</div>
</section>
<script>
//모달열릴때 포커싱 주기
$("#updateZzimModal").on("shown.bs.modal", function () { $("input[name=updateZzimName]").focus(); });

//인풋에서 엔터시 폴더생성함수 실행
$("#updateZzimName").keyup(function(e){
	if(e.keyCode == 13){fn_updateZzimName(); }
});	
//폴더이름 유효성검사
function fn_updateZzimName(){
   	var zzimName=$("input[name=updateZzimName]").val();
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
				$("#updateZzimModal").modal("hide");//모달닫기
				$("#zzimTitle>span:nth-of-type(2)").html("");
				$("#zzimTitle>span:nth-of-type(2)").text(zzimName);
				$("input[name=updateZzimName]").val("");//모달에 인풋 창 비우기
				$("input[name=updateZzimName]").attr("placeholder",zzimName);
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
	  buttons: ["아니오", "네"],
	  dangerMode: true,
  }).then((willDelete)=>{
	  if(willDelete){
		  location.replace('${path}/zzim/deleteZzimOne?zzimNo=${zzimNo }');
	  }else{return;}
  });
	
}

//체크박스 체크수에 따라 전체선택,해제 표시 
function cssAndCount(){
	let count=$("input:checkbox[name=zzimContentNoCkBox]:checked").length;
	let all=$("input:checkbox[name=zzimContentNoCkBox]").length;
	if(count==0){	
		$("#ckCount").hide();
		$("#deleteZc").css("color","#7E7E7E");
	}else if(count>0){
		$("#deleteZc").css("color","red");
		$("#ckCount").show();
		$("#ckCount").html("(선택 갯수: "+count+"개)");

	}else{
		$("#deleteZc").css("color","#7E7E7E");
		$("#ckCount").hide();

	}
	if(all==count){
		$("#allChoice").hide();
		$("#allChoiceX").show();
	}else{
		$("#allChoice").show();
		$("#allChoiceX").hide();
		
	}
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
   	$(".zzimImgDiv>img").on({
       	"mouseenter":e=>{
    	   $(e.target).parent().next().css("display","block");
       	},"mouseleave":e=>{
       		$(e.target).parent().next().css("display","none");
       	}
	});
   
   	//편집선택시 
   	$("#edit>span").click(e=>{
   		$("#edit").css("display","none");
   		$("#editBox").css("display","block");
   		$(".zzimContentNoCkBox").css("display","block");
   		
   		 $(".zzimImgDiv>img,.zzimImgDiv").click(e=>{
   			 let editBox=$("#editBox").css("display");
   			if(editBox=="block"){
	   			//편집모드일때
   				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","block");
				$(e.target).parents(".zzimFolder").find("a").attr("onclick","return false");
   	   	   		$(e.target).parents(".zzimFolder").find(".zzimContentNoCkBox").prop("checked",true);
   			}else{ 
   				//편집모드가 꺼져있을때
   				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","none");
   	   	   		$(e.target).parents(".zzimFolder").find(".zzimContentNoCkBox").prop("checked",false);
   			} 
   			cssAndCount();
   		
   	   	});
   	   	$(".checkFilter").click(e=>{
   	   		$(e.target).next().prop("checked",false);
   	   		$(e.target).css("display","none"); 
   	   		cssAndCount();
   	   	}); 
   		
   	   		
   		
   	});
  
   //취소선택시 가존에 편집화면에서 나오는 것 다 지우기, 가리기
   	$("#edit-cancle").click(e=>{
   		$("#editBox").css("display","none");
   		$(".checkFilter").css("display","none");
   		$(".zzimContentNoCkBox").prop("checked",false);
   		$(".zzimContentNoCkBox").css("display","none");
   		$("#edit").css("display","block");
   		$("a").attr("onclick","return true");
   		$("#ckCount").html("");
 
   	});
   	
   //체크박스 체크여부에 따라 필터박스 나타나게하기
   $(".zzimContentNoCkBox").click(e=>{
	   let tf=$(e.target).prop("checked");
	   if(tf){	  
		   $(e.target).prev().css("display","block");
	   }else{
		   $(e.target).prev().css("display","none");
	   }
	   cssAndCount();
	   
   });
   //상품삭제 선택시
   $("#deleteZc").click(e=>{
	  var zzimContentNoList=[];
	  $("input[name=zzimContentNoCkBox]:checked").each(function(i,v){
		 zzimContentNoList.push($(this).val()); 
	  });
	  if(zzimContentNoList.length==0){
		  swal("삭제할 상품을 선택해주세요.");
		  return;
	  };
	  
	  swal({
		  title: "선택한 상품을 삭제하시겠습니까?",
		  icon: "warning",
		  buttons: ["아니오", "네"],
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
   //폴더이동 선택시
   $("#folderMove").click(e=>{
	  //체크한 상품여부 확인
	  var zzimContentNoList=[];
	  $("input[name=zzimContentNoCkBox]:checked").each(function(i,v){
		 zzimContentNoList.push($(this).val()); 
	  });
	  if(zzimContentNoList.length==0){
		  swal("이동할 상품을 선택해주세요.");
		  return;
	  }
	  //모달창에 현재 폴더리스트 정보 ajax로 전달
	  $.ajax({
          type : 'POST',
          url : "${path}/zzim/zzimListModal",
          data: {zzimContentNoList:zzimContentNoList},
          dataType:"html",
          success : function(data) {
			$("#zzimListBody").html("");
			$("#zzimListBody").html(data);
          },error:function(){
        	  alert("실패");
          }
  	 });
	  $("#zzimModal").modal();//모달열기

   });
   
   
   //전체선택선택시
	$("#allChoice").click(e=>{
   	   	$(".zzimContentNoCkBox").prop("checked",true);
   		$(".checkFilter").css("display","block");
   		cssAndCount();
   	});
	$("#allChoiceX").click(e=>{
	 	$(".zzimContentNoCkBox").prop("checked",false);
  		$(".checkFilter").css("display","none");
  		cssAndCount();
	});
	
	
})
	

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
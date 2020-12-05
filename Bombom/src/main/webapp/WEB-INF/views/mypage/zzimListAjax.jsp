<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>


	<!-- 폴더추가상자 -->
	<div class="zzimFolder addZzimFolder" data-toggle="modal" data-target="#zzimFolderModal">
		<div class="zzimInfo">
			<p>폴더추가</p>
			<div class="add"><p>+</p></div>
		 </div>			
	</div>

	<c:forEach items="${zzimList}" var="zzim">
		<!--각 찜 폴더 -->
		<div class="zzimFolder" id="Folder-${zzim.zzimNo }">
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
			  console.log(zzimNoList);
		   		$.ajax({
		   			
		   			url:"${path}/zzim/deleteZzim",
		   			data:{zzimNoList:zzimNoList},
		   			type:"get",
		   			dataType:"html",
		   			success:data=>{
		   				//alert(data);
			   			//swal("삭제성공", { icon: "success"});
			   			
			   			zzimNoList.forEach(funcion(val,index){
			   				alert(val);
			   				$("div").prop("id","Folder-"+val).remove();
			   			});
			   			
		   				
			   			
		   				//$("#zzimListDiv").html("");
		   				//$("#zzimListDiv").html(data);
		   			}
		   		});
		   
		  } else {return;}
		});
		
   	});
})

</script>
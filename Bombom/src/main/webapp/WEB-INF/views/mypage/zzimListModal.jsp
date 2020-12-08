<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	/*폴더 리스트 전체 틀*/
	ul#zzimListUl{list-style-type:none;padding:0;}
	ul#zzimListUl>*{cursor:pointer;}
	/*새 폴더 추가*/
	li#addFolderLi,li.zzimFolderLi{padding: 10px; border-bottom: 2px lightgray solid; width:100%;}
	div#addFolderDiv,div.zzimFolderDiv{width:100%; height: 50px; display:flex;}
	div#inputbox{width:100%; height: 50px; display:none; }
	#addBtn,#cancelBtn{height:40px;}
	/*각각의 폴더*/
	.folderInfo{height: 50px; margin-left:20px;}
	.folderInfo>p{line-height: 50px; font-size: 20px;}
	.zzimFolderImgDiv{width:50px;height: 50px;}
	.binFolder{width:50px;height: 50px; background-color:lightgray;border-radius:20%;}
	/*실제 선택 값 받을 라디오 버튼*/
	.updateZzimNo{display:none;}
</style>
<!-- 모달창에 들어갈 폴더리스트 전체 -->
<ul id="zzimListUl">
	<li id="addFolderLi">
		<!-- 새 폴더 생성 -->
		<div id="addFolderDiv">
			<div style="width:50px;height: 50px; background-color:#45A663;border-radius:20%;">
				<p style="line-height:50px; font-size: 30px; text-align: center; color:#ffffff;"><i class="fas fa-plus"></i><P>
    	   	</div>
    	   	<div class="folderInfo">
    	   		<p>폴더생성</p>
    	   	</div>
		</div>
		<!-- 새폴더 생성 클릭시 나올 input묶음 -->
		<div id="inputbox">
			<div style="display:flex"> 
				<input type="text" class="form-control" id="addZzimName" name="addZzimName" >
				<input type="button" class="btn btn-success" id="addBtn" value="확인" onclick="return fn_addFolder();">
				<input type="button" class="btn btn-danger" id="cancelBtn" value="취소">
			</div>
		</div>	
   	</li>
   	
   	<!-- 찜 콘텐츠가 이동할 폴더 정보 전달 form -->
   	<form name="updateZzimNoFrm" action="${path }/zzim/updateZzimNo">   		
	<c:forEach items="${zzimList }" var="zzim">
		<li class="zzimFolderLi">
			<!-- 실제로 선택받는 radio버튼 : 가려두기  -->
			<input type="radio" name="updateZzimNo" class="updateZzimNo" value="${zzim.zzimNo }"> 
			<!-- 화면단에 실제로 보이는 각 폴더 정보 -->
			<div class="zzimFolderDiv">
				<!--좌측 폴더이미지 -->	
				<div class="zzimFolderImgDiv">
    	   			<c:if test="${zzim.zzimFolderImg != null}">
						<img src="${path }/resources/upload/product/${zzim.zzimFolderImg };"  style="width:50px; height:50px;border-radius:20%;">
					</c:if>
					<c:if test="${zzim.zzimFolderImg == null}">
						<div class="binFolder"></div>
					</c:if>
   	   			</div>
   	   			<!-- 우측 폴더이름 -->
    	   		<div class="folderInfo">
    	   			<p><c:out value="${zzim.zzimName }"/></p>
    	   		</div>
			</div>
		</li>
	</c:forEach>
	<!-- 모달 열 때 받아온 선택한 찜 콘텐츠 고유번호 -->
	<c:forEach items="${zcNoList }" var="zcNo">
   	   	<input type="hidden" name="zcNo" value="${zcNo }">
   	</c:forEach>
	</form>
</ul>
<script>

//폴더생성 할시 실행할 함수
function fn_addFolder(){
	var zzimName=$("input[name=addZzimName]").val();
	var nameCheck = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/;
	if(zzimName.length<1 || zzimName.length>10){
		swal("폴더명은 한글자 이상 10이내만 가능합니다.");
		return false;
	}
	if(!nameCheck.test(zzimName)){
		swal("한글,숫자,영문만 폴더명으로 가능합니다.");
		return false;
	}
	//폴더 생성 후 해당 폴더 정보 받아 구성하기
	$.ajax({
		url:"${path}/zzim/insertZzim2",
		data:{zzimName:zzimName,memNo:"${loginMember.memNo}"},
		success:data=>{
			let li=$('<li>').attr("class","zzimFolderLi");
			let radio=$('<input type="radio" name="updateZzimNo" class="updateZzimNo" value="'+data.zzimNo+'"> ');
			let folderDiv=$('<div class="zzimFolderDiv">');
			let imgDiv=$('<div class="zzimFolderImgDiv">').append('<div class="binFolder">');
			let folderInfo=$('<div class="folderInfo">').append("<p>"+data.zzimName+"</p>");
			folderDiv.append(imgDiv);
			folderDiv.append(folderInfo);
			li.append(radio);
			li.append(folderDiv);

			$(".zzimFolderLi").first().before(li);
		},error:function(request,status,error){
			alert("폴더생성실패");
		}
	});
}

$(function(){
	
	//엔터시 폴더생성함수 실행
	$("#addZzimName").keyup(function(e){
		if(e.keyCode == 13){fn_addFolder(); }
	});
	//폴더추가 선택시 폴더이름 입력창 노출하기
	$("#addFolderDiv>*,#addFolderDiv").click(e=>{
		$("#addFolderDiv").hide();
		$("#inputbox").show();
		$("#cancelBtn").click(e=>{
			$("#addFolderDiv").show();
			$("#inputbox").hide();
		});
	});
	//리스트 마우스 오버효과주기
	$(document).on("mouseenter", ".zzimFolderDiv,.zzimFolderDiv>*", function(e){
		$(e.target).parents(".zzimFolderLi").css("background-color","#EAEAEA");
	});
	$(document).on("mouseleave", ".zzimFolderDiv,.zzimFolderDiv>*", function(e){
		$(e.target).parents(".zzimFolderLi").css("background-color","#ffffff");	
	});

	//각 리스트 폴더 클릭시 라디오 버튼 선택
	 $(document).on('click', ".zzimFolderDiv,.zzimFolderDiv>*", function(e){
		 let name=$(e.target).parents(".zzimFolderLi").find(".folderInfo").children().text();
		 	$(e.target).parents(".zzimFolderLi").children(".updateZzimNo").attr("checked",true);
		 	swal({
		 	     text: "선택하신 '"+name+"' 폴더로 이동하시겠습니까?",
		 	     icon: "info",
		 	     buttons: ["아니오", "네"],
		 	}).then((yes) => {
		 	     if (yes) {
		 	    	let frm=document.forms.updateZzimNoFrm;
		 			frm.method="post";
		 			frm.submit();
		 	     }
		 	});
	 });

});



</script>
	        
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
	.right{text-align: right;}/*오른쪽 정렬*/
	
	/*찜폴더리스트*/
	#zzimListDiv{display: flex; width:100%; box-sizing:border-box; flex-wrap: wrap;}
	#zzimListDiv>*{box-sizing:border-box; cursor: pointer;}
	#zzimListDiv>div:hover{ background-color: #C0C0C0;}
	/*찜폴더*/
	.zzimFolder{position: relative; width:28%; background-color: #DCDCDC; margin: 2% 0% 2% 3%; min-width: 200px;}
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
	/*폴더추가버튼*/
	.add{
		padding: 0; 
		background-color:#45A663; 
		border-radius: 100%; 
		margin:auto;vertical-align: middle; 	 
    	width: 40px;height: 40px;
	}
	.add>p{line-height: 40px;color:white; font-size: 40px; font-weight: bolder; padding:2px;}
	/*각 폴더 이름 효과*/
	a:hover{color:#ffffff;}
	/*지울 폴더 선택*/
	.delZzimCkbox{position: absolute;right:5%;top:5%; font-size: 20px; height:10%; width:10%;z-index: 90;  display:none;}
	/*체크박스 선택시 가리기 효과*/
	.checkFilter{position:absolute; width:100%;height:100%; z-index: 80; background-color: #ffffff; opacity:0.5; display:none; z-index: 30; }
	/*편집버튼*/
	#delBoxOpen{font-weight:bolder;color: #45A663;cursor: pointer; }
	/*편집시 나올 메뉴들*/
	#delBox{display:none;}
	#delBox>*{margin-left: 20px;cursor:pointer; font-weight:bolder; color:#7E7E7E;}
	#cancel{color:black;}
	#addFilter{position:absolute; width:100%;height:100%; z-index: 1000; background-color: #6c757d; opacity:0.5; display:none; }
	#openModal{position:absolute; width:100%;height:100%;}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container"  >
			<div style="display:flex; justify-content: space-between; margin:20px;">
				<div style="display:flex"><h3>찜목록</h3>&nbsp;&nbsp; <span id="ckCount"></span> </div>
				<!-- 편집메뉴모음 -->
				<div id="delBoxOpen" class="right"><span><i class="far fa-trash-alt"></i> 폴더삭제</span></div>
					<div id="delBox" class="right">
					<span id="allChoice">전체선택</span>
					<span id="remove">선택삭제</span>
					<span id="cancel">취소</span>
				</div>
			</div>
			
			<!-- 삭제할 폴더 선택폼 -->
			<form name="zzimDelFrm">
			<!-- 전체 폴더 리스트 -->
			<div id="zzimListDiv">
				<!-- 폴더추가상자 -->
				<div class="zzimFolder addZzimFolder" >
					<div id="openModal" data-toggle="modal" data-target="#zzimFolderModal" >
					<div class="zzimInfo">
						<p>폴더추가</p>
						<div class="add"><p>+</p></div>
					 </div>
					 </div>			
					<div id="addFilter"></div>
				</div>
				
				<c:forEach items="${zzimList}" var="zzim">
					<!--각 찜 폴더 -->
					<div class="zzimFolder folder">
						<div class="checkFilter"></div>
						<input type="checkbox" class="delZzimCkbox" name="delZzimNo" value="${zzim.zzimNo }">
						<a href="${path }/zzim/selectZzimContent?zzimNo=${zzim.zzimNo }">
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
		
		  <!--폴더생성  Modal -->
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
	    	   		<div style="display:flex;">
			         		<input type="hidden" name="memNo" value="${loginMember.memNo }">
			         		<input type="text" class="form-control" name="zzimName" id="zzimName" size="10" placeholder="폴더이름을 지정해주세요. (10자 이내 한글 ,영어,숫자만 가능)" required>
			         		&nbsp;&nbsp;
			         		<input type="button" class="btn btn-success" id="addFolderBtn" value="만들기" onclick="return fn_addFolder();">
			        </div>
		        </div>
		        
		      </div>
		    </div>
		  </div>
		  
	</div>
</section>
<script>
	
	//비율대로 줄어드는 폭에 높이 맞추기. 정사각형
	var height=$(".zzimFolder").width();
	$(".zzimFolder").css("height",height);
	$( window ).resize( function() {
		var height=$(".zzimFolder").width();
		$(".zzimFolder").css("height",height);
    });
	
	//인풋에서 엔터시 폴더생성함수 실행
	$("#zzimName").keyup(function(e){
		if(e.keyCode == 13){fn_addFolder(); }
	});

	//폴더 추가 함수
	function fn_addFolder(){
		//폴더이름 유효성검사
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
				//새로운 찜폴더,폴더 추가 칸 다음 추가
				$(".addZzimFolder").after(data); 
				$("#zzimFolderModal").modal("hide");//모달닫기
				$("input[name=zzimName]").val("");//모달에 인풋 창 비우기
			},error:function(error){
				alert("폴더가 생성되지 못했습니다. 반복될경우 관리자에게 문의해주세요.");
			}
			
		});
		
	}
	//체크박스 체크수에 따라 전체선택,해제 표시 / 선택갯수 표시, 삭제텍스트 css주기 함수
	function cssAndCount(){
		let count=$("input:checkbox[name=delZzimNo]:checked").length;
		let all=$("input:checkbox[name=delZzimNo]").length;
		if(count>0){
			$("#remove").css("color","red");
			$("#ckCount").show();
			$("#ckCount").html("(선택 갯수: "+count+"개)");

		}else{
			$("#remove").css("color","#7E7E7E");
			$("#ckCount").hide();

		}
		if(all==count){
			$("#allChoice").text("전체선택해제");
		}else{
			$("#allChoice").text("전체선택");
			
		}
	}
$(function(){
	//모달창에 포커싱주기
	$("#zzimFolderModal").on("shown.bs.modal", function () { $("input[name=zzimName]").focus(); });
	
	//폴더삭제 선택시.
	$("#delBoxOpen>span").on("click",e=>{
		$(e.target).parent().hide();
		//폴더삭제 메뉴 나나타기
		$("#delBox").css("display","block");
		//삭제용체크박스
		$(".delZzimCkbox").css("display","block");
		$("#addFilter").css("display","block");
		$(".zzimImgDiv *,.zzimImgDiv").on("click",e=>{
			let del=$("#delBox").css("display");
			if(del=="block"){
				$(e.target).parents(".zzimFolder").find("a").attr("onclick","return false");
				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","block");
				$(e.target).parents(".zzimFolder").find(".delZzimCkbox").prop("checked",true);
			}else{
				$(e.target).parents(".zzimFolder").find(".checkFilter").css("display","none");
			}
			cssAndCount();
   	   	});
		//필터 클릭시 체크박스 체크해제, 필터박스 가리기
		$(".checkFilter").click(e=>{
   	   		$(e.target).next().prop("checked",false);
   	   		$(e.target).css("display","none");
   	   		cssAndCount();
   	   	}); 
		
		//편집 상태 취소시 편집시 뜨느 체크박스,필터, a태그 경로 살리기...
		$("#cancel").click(e=>{
			$(e.target).parents("#delBox").css("display","none");
			$(".checkFilter").css("display","none");
	   		$("a").attr("onclick","return true");
			$(".delZzimCkbox").prop("checked",false);
	   		$(".delZzimCkbox").css("display","none");
			$("#delBoxOpen").css("display","block");
			$("#ckCount").hide();
			$("#addFilter").css("display","none");
		});

	});
	//체크박스만 클릭해도  필터박스 해제하기
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
   		cssAndCount();
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
	 	//선택값에 따라 폼 전달여부
		swal({
			  title: "선택한 폴더를 삭제하시겠습니까?",
			  icon: "warning",
			  buttons: ["아니오", "네"],
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
   	
	//체크박스 체인지 시 함수 실행
	$('input[name=delZzimNo]').change(e=>{
		cssAndCount();
	});
 		
   		
		
	   	 

})

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
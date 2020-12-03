<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
  <link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
  />
<style>
	/*좌측메뉴*/
	#mypage-nav{padding-right:100px;}
	#mypage-nav a{color:black;font-weight:bolder;}
	#mypage-nav a:hover{color: #45A663;}

	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	.right{text-align: right;}
	
	/*찜폴더리스트*/
	#zzimListDiv{display: flex; width:100%;/*  border: 1px red solid;  */}
	#zzimListDiv>*{box-sizing:border-box; cursor: pointer;}
	#zzimListDiv>div:hover{ background-color: #EDEDED;}
	/*찜폴더*/
	.zzimFolder{ position: relative; width:27%; background-color: #f5f5f5; margin:3%; }
	.addZzimFolder{border: 3px green dashed; background-color:#FFFFFF;}

	/*폴더 내 텍스트창*/
	.zzimInfo {
	    position: absolute;
	    z-index: 1;
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
			<h3>찜목록</h3> 
			<div id="zzimListDiv" class="row">
				<div class="zzimFolder addZzimFolder" data-toggle="modal" data-target="#zzimFolderModal">
					<div class="zzimInfo">
						<p>폴더추가</p>
						<div class="add"><p>+</p></div>
					 </div>			
				</div>
				
				<c:forEach items="${zzimList}" var="zzim">
					<div class="zzimFolder">
						<a href="${path }/zzim/selectZzimContent?zzimNo=${zzim.zzimNo }">
							<div>
								<div class="zzimInfo">
									<p><c:out value="${zzim.zzimName }"/></p>
									<p><i class="fas fa-heart"></i>폴더내 상품갯수</p>
								</div>
							</div>		
						</a>
					</div>
				</c:forEach>
			
			</div>
		
		
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
			type:"post",
			success:data=>{
				console.log(data);
				$('#zzimFolderModal').modal('hide');
				
				let zzimFolder=$("<div class='zzimFolder'>");
				let a = $("<a>").attr("href","${path }/zzim/selectZzimContent?zzimNo=${zzim.zzimNo }").append($("<div>"));
				let div=$("div class='zzimInfo'");
				div.append($("<p>").html("${zzim.Name}"))
				.append($("<p>").html("<i class='fas fa-heart'></i>폴더내 상품갯수"));
				zzimFolder.append(div);
				$(".zzimFolder").last(zzimFolder);
				
			}
		});
		
	}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
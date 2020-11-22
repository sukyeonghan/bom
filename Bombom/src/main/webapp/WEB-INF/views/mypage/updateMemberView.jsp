<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<style>
   /*좌측메뉴*/
   #mypage-nav{padding-right:100px;}
   #mypage-nav a{color:black;font-weight:bolder;}
   #mypage-nav a:hover{color: #45A663;}
   /*최소 컨텐츠 크기*/
   .media{min-width: 768px;} 
   
	div#update-container{
		width:80%;
		padding:40px;
		margin:auto;
		border:1px #45A663 solid ;
		border-radius: 10px;
		text-align:center;
		
	}
	/*버튼크기고정*/
	.btn-box>.btn{width: 100px;}
    
    .btn-box{margin-top: 50px;}
   	/*프로필*/
    img#profileImg{margin: 50px;}
    /*사용가능 가이드*/
    .guide-ok{color:green; text-align: left; margin:3px;}
    .guide-error{color:red; text-align: left; margin:3px;}
   
    .left{text-align:left};
</style>
<script>
$(function(){
	$("#profileImg").on("click",e=>{
		console.log("이미지눌렸다");
		fn_upload();
	});
	
	$("#upload").on("change",e =>{ 
		
		$("#imgDiv").html("");
		
		let reader=new FileReader();
		reader.onload=e=>{
			let img=$("<img>",{"src":e.target.result,id:"profileImg",width:"150px",height:"150px",onclick:"fn_upload();"});
			img.addClass("rounded-circle");
			$("#imgDiv").append(img); 
		}
		reader.readAsDataURL($(e.target)[0].files[0]);

	}); 
})
	function fn_upload(){
		$("#upload").click();
	}
</script>
<section id="container" class="container">
   <div class="media">
   
      <!-- 좌측 메뉴 -->
      <div id="mypage-nav" class=" mr-3">
        <ul class="nav flex-column">
          <li class="nav-item">
               <a class="nav-link" href="#">주문내역</a>
          </li>
          <li class="nav-item">
               <a class="nav-link" href="#">1:1문의</a>
          </li>
          <li class="nav-item">
               <a class="nav-link" href="#">나의 활동</a>
          </li>
          <li class="nav-item">
               <a class="nav-link" href="${path }/member/stamp">스탬프</a>
          </li>
          <li class="nav-item">
               <a class="nav-link" href="${path }/member/zzimList">찜목록</a>
          </li>
          <li class="nav-item">
               <a class="nav-link" href="${path }/member/updateMember">회원정보수정</a>
          </li>
          <li class="nav-item">
               <a class="nav-link" href="${path }/member/shipList">배송지관리</a>
          </li>
          <li class="nav-item">
               <a class="nav-link" href="${path }/member/pointList">적립금</a>
          </li>
        </ul>
      </div>
      
      <!--좌측메뉴선택시 화면 -->
      <div id="mypage-container" class="media-body">
        
      	<div id="update-container">
        <h3 id="sub-title">회원정보수정</h3> 
        	<form action="${path }/member/updateMember" method="post">
	     		<input type="hidden" name="memNo" class="form-control" value="${loginMember.memNo }">
				<div id="imgDiv">        	
		        	<img src="${path }/resources/images/기본프로필.png" class="rounded-circle" id="profileImg"  alt="기본프로필" width="150" height="150"><br> 
	     		</div>
      			<input type="file" id="upload" name="memPro" accept="image/gif, image/jpeg, image/png" style="display:none;">
	     		<input type="text" name="memEmail" class="form-control" value="${loginMember.memEmail }" readonly>
	     		<br>
	     		<input type="password" name="memPwd" class="form-control" placeholder="비밀번호를 변경하는 경우 입력해주세요">
	     		<input type="password" name="memPWdCk" class="form-control" placeholder="비밀번호 확인">
	     		<p class="guide-ok left">두 비밀번호가 일치합니다.</p>
				<p class="guide-error left">두 비밀번호가 일치하지 않습니다.</p>
				<br>
	     		<p class="left">닉네임:</p>
	    		<input type="text" name="memNick" class="form-control" value="${loginMember.memNick }" placeholder="${loginMember.memNick }">
				<p class="guide-ok left">이 닉네임은 사용이 가능합니다.</p>
				<p class="guide-error left">이 닉네임 사용이 불가능합니다.</p>
				<div class="btn-box">
					<input type="button" class="btn btn-danger" onclick="" value="탈퇴"/>
					<input type="submit" class="btn btn-success" value="수정"/>
				</div> 
     		</form>
      	</div>   
         
      </div>
   </div>
</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
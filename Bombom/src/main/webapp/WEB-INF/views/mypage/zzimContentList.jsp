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
	#zzimTitle{text-align:center; margin-bottom: 50px;}
	#zzimTitle *{display: inline-block; margin: 3px;text-decoration: none; }
	/*찜폴더리스트*/
	#zzimListDiv{display: flex; width:100%;}
	#zzimListDiv>*{box-sizing:border-box;}
	/*찜상품폴더*/
	.zzimFolder{ position: relative; width:27%; margin:3%; }
	/*찜상품이미지*/
	.zzimImgDiv{width:100%;height:100%;overflow:hidden; margin:0 auto}
	.zzimImgDiv>img:hover{transform:scale(1.1);transition:transform 0.5s linear; }
	/*상품이름*/
	.nameP{position:absolute; left:5; bottom:5; margin:0; color:white; width:100%; }
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
			<div id="menu"><i class="fas fa-tools"></i> 폴더설정</div>
			<div id="zzimTitle">
				<a href="${path }/mypage/zzimList"><h3>찜목록</h3></a>
				<h3><i class="fas fa-angle-right"></i></h3>
				<h3><c:out value="${zzimFolderName }"/></h3>
			</div>
			<hr>
			<!-- 찜 목록 전체 틀 -->
			<div id="zzimListDiv" class="row">
				
				<c:forEach items="${zcList}" var="zc">
					<!--각각의 찜 폴더 -->
					<div class="zzimFolder">
						<a href="#">
							<div class="zzimImgDiv">
								<img src="${path }/resources/upload/product/${zc.zzimPdtImage };" width="100%">
							</div>	
							<p class="nameP"><c:out value="${zc.zzimPdtName }"/></p>
						</a>
					</div>
				</c:forEach>
				
			</div>
		</div>
		
		
	</div>
</section>
<script>
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
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
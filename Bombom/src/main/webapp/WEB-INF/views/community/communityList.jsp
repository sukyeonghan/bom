<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath }" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="community" value="커뮤니티 " />
</jsp:include>
<style>
section {
	margin-top: 220px;
}

* {
	box-sizing: border-box;
}

.wrapper {
	border: 2px solid white;
	border-radius: 5px;
	background-color: white;
}

.wrapper>div {
	border: 2px solid white;
	border-radius: 5px;
	background-color: white;
	padding: 1em;
	color: black;
	text-align: center;
}

.wrapper {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	column-gap: 10px;
	row-gap: 1em;
	grid-auto-rows: minmax(400px, auto);
}

.banner {
	width: 100%;
}
.item3  img {
    -webkit-transform:scale(1);
    -moz-transform:scale(1);
    -ms-transform:scale(1); 
    -o-transform:scale(1);  
    transform:scale(1);
    -webkit-transition:.3s;
    -moz-transition:.3s;
    -ms-transition:.3s;
    -o-transition:.3s;
    transition:.3s;
}
.item3:hover img {
    -webkit-transform:scale(1.2);
    -moz-transform:scale(1.2);
    -ms-transform:scale(1.2);   
    -o-transform:scale(1.2);
    transform:scale(1.2);
}
</style>
<!-- 로그인 되어야 커뮤니티 이용 가능  -->
<section class="container">
	<div id="community-banner">
		<img class="banner"
			src="${path }/resources/images/community/communityBanner.png">
	</div>
	<br><br>
	<!-- 로그인 하셔야 글쓰기가 가능합니다, 로그인 하시겠습니까? -->
	<div class="text-right">
		<c:if test="${loginMember!=null }">
			<input type="hidden" name="memNo" value="${loginMember.memNo}">
			<button type="submit" class="btn btn-success"
				 onclick="location.replace('${path }/community/communityForm')">글쓰기</button>
		</c:if>
		<c:if test="${loginMember==null }">
			<button type="button" class="btn btn-success loginCheck" >글쓰기</button>
		</c:if>
	</div>
	
	<!-- 커뮤니티 wrapper , grid 사용 -->
	<br>
	<br>
	<br>
<form>
  <select id="listup" name="listup" >
    <option value="like">좋아요</option>
    <option value="view">조회순</option>
    <option value="update" selected>최신순</option>
  </select>
</form>
	<div id="communityAjax"> </div>
</section>
<script>
	
	// 로그인 체크
	$(function(){ 
		//커뮤니티 정렬
		$.ajax({
		url:"${path }/community/communityList",
		data:{}
		dataType:"json"	
		
		})
		
		$("#listup").onchange(e =>{
			$.ajax
		}
		
		$(".loginCheck").click(function() {
			swal("로그인을 먼저 해주세요");
		});
	});
	
	
	
</script>



<jsp:include page="/WEB-INF/views/common/footer.jsp" />
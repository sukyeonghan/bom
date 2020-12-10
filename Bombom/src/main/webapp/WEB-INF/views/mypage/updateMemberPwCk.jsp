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
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	/*비밀번호확인 박스*/
	#pwCheckDiv{
		width:500px;
		padding:50px;
		margin:auto;
		margin-top:100px;
		border:1px #45A663 solid ;
		border-radius: 10px;}
	/*비밀번호 입력칸*/	
	input#pwCk{
		width: 330px;
		border: none;
		border-bottom: 3px #45A663 solid;}
	/*패스워드 입력시 글자 공란으로 나오는 거 처리*/
	input[type=password] {font-family: "NanumSquare";}
	
</style>
<section id="container" class="container">
	<div class="media">
	
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		
		
		<!--좌측메뉴선택시 화면 -->
		<div id="mypage-container" class="media-body">
			<h3>회원정보 수정</h3> 
			
			<!-- 화면내용입력부분 -->
			<div id="result">
				<div id="pwCheckDiv">
					<h4>비밀번호 확인</h4>
					<br>
					<form action="${path}/member/updateMemberView" method="post">
						<input type="password" id="pwCk" name="memPwd" placeholder="비밀번호를 입력해주세요">&nbsp;&nbsp;
						<input type="hidden" name="memNo" value="${loginMember.memNo }"/>
						<button type="submit" class="btn btn-success" id="pwCkBtn" onclick="return fn_check();">확인</button>
					</form>
				</div>
			</div>
	
		</div>
	</div>
</section>
<script>
	function fn_check(){
	 	if($("input[name=memPwd]").val()==""){
			swal("비밀번호를 입력해주세요.");
			return false;
		}
	}

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
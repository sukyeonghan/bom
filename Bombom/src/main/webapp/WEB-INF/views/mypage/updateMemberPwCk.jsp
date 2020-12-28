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
	/*비밀번호확인 박스*/
	#pwCheckDiv{
		width:500px;
		padding:50px;
		margin:auto;
		margin-top:100px;
		border:1px #45A663 solid ;
		border-radius: 10px;
		position: relative;}
	/*비밀번호 입력칸*/	
	input#pwCk{
		width: 330px;
		border: none;
		border-bottom: 3px #45A663 solid;}
	/*패스워드 입력시 글자 공란으로 나오는 거 처리*/
	input[type=password] {font-family: "NanumSquare";}
	#typeChange1,#typeChange2{
		position:absolute;
		z-index: 100;
		top: 110px;
		right: 120px;
		color:black;
		font-size: 25px;
		color:gray;
	}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container"  >
			<h3>회원정보 수정</h3> 
			
			<!-- 화면내용입력부분 -->
			<div id="result">
				<div id="pwCheckDiv">
					<h4>비밀번호 확인</h4>
					<br>
					<form action="${path}/member/updateMemberView" method="post">
						<input type="password" id="pwCk" name="memPwd" placeholder="비밀번호를 입력해주세요">&nbsp;&nbsp;
						<i id="typeChange1" class="fas fa-eye"></i>
						<i id="typeChange2" class="fas fa-eye-slash" style="display:none;"></i>
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
		let sns="${loginMember.memPwd}";
		console.log(sns.substr( 0, 2));
		if(sns.substr( 0, 2)=="소셜"){
			swal("","소셜로그인회원은 해당 페이지에서 회원정보수정을 할 수 없습니다.","warning");
			return false;
		}
	 	if($("input[name=memPwd]").val()==""){
			swal("","비밀번호를 입력해주세요.","warning");
			return false;
		}
	}
	$("#typeChange1").click(e=>{
		$(e.target).hide();
		$("input[name=memPwd]").prop("type","text");
		$("#typeChange2").show();
	})
	$("#typeChange2").click(e=>{
		$(e.target).hide();
		$("input[name=memPwd]").prop("type","password");
		$("#typeChange1").show();
	});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
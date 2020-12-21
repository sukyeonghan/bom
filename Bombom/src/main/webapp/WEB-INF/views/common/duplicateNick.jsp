<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	.nickOk{color:green; margin:3px;}
    .nickError{color:red; margin:3px;}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<section id="content">
	efwefefefefwefwe
	<div id="nickDiv">
		<h3>추가정보입력</h3>
		
		<form action="${path }/member/enrollMember" method="post">
			<input type="text" name="email"  value="${insertMember.memEmail }" readonly/>
			<input type="text" name="nick" id="memNick-input" value="${nick }"/>
			<p class="guide nickOk">사용가능한 닉네임입니다.</p>
			<p class="guide nickError">사용중인 닉네임입니다.</p>
			<input type="hidden" name="pro"  value="${insertMember.memPro }"/>
			<input type="hidden" name="password"  value="${insertMember.memPwd }"/>
			<input type="submit" value="완료" onclick="fn_insertMemberBtn();">
		</form>
	</div>
</section>
<script>
	$("#memNick-input").keyup(e=>{
		const nickReg=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}$/;
	    const memNick=$(e.target).val().trim();
	    if(memNick.length<2){
	    	  $(".guide").hide();
	    	  return;
	      }else{ 
	    	  $.ajax({
	   	         url:"${path}/member/checkDuplicateNick",
	   	         data:{memNick:memNick},
	   	         success:data=>{
	   	            if(data===true&&nickReg.test(memNick)){
		  	            $(".nickOk").show();
		  	            $(".nickError").hide();
	   	            }else{
	   	            	$(".nickOk").hide();
		  	            $(".nickError").shoew();
	   	            }
	   	         }
	   	         
		   	  });
	      }
	});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include >

<style>
	.guide{display:none;}
	.nickOk{color:green; margin:3px;}
    .nickError1,.nickError2{color:red; margin:3px;}
    #nickDiv{border-radius: 10px; border:2px #45A663 solid ; width: 600px; margin:200px auto; padding: 30px; text-align: center;}
    #nickBtn{width: 100%;margin-top: 20px;}
</style>
	<section id="content">
		<div id="nickDiv" >
			<h4>추가정보입력</h4>
			<br>
			<form action="${path }/member/enrollMember" method="post" onsubmit="return fn_insertMemberBtn();">
				<input type="text" class="form-control" name="email"  value="${insertMember.memEmail }" readonly/>
				<input type="text" class="form-control" name="nick" id="memNick-input" value="${insertMember.memNick }"/>
				<p class="guide nickOk">사용가능한 닉네임입니다.</p>
				<p class="guide nickError1">사용중인 닉네임입니다.</p>
				<p class="guide nickError2">부적합한 닉네임입니다.</p>
				<input type="hidden" name="pro"  value="${insertMember.memPro }"/>
				<input type="hidden" name="password"  value="${insertMember.memPwd }"/>
				<input type="submit" id="nickBtn" class="btn btn-success"  value="완료">
			</form>
		</div>
	</section>


<script>
		$(function(){
			
			$(".nickError1").show();
		})
		
		var nickReg=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}$/;
		
		$("#memNick-input").keyup(e=>{
		    var memNick=$(e.target).val().trim();
		    if(memNick.length<2){
		    	  $(".guide").hide();
		    	  return false;
		   	}else{ 
		    	  $.ajax({
		   	         url:"${path}/member/checkDuplicateNick",
		   	         data:{memNick:memNick},
		   	         success:data=>{
		   	            if(data===true&&nickReg.test(memNick)){
			  	            $(".nickOk").show();
			  	            $(".nickError1").hide();
			  	            $(".nickError2").hide();
		   	            }else if(data==false){
		   	            	$(".nickOk").hide();
			  	            $(".nickError1").show();
			  	            $(".nickError2").hide();
		   	            }else if(!nickReg.test(memNick)){
		   	            	$(".nickOk").hide();
			  	            $(".nickError1").hide();
			  	            $(".nickError2").show();
		   	            }
		   	         }
		   	         
			   	 });
		    }
		});
		
		
	
	
	
	function fn_insertMemberBtn(){
		var result=true;
		var memNick=$("#memNick-input").val().trim();
		if(!nickReg.test(memNick)){
			alert("적합하지 않은 닉네임입니다. 다시 입력해주세요.");
			return false;
		}
		
		$.ajax({
  	         url:"${path}/member/checkDuplicateNick",
  	         data:{memNick:memNick},
  	         dataType:"json",
  	      	 async: false,
  	         success:data=>{
  	            if(data===false){
	  	            alert("이미 사용하는 닉네임입니다. 다시 입력해주세요");
	  	            result=false;
  	            }
  	         }
	   	 });
		
		return result;
	};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 
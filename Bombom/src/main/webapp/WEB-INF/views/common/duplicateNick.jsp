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
	.nickOk,.emailOk{color:green; margin:3px;}
    .nickError1,.nickError2,.emailInsert,.emailError1,.emailError2{color:red; margin:3px;}
    #nickDiv{border-radius: 10px; border:2px #45A663 solid ; width: 600px; margin:200px auto; padding: 30px; text-align: center;}
    #nickBtn{width: 100%;margin-top: 20px;}
</style>
	<section id="content">
		<div id="nickDiv" >
			<h4>추가정보입력</h4>
			<br>
			<form action="${path }/member/enrollMember" method="post" onsubmit="return fn_insertMemberBtn();">
				<input type="text" class="form-control" name="email" id="memEmail-input" value="${insertMember.memEmail }" readonly/>
				<p class="guide emailInsert">이메일을 입력해주세요</p>
				<p class="guide emailOk">사용가능한 이메일입니다.</p>
				<p class="guide emailError1">이미 가입된 이메일입니다.</p>
				<p class="guide emailError2">올바른 이메일 형식이 아닙니다.</p>
				<input type="text" class="form-control" name="nick" id="memNick-input" value="${insertMember.memNick }" placeholder="한글,영문,숫자로만 2~10자로 입력" readonly/>
				<p class="guide nickOk">사용가능한 닉네임입니다.</p>
				<p class="guide nickError1">사용중인 닉네임입니다.</p>
				<p class="guide nickError2">부적합한 닉네임입니다.</p>
				<input type="hidden" name="naverId" value="${insertMember.naverId}"/>
				<input type="hidden" name="googleId" value="${insertMember.googleId }"/>
				<input type="hidden" name="kakaoId" value="${insertMember.kakaoId}"/>
				<input type="hidden" name="pro" value="${insertMember.memPro }"/>
				<input type="hidden" name="password" value="${insertMember.memPwd }"/>
				<input type="hidden" name="currentUrl" value="/${currentUrl }"/>
				<input type="submit" id="nickBtn" class="btn btn-success"  value="완료">
			</form>
		</div>
	</section>


<script>
		$(function(){
			let emailYn="${emailYn}";
			let nickYn="${nickYn}";
			console.log('nickYn: '+ nickYn);
			console.log('emailYn: '+ emailYn);
			
			if(emailYn == 'N' && nickYn =='N' ){
				$("input[name=email]").prop("readonly",false);
				$("input[name=nick]").prop("readonly",false);
				$(".nickError1").show();
				$(".emailInsert").show();
			}else if(emailYn == 'Y'&& nickYn == 'N'){
				$("input[name=nick]").prop("readonly",false);
				$(".nickError1").show();
			}else if(emailYn == 'N'&& nickYn == 'Y'){		
				$("input[name=email]").prop("readonly",false);
				$(".emailInsert").show();
			}
		})
		
		const nickReg=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}$/;
		const emailReg= /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
		
		$("#memNick-input").keyup(e=>{
		    var memNick=$(e.target).val().trim();
		    if(memNick.length<2){
		    	$(".nickOk").hide();
  	            $(".nickError1").hide();
  	            $(".nickError2").hide();
  	          	
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
			  	            $(".nickError2").hide()
		   	            }else if(!nickReg.test(memNick)){
			  	          	$(".nickOk").hide();
			  	            $(".nickError1").hide();
			  	            $(".nickError2").show();
		   	            }
		   	         }
		   	         
			   	 });
		    	 
		    }
		});
		
		$("#memEmail-input").keyup(e=>{
			 let memEmail=$(e.target).val().trim();
			 $(".emailInsert").hide();
   	 		 $.ajax({
	   	         url:"${path}/member/checkDuplicateEmail",
	   	         data:{memEmail:memEmail},
	   	         success:data=>{
	   	       		 //이메일이 있으면 false,없으면 true
	   	            if(data===true&&emailReg.test(memEmail)){
	   	             	$(".emailOk").show();
		  	            $(".emailError1").hide();
		  	            $(".emailError2").hide();
	   	            }else if(data==false){
	   	            	$(".emailOk").hide();
		  	            $(".emailError1").show();
		  	            $(".emailError2").hide();
	   	            }else if(!emailReg.test(memNick)){
	   	            	$(".emailOk").hide();
		  	            $(".emailError1").hide();
		  	            $(".emailError2").show();
	   	            }
	   	         }
	   	         
		   	 });
		});
		
	
	
	
	function fn_insertMemberBtn(){
		var result=true;
		var memNick=$("#memNick-input").val().trim();
		var memEmail=$("#memEmail-input").val().trim();
		if(!nickReg.test(memNick)){
			alert("적합하지 않은 양식의 닉네임입니다. 다시 입력해주세요.");
			return false;
		}
		if(!emailReg.test(memEmail)){
			alert("적합하지 않은 양식의 이메일입니다.. 다시 입력해주세요.");
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
		
		$.ajax({
  	         url:"${path}/member/checkDuplicateEmail",
  	         data:{memEmail:memEmail},
  	         success:data=>{
  	       		 //이메일이 있으면 false,없으면 true
  	        	if(data===false){
	  	            alert("이미 사용하는 이메일입니다. 다시 입력해주세요");
	  	            result=false;
  	            }
  	         }
  	         
	   	 });
		
		
		return result;
	};

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/> 
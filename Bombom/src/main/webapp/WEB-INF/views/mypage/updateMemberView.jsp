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
   	#flexDiv{display:flex; padding: 0px 10% 0px 10%;}
	#mypage-container{min-width:800px; width:100%; padding-right:100px;}
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
    .pwOk,.nickOk{color:green; margin:3px;}
    .pwError,.nickError,.nickError2,.pwpw{color:red; margin:3px;}
    .left{text-align:left;}
    input[type=password] {font-family: "NanumSquare";}
 	
</style>
<!-- sweet alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
$(function(){
   //이미지 클릭시 파일업로드실행함수 실행
   $("#profileImg").on("click",e=>{
      fn_upload();
   });
   //파일 업로드시 이미지 체인지
   $("#memPro").on("change",e =>{ 
      $("#imgDiv").html("");
      let reader=new FileReader();
      reader.onload=e=>{
         let img=$("<img>",{"src":e.target.result,id:"profileImg",width:"150px",height:"150px",onclick:"fn_upload();"});
         img.addClass("rounded-circle");
         $("#imgDiv").append(img); 
      }
      reader.readAsDataURL($(e.target)[0].files[0]);
   }); 
   
   //가이드 가려두기
   $(".guide").hide();
   
   //닉네임중복체크 가이드
   $("#myMemNick").keyup(e=>{
	  var nickReg=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}$/;
      const memNick=$(e.target).val().trim();

      if(memNick.length<2){
    	  $(".guide").hide();
    	  return;
      }else{ 
    	  $.ajax({
   	         url:"${path}/member/checkDuplicateNick",
   	         data:{memNick:memNick},
   	         success:data=>{
   	            if(data===true||memNick=="${loginMember.memNick}"){
	  	            if(!nickReg.test(memNick)){
	  	            	$(".guide.nickError2").show();
	  	            	$(".guide.nickError").hide();
	  	            	$(".guide.nickOk").hide(); 
	  	            }else{
	  	            	$(".guide.nickError2").hide();
	  	            	$(".guide.nickError").hide();
	    	            $(".guide.nickOk").show(); 
	  	            }
   	            }else{
   	               $(".guide.nickError2").hide();
   	               $(".guide.nickError").show();
   	               $(".guide.nickOk").hide();
   	            }
   	         }
	   	  });
      }
   });  
     

   //패스워드 일치여부 확인가이드
   $("input[type=password]").keyup(e=>{
      var memPwd=$("#memPwd").val().trim();
      var memPwdCk=$("#memPwdCk").val().trim();
      if(memPwd==memPwdCk){
         $(".guide.pwOk").show();
         $(".guide.pwError").hide();
      }else{
         $(".guide.pwOk").hide();
         $(".guide.pwError").show();
      }
   });
   //비밀번호 유효성검사
   $("#memPwd").keyup(e=>{
      $(".guide.pwpw").show();
      var memPwd=$("#memPwd").val().trim();
      var memPwdCk=$("#memPwdCk").val().trim();
      var pwReg=/^.*(?=^.{8,15})(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%%^&*()]).*$/;
      if(pwReg.test(memPwd)){
         $(".guide.pwpw").hide();   
      }else{
         $(".guide.pwpw").show();   
               
      }
   });
   //비밀번호 표시 체크 여부에따라 비밀번호 타입 바꿔 표시하기
   $("#pwOpen").change(e=>{
	  if($("input[name=pwOpen]").is(":checked") == true){
		  $("#memPwd").prop("type","text")
		  $("#memPwdCk").prop("type","text");
	  }else{
		  $("#memPwd").prop("type","password")
		  $("#memPwdCk").prop("type","password");
	  }
   });
   
})
//파일업로드 실행함수
function fn_upload(){
   $("#memPro").click();
}
//업데이트전 확인사항 체크
function fn_updateMember(){
   	var memPwd=$("#memPwd").val().trim();
   	var memPwdCk=$("#memPwdCk").val().trim();
   	var memNick=$("#myMemNick").val().trim();
   	var pwReg=/^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;
   	var nickReg=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]{2,10}$/;
	var spaceCk=/\s/;
   	
   	if(spaceCk.test($("#memPwd").val())){
   		swal("비밀번호에 띄어쓰기는 하실수 없습니다.");
   		return false;
   	}
	
   	if(spaceCk.test($("#myMemNick").val())){
   		swal("닉네임에 띄어쓰기는 하실수 없습니다.");
   		return false;
   	}
   	if(memNick.length>0){
	   var flag=true;
   	   if(!nickReg.test(memNick)){
   		 swal("닉네임 양식이 올바르지 않습니다.영문,숫자,한글로만 2자이상 10자이하로 입력해주세요.");  
   		 flag=false;
   	   }
	   $.ajax({
	       url:"${path}/member/checkDuplicateNick",
	       data:{memNick:memNick},
	       async:false, 
	       success:data=>{
	          if(data===false && memNick != "${loginMember.memNick}"){
	             swal("닉네임이 중복됩니다. 확인해주세요");
	             flag=data;
	          }else{
	        	  if((memPwd.length>0) || (membPwdCk.length>0)){
	        		  	if(memPwd!=memPwdCk){
	        		        swal("비밀번호가 일치하지 않습니다.");
	        		        flag=false;
	        		     }
	        		    if(!pwReg.test(memPwd)){
	        		        swal("비밀번호 양식이 올바르지 않습니다.");
	        		        flag=false;
	        		    }
	        	   }
	          }
	       }   
	    });
	    return flag;
	}

   	if((memPwd.length>0) || (membPwdCk.length>0)){
	  	if(memPwd!=memPwdCk){
	        swal("비밀번호가 일치하지 않습니다.");
	        return false;
	     }
	    if(!pwReg.test(memPwd)){
	        swal("비밀번호 양식이 올바르지 않습니다.");
	        return false;
	    }
	} 
 
}


</script>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container"  >
        
         <div id="update-container">
           <h3 id="sub-title">회원정보수정</h3> 
              <form action="${path }/member/updateMemberEnd" method="post" name="updateFrm" enctype="multipart/form-data">
                 <input type="hidden" name="memNo" class="form-control" value="${loginMember.memNo }">
                <div id="imgDiv">           
                    <img src="${path }/resources/upload/profile/${loginMember.memPro}" class="rounded-circle" id="profileImg"  alt="기본프로필" width="150" height="150"><br> 
                </div>
                 <input type="file" id="memPro" name="upload" accept="image/gif, image/jpeg, image/png" style="display:none;">
                 <input type="hidden" name="pastPro" value="${loginMember.memPro}"/>
                 <input type="text" name="memEmail" class="form-control" value="${loginMember.memEmail }" readonly>
                 <br>
                 <input type="password" name="memPwd" id="memPwd" class="form-control" placeholder="비밀번호를 변경하는 경우 입력해주세요">
                 <p class="guide pwpw left">영문,숫자,특수문자 조합 8자 이상 16자 이하로 입력해주세요</p>
                 <input type="password" name="memPWdCk" id="memPwdCk" class="form-control" placeholder="비밀번호 확인">
                 <p class="guide pwOk left ">비밀번호가 일치합니다.</p>
               	 <p class="guide pwError left">비밀번호가 일치하지 않습니다.</p>
               	 <div style="display:flex; margin-top:10px;"><input id="pwOpen" name="pwOpen" type="checkbox" value="open"><label for="pwOpen">비밀번호표시</label></div>
               <br>
                 <p class="left">닉네임:</p>
                <input type="text" name="memNick" id="myMemNick" class="form-control" placeholder="${loginMember.memNick }">
               <p class="guide nickOk left">멋진 닉네임이네요. 사용이 가능합니다.</p>
               <p class="guide nickError left">안타깝네요. 이미 있는 닉네임입니다.</p>
               <p class="guide nickError2 left">닉네임은 한글,영문,숫자만 가능합니다</p>
               <div class="btn-box">
                  <input type="button" class="btn btn-danger" data-toggle="modal" data-target="#withdrawalModal" value="탈퇴"/>
                  <input type="submit" class="btn btn-success" onclick="return fn_updateMember();" id="updateBtn" value="수정"/>
               </div> 
              </form>
      </div> 
        
      </div>
   </div>
   
     <!-- The Modal -->
     <div class="modal fade" id="withdrawalModal">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
           <!-- Modal Header -->
           <div class="modal-header">
                <h3 class="modal-title" id="modalLabel">탈퇴하기</h3>
             <button type="button" class="close" data-dismiss="modal">&times;</button>
           </div>
           <form action="${path }/member/deleteMember" method="post" name="deleteFrm" id="deleteFrm">
              <!-- Modal body -->
              <div class="modal-body">
                   가입된 회원정보가 삭제됩니다. 작성하신 게시물은 삭제되지 않습니다.<br>
                   회원탈퇴를 진행하시겠습니다까?
                   <input type="hidden" name="memNo" value="${loginMember.memNo }">
              </div>
              <!-- Modal footer -->
              <div class="modal-footer btn-box">
                <input type="button" class="btn btn-secondary" data-dismiss="modal" value="취소">
                <input type="submit" class="btn btn-danger" id="deleteBtn" value="탈퇴">
              </div>
           </form>
           </div>
         </div>
       </div>
     
 
   
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
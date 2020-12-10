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
	
	/*버튼 가운데정렬*/
      .btn-box{text-align: center;}
        }
    /* 테두리 */
        div#qna-container{
          width:80%;
          padding:20px;
          margin:auto;
          border:1px #45A663 solid ;
          border-radius: 10px;
        }    
	/*글자수  */
	.contentBox{
		text-align:right;
	}
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
		<div id="qna-container" class="media-body">
			<form action="${path }/mypage/insertQna" method="post">
            <h3>1:1 문의글 작성</h3>
            <br>
            <c:if test="${loginMember!=null }">
            	<input type="hidden" value="${loginMember.memNo }" name="qnaWriter">
			</c:if>
            <!--문의 카테고리  -->
            <div class="form-group">
              <select class="form-control" id="category" name="qnaCategory" required>
              	<option value="" disabled selected>카테고리 선택</option>
                <option value="주문/결제" >주문/결제</option>
                <option value="배송">배송</option>
                <option value="취소/환불">취소/환불</option>
                <option value="기타">기타</option>
              </select>
            </div> 
           
            <!-- 제목 -->
            <div class="form-group">
              <input type="text" class="form-control" id="title" placeholder="제목" name="qnaTitle" required/>
             
            </div>
            
            <div class="form-group contentBox">
              <textarea
                class="form-control"
                rows="10"
                id="contents"
                placeholder="문의할 내용을 작성해주세요."
                onKeyUp="javascript:fnChkByte(this,'1000')"
                name="qnaContent"
                required
              ></textarea>
              <span id="byteInfo">0</span>/1000bytes
            </div>
            <div class="btn-box">
              <button type="button" class="btn btn-outline-secondary" onclick="location.replace('${path}/mypage/qna')">목록으로</button>
              <button type="submit" class="btn btn-success">작성완료</button>
        	</div>
        	</form>
         </div>
            
 </div>
</section>
<script>

	//문의내용 작성 Byte 수 체크 제한
	function fnChkByte(obj, maxByte) {
	  var str = obj.value;
	  var str_len = str.length;
	  var rbyte = 0;
	  var rlen = 0;
	  var one_char = "";
	  var str2 = "";
	
	  for(var i = 0; i<str_len; i++) {
	    one_char = str.charAt(i);
	    if(escape(one_char).length > 4) {
	      rbyte += 3; //한글3Byte
	    }else{
	      rbyte++; //영문 등 나머지 1Byte
	    }
	
	    if(rbyte <= maxByte){
	      rlen = i + 1; //return할 문자열 갯수
	    }
	  }
	
	  if(rbyte > maxByte) {
	    // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    alert("메세지는 최대 " + (maxByte) + "byte를 초과할 수 없습니다.");
	    str2 = str.substr(0, rlen); //문자열 자르기
	    obj.value = str2;
	    fnChkByte(obj, maxByte);
	  }else{
	    document.getElementById("byteInfo").innerText = rbyte;
	  }
	}	
	
	$('#title').on('keyup', function() {
	
		if($("#title").val().length > 16) {
	
	alert("글자수는 15자로 이내로 제한됩니다.");
	
			$(this).val($("#title").val().substring(0, 16));
			
		}
	});


</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
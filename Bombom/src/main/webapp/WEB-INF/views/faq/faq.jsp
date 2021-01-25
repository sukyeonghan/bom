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
	#board-container{min-width:800px; width:100%; padding-right:100px;}
	
	div#line-container{
		width:100%;
		padding:40px;
		margin:auto;
		border:1px #45A663 solid ;
		border-radius: 10px;
	}
	h3{text-align: center;}
	/*버튼 가운데정렬*/
	.btn-box{text-align: center;}
	/*버튼크기고정*/
	.btn{width: 100px;}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/boardMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="board-container"  >
	

	<div id="line-container">
		<h3>자주묻는 질문 등록/수정</h3>
		<br>
		<!-- faq값이 없을 때는 등록, faq 값이 넘어왔을떄는  수정 -->
		<c:if test="${empty faq }">
			<form name="faqFrm" action="${path }/faq/insertFaq" >
		</c:if>
		<c:if test="${not empty faq }">
			<form name="faqFrm" action="${path }/faq/updateFaqEnd">
		</c:if>
			<c:if test="${not empty faq }">
				<input type="hidden" value="${faq.faqNo }" name="faqNo">
			</c:if>
			

			<select id="cate" name="faqCategory" class="form-control"  required> 
					<option value=" " ${empty faq.faqCategory?"selected":""} disabled >카테고리선택</option>
					<option value="주문/결제" ${faq.faqCategory eq "주문결제"?"selected":""} >주문/결제</option>
					<option value="배송" ${faq.faqCategory eq "배송"?"selected":""}>배송</option>
					<option value="취소/환불" ${faq.faqCategory eq "취소/환불"?"selected":""}>취소/환불</option>
					<option value="기타" ${faq.faqCategory eq "기타"?"selected":""}>기타</option>
			</select>
	
				<br>
				<input type="text" class="form-control" name="faqTitle" placeholder="제목을 입력해주세요" value="${faq.faqTitle }" required>
				<br>
				<textarea class="form-control" rows="10" name="faqContent" id="faqContent" placeholder="내용을 입력해주세요" onKeyUp="javascript:fnChkByte(this,'1000')" required><c:out value="${faq.faqContent }"/></textarea>
				<div style="float:right;">
					<span id="byteInfo">0</span>/1000bytes
				</div>
				<br>
				<div class="btn-box">
					
					<input type="button" class="btn btn-outline-success" value="목록으로" onclick="location.replace('${path }/faq/faqList')">&nbsp;&nbsp;
					
					<c:if test="${empty faq }">
						<input type="submit" class="btn btn-success" value="등록" onclick="return fn_check()">
					</c:if>
					<c:if test="${not empty faq }">
						<input type="submit" class="btn btn-success" value="수정 " onclick="return fn_check()">
					</c:if>

				</div>
				
			</form>
		</div>
		</div>
	</div>
</section>
<script>

	function fn_check(){
		//개행 태그로 바꾸기
		var str = $("faqContent").value;
		str = str.replace(/(?:\r\n|\r|\n)/g, '<br/>');
		alert(str);
		$("#faqContent").value = str;
		
		let title=$("input[name=faqTitle]").val();
		let content=$("input[name=faqContent]").val();
		let count=0;
		let one="";
		if(faqFrm.faqCategory.value==" ") {
			swal("카테고리를 선택해주세요.");
			return false;
		}
		if(title.length>30){
			alert("제목은 30자 이내로 영문,한글,숫자만 가능합니다.");
			return false;
		}

	}
	
	//Byte 수 체크 제한
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
        alert("내용은 최대 " + (maxByte) + "byte를 초과할 수 없습니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
      }else{
        document.getElementById("byteInfo").innerText = rbyte;
      }
    }


	
	

</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="${path }/resources/css/product/insertProduct.css">
<style>
	/*사진 미리보기 div*/
    .proDiv{
    	border:1px solid #ccc;
    	width:150px;
    	height:150px;
    	position:relative;
    	float:left;
    	background:url(${path }/resources/images/product/plus2.png);
    	background-size:100% 100%;
    	background-position:center;
    }
</style>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container">
	<div id="flexDiv">
	
		<!--제품 관리 내비게이션바 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp"/>
		
		<div id="admin-container" >
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">제품등록</h3> 
			
			<!-- 제품 등록 -->
			<form action="${path }/admin/productInsertEnd" method="post" enctype="multipart/form-data">
				<table id="insert-table">
					<tr>
						<th>카테고리<span class="nesse"> *</span></th>
						<td>
						<!-- 검색 카테고리 -->
							<div class="select-box">
								<select class="sort w3-select" id="category" name="pdtCategory">
									<option selected disabled hidden>카테고리 선택</option>
									<option value="식품">식품</option>
									<option value="잡화">잡화</option>
									<option value="주방">주방</option>
									<option value="욕실">욕실</option>
									<option value="여성용품">여성용품</option>
									<option value="반려동물">반려동물</option>
								</select>
							</div>
						</td>
						<th class="margin">판매 상태<span class="nesse"> *</span></th>
						<td>
							<!-- 판매상태 카테고리 -->
							<div class="select-box">
								<select class="sort w3-select" id="status" name="pdtStatus">
									<option selected disabled hidden>판매상태 선택</option>
									<option value="Y">Y</option>
									<option value="N">N</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th>제품명<span class="nesse"> *</span></th>
						<td><input type="text" id="name" class="text w3-input" name="pdtName" placeholder="%()-_,/ 외 특수문자 입력 불가"></td>
						<th class="margin">기본가격(숫자)<span class="nesse"> *</span></th>
						<td><input type="text" id="price" class="text w3-input" name="pdtPrice"></td>
					</tr>
					<tr>
						<th>이벤트</th>
						<td colspan="3">
						<!-- 이벤트 카테고리 -->
							<div class="select-box">
								<select class="sort w3-select" id="eventSelect" name="eventNoRef">
									<option value="">이벤트 선택</option>
									<c:if test="${not empty list}">
										<c:forEach var="e" items="${list}">
											<option value="${e.eventNo }">
												<c:out value='${e.eventNo }/${e.eventTitle }'/> 
											</option>
										</c:forEach>
									</c:if>
								</select>
							</div>
						</td>
						
					</tr>
					 <tr>
                        <th>추가 옵션</th>
                        <td colspan="3">
                        	<input type="button" class="btn btn-success btn-sm" id="add-option" value="옵션 추가">
                        </td>
                    </tr>
                    
				</table>
				<input type="hidden" name="optionList" id="option_list">
				
				<!-- 제품 설명 -->
				<div id="middle-div">
					<p class="title" id="product-intro">간단한 제품 설명</p>
					<span id="text-span">
						<textarea id="intro-text" rows="5" placeholder="65자(200bytes)이내로 적어주세요" name="pdtIntro" onKeyUp="javascript:fnChkByte1(this,'200')"></textarea>
						<div style="float:right;">
							<span id="byteInfo1">0</span>/200bytes
						</div>
					</span>
					
				</div>
				
				<!-- 제품 썸네일,상세 이미지 등록 -->
				<div id="bottom-div">
					<p class="title">제품 썸네일 이미지(최대 6장)<span class="nesse"> *</span></p>
					<div id="thumbContainer">
						<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일1(메인)</p>
			     			</div>
							<div class="proDiv" id="1"> 
								<input type="file" class="proPic" name="thumbImgs" id="input1" accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
			     		</div>
			     				
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일2</p>
			     			</div>
			     			<div class="proDiv" id="2">
				     			
								<input type="file" class="proPic" name="thumbImgs" id="input2" accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
							</div>
			     		</div>
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일3</p>
			     			</div>
				     		<div class="proDiv" id="3"> 
							
								<input type="file"  class="proPic" name="thumbImgs" id="input3"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일4</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="4"> 
							
								<input type="file"  class="proPic" name="thumbImgs" id="input4"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일5</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="5"> 
								
								<input type="file"  class="proPic" name="thumbImgs" id="input5"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일6</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="6"> 
							
								<input type="file"  class="proPic" name="thumbImgs" id="input6"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     	
					</div>
					
		      		<div id="detail-image">
			      		<p class="title">제품 상세 이미지(총 1장)<span class="nesse"> *</span></p>
			      		<input type="file" id="tests" class="form-control-file border" name="detailImg" accept="image/gif, image/jpeg, image/png">
		      		</div>
				</div>
				
				<div id="bottom-btns">
					<input type="submit" class="btn btn-success insertPro" value="등록하기" onclick="return insert();">
					<input type="button" class="btn btn-success goList" onclick="location.href='${path}/admin/moveProduct'" value="목록">
				</div>
				
			</form>
				
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	//옵션 추가하기 
	$("#add-option").click(function(){
	    
	    var addOption="";
	    addOption+='<tr name="trOption">';
	    addOption+='<th>&nbsp&nbsp옵션 내용</th>';
	    addOption+='<td><input type="text" class="content w3-input" name="pdtOptionContent" placeholder="%()-_,/ 외 특수문자 입력 불가"></td>';
	    addOption+='<th class="margin">추가 요금(숫자)</th>';
	    addOption+='<td class="td-flex"><input type="text" class="addprice w3-input" name="pdtOptionAddprice" placeholder="기본가격에 추가되는 요금을 적어주세요.">';
	    addOption+='<input type="button" class="btn btn-success btn-sm delBtn" name="delBtn" value="삭제"></td>';
	    addOption+='</tr>';
	
	    $("#insert-table").append(addOption);
	   
	});
	
	//옵션 삭제 
	$(document).on("click","input[name=delBtn]",function(){
	
	    var trHtml=$(this).parent().parent();
	    trHtml.remove();
	});

	//옵션내용 유효성 검사
	$(document).on("focusout","input[name=pdtOptionContent]",function(e){
	    var check=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_,/ ]*$/;
	    var name=$("input[name=pdtOptionContent]").val();
	
	    if(!check.test(name)){
	           swal("옵션명에 특수문자는 입력할 수 없습니다.");
	           $(e.target).val('');
	           return false;
	       }
	    if(name==''){
	        swal("옵션 내용을 입력해주세요.");
	        return false;
		}
	});

	//옵션가격 유효성 검사
	$(document).on("focusout","input[name=pdtOptionAddprice]",function(e) {
	    var check=/^[-0-9]*$/;
	    if(!check.test($("input[name=pdtOptionAddprice]").val())){
	           swal("옵션 가격에 숫자 외에는 입력하실 수 없습니다.");
	           $(e.target).val('');
	           return false;
	       } 
	    if($("input[name=pdtOptionAddprice]").val()==''){
	        swal("옵션 가격을 입력해주세요.");
	        return false;
	    }
	    
	});
	
		
	//제품 등록하기 버튼 누르면 실행되는 함수
	function insert(){
	    
	    //유효성검사-카테고리 및 판매상태
	    if($("#category").val()==null){
	        swal("제품카테고리를 선택해주세요.");
	        return false;
	    }
	    if($("#status").val()==null){
	        swal("판매 상태를 선택해주세요.");
	        return false;
	    }
	    
	  	//제품명 유효성 검사
	  	var val=$("#name").val();
	  	if(val.length>0){
	  		
	  		var name=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_,/ ]*$/;
	        
	        if(!name.test(val)){
	               swal("제품명에 특수문자는 입력하실 수 없습니다.");
	               $("#name").val('');
	               return false;
	           }
	      	//중복검사
	        $.ajax({
	            
	               url:"${path}/admin/checkPdtName?pdtName="+val,
	               type:"get",
	               dataType:"json",
	               success:function(data){
	                   if(data!=0){
	                       swal("상품명이 중복됩니다.");
	                       $("#name").val('');
	                       return false;
	                   }
	               }
	           }); 
	        
	  	}else{
	        swal("제품명을 입력해주세요.");
	        return false;
	  	}
	   
	  	//가격 유효성 검사
	  	var val2=$("#price").val();
	    if(val2.length>0){
	    	 var price=/^[0-9]*$/;
	        if(!price.test($("#price").val())){
	               swal("제품가격에 숫자 외에는 입력하실 수 없습니다.");
	               $("#price").val('');
	               return false;
	        }
	    }else{
	    	swal("가격을 입력해주세요.");
	        return false;
	    }
	    
	
	
	    //제품 썸네일 사진
	     if($("#input1").val()==""){
	        swal("대표이미지를 등록해주세요.");
	        return false;
	    } 
	    
	    //상세 사진 파일 검사
	    if($("input[name=detailImg]").val()==""){
	        swal("상세 사진을 등록해주세요.");
	        return false;
	    }
	
		//옵션 등록하기
	    var list=[];
	    var contents = document.getElementsByName("pdtOptionContent");
	    	
	 	var content;
	 	var price;
	 	
	 	//옵션 행 개수만큼 검사
	    for(var i=0; i<contents.length; i++){
	    	content=$("input[name=pdtOptionContent]").eq(i).val();
	    	price=$("input[name=pdtOptionAddprice]").eq(i).val();
	    	
	    	if(content!=''&price!=''){
	    		//옵션 내용과 가격을 입력 했으면
	    		list.push({"pdtOptionContent":content,
	            "pdtOptionAddprice":price});
	    	}else{
	    		//옵션 내용과 가격을 입력 안했으면 
	    		swal("옵션 내용과 가격을 등록해주세요.");
	    		return false;
	    	}
	    }
	    $("#option_list").val(JSON.stringify(list));
	   
	}
	
	//이미지 업로드 
	$(function(){
	       //div 클릭시 파일업로드
	       $(".proDiv").on("click",e=>{
	           //input file만 선택
	           var file=$(e.target).children().first();
	           file.click();
	       });
	       //파일 업로드시 이미지 체인지
	       $(".proPic").on("change",e =>{ 
	         
	            let reader=new FileReader();
	            let div=$(e.target).parent();
	              //이전 사진 삭제
	            $(e.target).prev().remove();
	            reader.onload=e=>{
	              let img=$("<img>",{"src":e.target.result,width:"150px",height:"150px",onclick:"fn_upload(this);"});
	              img.addClass("proImg");
	              div.prepend(img); 
	          	}
	          	reader.readAsDataURL($(e.target)[0].files[0]);
	       }); 
	});
	
	//사진 눌렀을 때 다시 파일 업로드
	function fn_upload(e){
	    $(e).next().click();
	
	}  
	
	
	//이미지 삭제 버튼
	$(function(){
	    $(".close").on("click",e=>{	  
	        //이미지 삭제
	        $(e.target).prev().prev().remove();
	        //input file value삭제
	        console.log($(e.target).prev());
	        $(e.target).prev().val("");
	       });
	});
	
	//제품설명 Byte 수 체크 제한
	function fnChkByte1(obj, maxByte) {
	  var str = obj.value;
	  var str_len = str.length;
	  var rbyte = 0;
	  var rlen = 0;
	  var one_char = "";
	  var str2 = "";
	  for(var i = 0; i<str_len; i++) {
	    one_char = str.charAt(i);
	    if(escape(one_char).length > 4) {
	      rbyte += 3; //한글2Byte
	    }else{
	      rbyte++; //영문 등 나머지 1Byte
	    }
	    if(rbyte <= maxByte){
	      rlen = i + 1; //return할 문자열 갯수
	    }
	  }
	  if(rbyte > maxByte) {
	    // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
	    swal("제품설명은 최대 " + maxByte + "byte를 초과할 수 없습니다.");
	    str2 = str.substr(0, rlen); //문자열 자르기
	    obj.value = str2;
	    fnChkByte1(obj, maxByte);
	  }else{
	    document.getElementById("byteInfo1").innerText = rbyte;
	  }
	}   
</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px; min-width: 230px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*반응형 없앤 css*/
	#flexDiv {
   		display: flex;
   		padding: 0px 10%;
   	}
   	#admin-container {
    	min-width: 800px;
      	width: 100%;
      	padding-right:100px;
   	}
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	
	/*셀렉트 박스 정렬*/
	.select-box{
		display:flex;
		justify-content:space-between;
	}
	/*정렬*/
	.sort{
		border:none;
		outline:none;
	}
	
	/*제품 등록 테이블*/
	#insert-table{
		width:90%;
		margin:20px 0;
	}
	tr,th{
		padding:10px;
	}
	
    /*제품 설명*/
     #middle-div{
    	margin-left:10px;
    	margin-bottom:20px;
    }
    .title{
    	font-weight:bold;
    }
    #intro-text{
    	resize:none;
    }
   
   /* 제품 썸네일,상세 이미지 등록*/
    #bottom-div{
    	margin-left:10px;
    	margin-top: 40px;
    }
    
    /*썸네일*/
    /*썸네일 이미지 전체 div*/
    #thumbContainer{
    	overflow:hidden;
    }
    /*바깥 div*/
    .thumbWrap{
    	width:150px;
    	height:170px;
    	float:left;
    	margin:45px;
    	position:relative;
   	}
   	/*썸네일1,썸네일2.. 타이틀*/
   	.sumTitle{
   		margin:0;
   	}
   	/*사진 미리보기 div*/
    .proDiv{
    	border:1px solid black;
    	width:150px;
    	height:150px;
    	position:relative;
    	float:left;
    }
    /*썸네일 사진*/
    .proImg{
 		position:absolute;
        max-width:100%; 
        max-height:100%;
        width:auto; 
        height:auto;
        margin:auto;
        top:0; bottom:0; left:0; right:0;
    }
    /*이미지 삭제 버튼*/
    .close{border:none;}
 
    /*상세 이미지 등록 div*/
    #detail-image{
    	margin-top:20px;
    	width:88%;
    }
    
  
    /*옵션*/
    .trOption{
    	margin-left:10px;
    }
    /*옵션 삭제버튼*/
    .delBtn{
    	margin-left:10px;
    }
    .delBtn2{
    	margin-left:15px;
    }
    
    /*등록하기,목록 버튼*/
    #bottom-btns{
    	text-align:center;
    	margin-top:100px;
    }
    .insertPro,.goList{
    	display:flex;
    	margin:5px;
    }
    
    label.form-control-file{
    	text-align:left;
    }
    label.test{
    	text-align:left;
    }
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container">
	<div id="flexDiv">
	
		<!--제품 관리 내비게이션바 -->
		<jsp:include page="/WEB-INF/views/admin/product/productNav.jsp"/>
		
		<div id="admin-container">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">제품수정</h3> 
			
			<!-- 제품 등록 -->
			<form action="${path }/admin/updateProductEnd" method="post" enctype="multipart/form-data">
				<table id="insert-table">
					<tr>
						<th>카테고리</th>
						<td>
						<!-- 검색 카테고리 -->
							<div class="select-box">
								<select class="sort" name="pdtCategory" required>
									<option value="식품" ${product.pdtCategory=='식품'?"selected":"" }>식품</option>
									<option value="잡화" ${product.pdtCategory=='잡화'?"selected":"" }>잡화</option>
									<option value="주방" ${product.pdtCategory=='주방'?"selected":"" }>주방</option>
									<option value="욕실" ${product.pdtCategory=='욕실'?"selected":"" }>욕실</option>
									<option value="여성용품" ${product.pdtCategory=='여성용품'?"selected":"" }>여성용품</option>
									<option value="반려동물" ${product.pdtCategory=='반려동물'?"selected":"" }>반려동물</option>
								</select>
							</div>
						</td>
						<th>판매 상태</th>
						<td>
							<!-- 판매상태 카테고리 -->
							<div class="select-box">
								<select class="sort" name="pdtStatus" required>
									<option value="Y" ${product.pdtStatus=='Y'?"selected":"" }>Y</option>
									<option value="N" ${product.pdtStatus=='N'?"selected":"" }>N</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td><input type="text" id="name" name="pdtName" value="${product.pdtName }" size="30"  required></td>
						<th>제품기본가격</th>
						<td><input type="text" id="price" name="pdtPrice" value="${product.pdtPrice }" size="30" required></td>
					</tr>
					<tr>
						<th>이벤트</th>
						<td colspan="3">
						<!-- 이벤트 카테고리 -->
							<div class="select-box">
								<select class="sort" id="eventSelect" name="eventNoRef">
									<c:choose>
										<c:when test="${not empty eventList && not empty event.eventNo}">
										<!-- 이벤트 목록도 있고 이전에 선택한 이벤트가 있는 경우 -->
											<option value="" selected>이벤트 선택</option>
											<c:forEach var="e" items="${eventList}">
												<option value="${e.eventNo }" ${e.eventNo==product.eventNoRef?"selected":"" } >
													<c:out value='${e.eventNo }/${e.eventTitle }'/> 
												</option>
											</c:forEach>
										</c:when>
										<c:when test="${not empty eventList && empty event.eventNo}">
										<!-- 이벤트 목록은 있지만 이전에 선택한 이벤트 없는 경우 -->
											<option value="" selected>이벤트 선택</option>
											<c:forEach var="e" items="${eventList}">
												<option value="${e.eventNo }" >
													<c:out value='${e.eventNo }/${e.eventTitle }'/> 
												</option>
											</c:forEach>
										</c:when>
										<c:when test="${ empty eventList}">
										<!-- 이벤트 목록 자체가 없는 경우 -->
											<option value="" selected>이벤트 선택</option>
										</c:when>
									</c:choose>
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
                    <c:if test="${not empty option}">
						<c:forEach var="o" items="${option }">
							<tr class="trOption" name="trOption">
								<th>&nbsp&nbsp옵션 내용</th>
       							<td><input type="text" name="pdtOptionContent" value="${o.pdtOptionContent}"></td>
        						<th>추가 요금</th>
        						<td><input type="text" name="pdtOptionAddprice" value="${o.pdtOptionAddprice }">
        						<button class="btn btn-success btn-sm delBtn2" name="delBtn">삭제</button></td>
							</tr>
						</c:forEach>
					</c:if>	
                    
				</table>
				<input type="hidden" name="test" id="test_list">
				
				<!-- 제품 설명 -->
				<div id="middle-div">
					<p class="title" id="product-intro">간단한 제품 설명</p>
					<textarea id="intro-text" rows="5" cols="100" placeholder="65자 이내로 적어주세요" name="pdtIntro" required><c:out value="${product.pdtIntro }"/>
					</textarea>
				</div>
				
				<!-- 제품 썸네일,상세 이미지 등록 -->
				<div id="bottom-div">
					<p class="title">제품 썸네일 이미지(최대 6장)</p>
					<div id="thumbContainer">
					<c:forEach var="th" items="${thumb }"></c:forEach>
						<div class="thumbWrap" > 
						
			     			<div>
			     				<p class="sumTitle">썸네일1(메인)</p>
			     			</div>
							<div class="proDiv" id="1"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
							<c:forEach var="th" items="${thumb }" begin="0" end="0">
								<c:if test="${not empty th.pdtThumbImage  }">
									<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
								</c:if>
							<%--	<c:choose>
								
									<c:when test="${not empty th.pdtThumbImage  }">
										<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
									</c:when>
							 		<c:otherwise>
										<img class="proImg" src="${path }/resources/images/product/plus2.png">
									</c:otherwise>
								
								</c:choose> --%>
							</c:forEach>
								<input type="file" class="proPic" name="thumbImgs" id="input1" accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
							
				     		</div>
			     		</div>
			     				
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일2</p>
			     			</div>
			     			<div class="proDiv" id="2">
			     				<img class="proImg" src="${path }/resources/images/product/plus2.png">
			     			<c:forEach var="th" items="${thumb }" begin="1" end="1">
			     				<c:if test="${not empty th.pdtThumbImage }">
			     					<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
			     				</c:if>
			     				<%-- <c:choose>
			     				
									<c:when test="${not empty th.pdtThumbImage }">
								
										<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
									</c:when>
									<c:otherwise>
										<img class="proImg" src="${path }/resources/images/product/plus2.png">
									</c:otherwise>
									
								</c:choose> --%>
							</c:forEach>
								
								<input type="file" class="proPic" name="thumbImgs" id="input2" accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
							</div>
			     		</div>
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일3<c:out value="${th.pdtThumbImage}"/></p>
			     			</div>
				     		<div class="proDiv" id="3"> 
				     			<img class="proImg" src="${path }/resources/images/product/plus2.png">
								 <c:forEach var="th" items="${thumb }" begin="2" end="2">
									<c:if test="${not empty th.pdtThumbImage }">
										<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
									</c:if>
								</c:forEach>
							
								<input type="file" class="proPic" name="thumbImgs" id="input2" accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
							</div>
				     	</div>
				     	
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일4</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="4"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								 <c:forEach var="th" items="${thumb }" begin="3" end="3">
									<c:if test="${not empty th.pdtThumbImage }">
										<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
									</c:if>
								</c:forEach>
								<input type="file"  class="proPic" name="thumbImgs" id="input4"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일5</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="5"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								 <c:forEach var="th" items="${thumb }" begin="4" end="4">
									<c:if test="${not empty th.pdtThumbImage }">
										<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
									</c:if>
								</c:forEach>
								<input type="file"  class="proPic" name="thumbImgs" id="input5"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일6</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="6"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								 <c:forEach var="th" items="${thumb }" begin="5" end="5">
									<c:if test="${not empty th.pdtThumbImage }">
										<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
									</c:if>
								</c:forEach>
								<input type="file"  class="proPic" name="thumbImgs" id="input6"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			   		</div>
					</div> 
					
		      		<div id="detail-image">
			      		<p class="title">제품 상세 이미지(총 1장)</p>
			      		<input type="button" id="fileBtn" class="fileBtn" value="파일선택" >
			      		<label class="fileBtn" for="fileBtn">${product.pdtDetailImage}</label>
			      		<input type="file" id="detail" class="form-control-file border" name="detailImg" style="display:none;">
			     
		      		</div>
		      		<input type="hidden" name="pdtNo" value="${product.pdtNo }">
				
				
				<div id="bottom-btns">
					<input type="submit" class="btn btn-success insertPro" value="수정하기" onclick="updatePro()">
					<input type="button" class="btn btn-success insertPro" value="삭제하기" onclick="deletePro()">
					<input type="button" class="btn btn-success goList" onclick="location.href='${path}/admin/moveProduct'" value="목록">
				</div>
				
			</form>
				
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	//제품명 유효성 검사
	$("#name").focusout(function() {
		
		var name=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_, ]*$/;
		if(!name.test($("#name").val())){
	   		swal("제품명에 특수문자는 입력하실 수 없습니다.");
	   		$("#name").val('');
	   		return false;
	   	} 
	});
	
	//가격 유효성 검사
	$("#price").focusout(function() {
		
		var price=/^[0-9]*$/;
		if(!price.test($("#price").val())){
	   		swal("제품가격에 숫자 외에는 입력하실 수 없습니다.");
	   		$("#price").val('');
	   		return false;
	   	} 
	});
	//옵션내용 유효성 검사
	$("input[name=pdtOptionContent]").focusout(function() {
		
		var name=/^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9%()-_,* ]*$/;
		if(!name.test($("input[name=pdtOptionContent]").val())){
	   		swal("옵션명에 특수문자는 입력하실 수 없습니다.");
	   		$("#name").val('');
	   		return false;
	   	} 
	});
	//옵션가격 유효성 검사
	$("input[name=pdtOptionAddprice]").focusout(function() {
		
		var price=/^[-0-9]*$/;
		if(!price.test($("input[name=pdtOptionAddprice]").val())){
	   		swal("옵션 가격에 숫자 외에는 입력하실 수 없습니다.");
	   		$("#price").val('');
	   		return false;
	   	} 
	});
	//상세이미지 파일명 바꾸기
	$(function(){
    		$('[name=detailImg]').on("change",function(){
    		
    			var filename=$(this).prop('files')[0].name;
    			$(this).prev(".fileBtn").html(filename);
    		});
    	});
	//상세이미지 파일 업로드
	$("#fileBtn").on("click",e=>{
		$(e.target).next().next().click();
	});
		
	
	//제품 수정
	function updatePro(){
		/* //유효성검사-카테고리 및 판매상태
        if($("#category").val()==null){
        	swal("제품카테고리를 선택해주세요.");
        	return false;
        }
        if($("#status").val()==null){
        	swal("판매 상태를 선택해주세요.");
        	return false;
        }
        //파일 검사 안됨
        if($("input[name=thumbImgs]").val()==null){
        	alert("등록!");
        	swal("썸네일 사진을 하나 이상 등록해주세요.");
        	return false;
        }
        var s = document.getElementsById("tests");
        if(s.value==null){
        	alert("등록");
        	swal("제품 상세 사진을 등록해주세요.");
        	return false;
        } */
        
		if(confirm("정말 수정하시겠습니까?")==true){
			//옵션 값 넣기
			var list=[];
	        var items = document.getElementsByName("pdtOptionContent");
	        
	        for(var i=0; i<items.length; i++){
	            list.push({"pdtOptionContent":$("input[name=pdtOptionContent]").eq(i).val(),
	            	"pdtOptionAddprice":$("input[name=pdtOptionAddprice]").eq(i).val()});    
	        }
	        $("#test_list").val(JSON.stringify(list));
	        
			return true;
		}else{
			return false;
		}   
	}
	//제품 삭제
	function deletePro(){
		if(confirm("정말 삭제하시겠습니까?")==true){
	        location.href='${path}/admin/deleteProduct?pdtNo=${product.pdtNo}';
		}else{
			return false;
		}   
	}
	//간단한 설명 - 글자 수 제한
	$(document).ready(function(){
		$("#intro-text").on('keyup',function(){
			if($(this).val().length>65){
				$(this).val($(this).val().substring(0,65));
				swal("65자를 초과하였습니다.");
			}
		});
	});
	//옵션 추가하기 
	$("#add-option").click(function(){
		
		var addOption="";
        addOption+='<tr class="trOption" name="trOption">';
        addOption+='<th>&nbsp&nbsp옵션 내용</th>';
        addOption+='<td><input type="text" name="pdtOptionContent"></td>';
        addOption+='<th>추가 요금</th>';
        addOption+='<td><input type="text" name="pdtOptionAddprice">';
        addOption+='<button class="btn btn-success btn-sm delBtn2" name="delBtn">삭제</button></td>';
        addOption+='</tr>';

   		$("#insert-table").append(addOption);
	});
    
	//옵션 삭제 
	$(document).on("click","button[name=delBtn]",function(){

	    var trHtml=$(this).parent().parent();
	    trHtml.remove();
	});
	
	
	//이미지 업로드 
	$(function(){
		   //div 클릭시 파일업로드실행함수 실행
		   $("#1,#2,#3,#4,#5,#6").on("click",e=>{
			 
			   $(e.target).next().click();
		   });
		   //파일 업로드시 이미지 체인지
		   $("#input1,#input2,#input3,#input4,#input5,#input6").on("change",e =>{ 
			 
		      let reader=new FileReader();
		      
		      let img=  $(e.target).prev();
		      reader.onload=e=>{
		    	  img.attr("src",e.target.result); 
		      }
		      reader.readAsDataURL($(e.target)[0].files[0]);
		      console.log($(e.target)[0].files[0]);
		    
		   }); 
	});
	
	//이미지 삭제 버튼
	$(function(){
		$(".close").on("click",e=>{	  
			   let chImg=$(e.target).prev().prev();
			   chImg.attr("src","${path }/resources/images/product/plus2.png");
		   });
	});
</script>
	
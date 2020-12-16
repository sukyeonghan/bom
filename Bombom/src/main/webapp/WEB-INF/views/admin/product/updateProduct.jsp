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
    	border:1px solid black;
    	width:150px;
    	height:150px;
    	position:relative;
    	float:left;
    	background:url(${path }/resources/images/product/plus2.png);
    	background-size:100% 100%;
    	background-position:center;
    }
    label.form-control-file{
    	text-align:left;
    }
    label.test{
    	text-align:left;
    }
    .content{width:100%}
    .addprice{width:70%}
    .btnCss{margin-left:15px;}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>


<section id="container">
	<div id="flexDiv">
	
		<!--제품 관리 내비게이션바 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp"/>
		
		<div id="admin-container">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">제품수정</h3> 
			
			<!-- 제품 수정 -->
			<form action="${path }/admin/updateProductEnd" method="post" enctype="multipart/form-data">
				<table id="insert-table">
					<tr>
						<th>카테고리</th>
						<td>
						<!-- 검색 카테고리 -->
							<div class="select-box">
								<select class="sort" id="category" name="pdtCategory">
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
								<select class="sort" id="status" name="pdtStatus">
									<option value="Y" ${product.pdtStatus=='Y'?"selected":"" }>Y</option>
									<option value="N" ${product.pdtStatus=='N'?"selected":"" }>N</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td><input type="text" id="name" class="text" name="pdtName" value="${product.pdtName }" ></td>
						<th>제품기본가격</th>
						<td><input type="text" id="price" class="text" name="pdtPrice" value="${product.pdtPrice }" ></td>
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
											<option value="">이벤트 선택</option>
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
       							<td>
       								<input type="text" class="content" name="pdtOptionContent" value="${o.pdtOptionContent}">
       								<input type="hidden" name="optNo" value="${o.pdtOptionNo}">
       							</td>
        						<th>추가 요금</th>
        						<td>
        							<input type="text" class="addprice" name="pdtOptionAddprice" value="${o.pdtOptionAddprice }">
	        						<c:choose>
	        							<c:when test="${ o.pdtOptionStatus eq 'Y'}">
	        								<input type="button" class="btn btn-success btn-sm btnCss" name="optionStatus" value="품절" onclick="">
	        							</c:when>
	        							<c:otherwise>
	        								<input type="button" class="btn btn-success btn-sm btnCss" name="optionStatus" value="입고" onclick="">
	        							</c:otherwise>
									</c:choose>
	        						<input type="button" class="btn btn-success btn-sm btnCss" name="delBtn" value="삭제">
        						</td>
							</tr>
						</c:forEach>
					</c:if>	
                    
				</table>
				<input type="hidden" name="test" id="test_list">
				
				<!-- 제품 설명 -->
				<div id="middle-div">
					<p class="title" id="product-intro">간단한 제품 설명</p>
					<textarea id="intro-text" rows="5" cols="130" placeholder="65자 이내로 적어주세요" name="pdtIntro" required><c:out value="${product.pdtIntro }"/>
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
								<c:forEach var="th" items="${thumb }" begin="0" end="0">
									<c:if test="${not empty th.pdtThumbImage  }">
										<img class="proImg" src="${path }/resources/upload/product/${th.pdtThumbImage}">
									</c:if>
								</c:forEach>
								<input type="file" class="proPic" name="thumbImgs" id="input1"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
			     		</div>
			     				
			     		<div class="thumbWrap" > 
			     			<div>
			     				<p class="sumTitle">썸네일2</p>
			     			</div>
			     			<div class="proDiv" id="2">
			     				
				     			<c:forEach var="th" items="${thumb }" begin="1" end="1">
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
			     				<p class="sumTitle">썸네일3<c:out value="${th.pdtThumbImage}"/></p>
			     			</div>
				     		<div class="proDiv" id="3"> 
				     			
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
				     		<div class="proDiv" id="4"> 
								
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
				     		<div class="proDiv" id="5"> 
								
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
				     		<div class="proDiv" id="6"> 
								
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
			      		<input type="file" id="detail" class="form-control-file border" name="detailImg" accept="image/gif, image/jpeg, image/png" style="display:none;">
			     
		      		</div>
		      		<input type="hidden" name="pdtNo" value="${product.pdtNo }">
				
				
				<div id="bottom-btns">
					<input type="submit" class="btn btn-success insertPro" value="수정하기" onclick="return updatePro();">
					<input type="button" class="btn btn-success insertPro" value="삭제하기" onclick="deletePro()">
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
	    addOption+='<td><input type="text" class="content" id="content" name="pdtOptionContent"></td>';
	    addOption+='<th>추가 요금</th>';
	    addOption+='<td><input type="text" class="addprice" name="pdtOptionAddprice">';
	    addOption+='<button class="btn btn-success btn-sm delBtn2" name="delBtn">삭제</button></td>';
	    addOption+='</tr>';
	
	    $("#insert-table").append(addOption);
	});

	//옵션 품절,입고 상태 변경
	$("input[name=optionStatus]").on("click",e=>{
		var status=$(e.target).val();//'입고','품절'
		
		$.ajax({
			url:"${path}/admin/optionStatus",
			data:{status:status,optNo:$("input[name=optNo]").val()},
			dataType:"json",
			success:data=>{

				if(data===true){
					swal("옵션 상태가 변경되었습니다.");
					console.log($(e.target));
					console.log($(e.target).val());
					if($(e.target).val()=='입고'){
						$(e.target).attr('value','품절');
					}else{
						$(e.target).attr('value','입고');
					}
				}else{
					swal("옵션 상태 변경에 실패하였습니다.");
				}
			}
		});
	});
		
	
	
	//옵션내용 유효성 검사-따로 밖으로 뺌
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
	    //price=$("input[name=pdtOptionAddprice]").val();
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

	//사진 눌렀을 떄 다시 파일 업로드
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
	
	//제품 수정
	function updatePro(){
		
		if(confirm("정말 수정하시겠습니까?")==true){  
					
			//옵션 값 넣기
			var list=[];
		    var items = document.getElementsByName("pdtOptionContent");
		    
		    for(var i=0; i<items.length; i++){
		        list.push({"pdtOptionContent":$("input[name=pdtOptionContent]").eq(i).val(),
		        	"pdtOptionAddprice":$("input[name=pdtOptionAddprice]").eq(i).val()});    
		    }
		    var i=$("#test_list").val(JSON.stringify(list));
		    
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
		            
		            url:"${path}/admin/updateCheckPdtName",
		            data:{"pdtName":val,"pdtNo":'${product.pdtNo}'},
		            type:"get",
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
		    
		  	//간단한 설명 - 글자 수 제한
		    $(document).ready(function(){
		        $("#intro-text").on('keyup',function(){
		            if($(this).val().length>65){
		                $(this).val($(this).val().substring(0,65));
		                swal("65자를 초과하였습니다.");
		            }
		        });
		    });
	
		    
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
	    
	    
		} else {
			return false;
		}    
	}

	//제품 삭제
	function deletePro(){
		if(confirm("정말 삭제하시겠습니까?")==true){
	        location.href='${path}/admin/deleteProduct?pdtNo='+encodeURI('${product.pdtNo}');
		}else{
			return false;
		}   
	}
	
	//옵션 삭제
	function test(e){
		$(e).parent().parent().remove();
	}
	
	$("input[name=delBtn]").on("click",e=>{
		$.ajax({
			url:"${path}/admin/deleteOption",
			data:{pdtNo:'${product.pdtNo}'},
			success:data=>{
				console.log(data);
				if(data==1){
					test(e);
				}
			}
		})
	})
</script>

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
			
			<!-- 제품 등록 -->
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
       							<td><input type="text" class="content" name="pdtOptionContent" value="${o.pdtOptionContent}"></td>
        						<th>추가 요금</th>
        						<td>
        							<input type="text" class="addprice" name="pdtOptionAddprice" value="${o.pdtOptionAddprice }">
	        						<c:choose>
	        							<c:when test="${ o.pdtOptionStatus eq 'Y'}">
	        								<button class="btn btn-success btn-sm btnCss" name="">품절</button>
	        							</c:when>
	        							<c:otherwise>
	        								<button class="btn btn-success btn-sm btnCss" name="">입고</button>
	        							</c:otherwise>
									</c:choose>
	        						<button class="btn btn-success btn-sm btnCss" name="delBtn">삭제</button>
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
								<input type="file" class="proPic" name="thumbImgs" id="input1" accept="image/gif, image/jpeg, image/png" style="display:none;">
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
<script src="${path}/resources/js/updateProduct.js"></script>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>
//제품 삭제
	function deletePro(){
		if(confirm("정말 삭제하시겠습니까?")==true){
	        location.href='${path}/admin/deleteProduct?pdtNo='+encodeURI('${product.pdtNo}');
		}else{
			return false;
		}   
	}
	
	function test(e){
		$(e).parent().parent().remove();
	}
	
	$("button[name=delBtn]").on("click",e=>{
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

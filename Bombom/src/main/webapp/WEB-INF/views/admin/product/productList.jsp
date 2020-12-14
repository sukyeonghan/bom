<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
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
      	padding-right:60px;
   	}
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	
	/*상단 버튼 정렬*/
	.btns{
		display:flex;
		justify-content:space-between;
	}
	/*제품개수와 필터 정렬*/
	.count-filter{
		display:flex;
		justify-content:space-between;
	}
	/*제품 개수*/
	#count,.sort{
		margin:20px 0;
		font-size: 17px;
	}
	
	/*정렬*/
	.sort{
		border:none;
		outline:none;
	}
	/*선택삭제 버튼*/
	#selectDel{
		margin-left:5px;
	}
	
	/*상품 관리 테이블*/
	#product-table{
		width:100%;
		margin-bottom:20px;
		border-collapse: collapse;
		text-align:center;
		/* padding:5px; */
	}
	th{cursor: default;}
	td{vertical-align: middle; cursor:default;}
	td:nth-of-type(3){text-align:left;}
	td:nth-of-type(4){text-align:left;}
	td:nth-of-type(5){text-align:right;}

	/*상품 수정,삭제페이지로 넘어가는 a태그 */
	/*클릭 안 했을 때*/
	.product-update:link{
		text-decoration:none;
		color:#45A663;
	}
	/*방문했을 때*/
	.product-update:visited{
		text-decoration:none;
		color:#45A663;
	}
	/*마우스 올렸을 때*/
	.product-update:hover{
		text-decoration:none;
		color:black;
	}
	/*상품등록 버튼*/
	#insertPro{
		float:right;
	}
	/*페이지바*/
    .pageBar{
    	margin:5% 0;
    	text-align:center;
    }
    
    /*검색*/
    #search-wrap{
    	display: flex;
    	justify-content: center;
    	align-items: center;
    }
    #search-text{
    	margin:0 15px;
    }
    
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container">
	<div id="flexDiv">
	
		<!--관리자 내비게이션바 -->
		<jsp:include page="/WEB-INF/views/common/adminMenu.jsp"/>
		
		<div id="admin-container">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">제품목록</h3> 
		
			<div class="btns">
				<!-- 전체 선택, 선택 삭제 버튼 -->
				<div class="buttons">
					<button class="btn btn-success" id="selectAll" onclick="selectAll();">전체 선택</button>
					<button class="btn btn-success" id="selectDel" onclick="deletePro();">선택 삭제</button>
				</div>
				<!-- 제품등록 버튼 -->
				<div class="insertBtn">
					<button class="btn btn-success" id="insertPro" onclick="location.href='${path}/admin/productInsert'">제품 등록</button>
				</div>
			</div>		
			
			<div id="result">
			
				<div class="count-filter">
					<!-- 카테고리별 개수 -->
					<p id="count">총  ${count }개</p>
					<!--카테고리 정렬  -->
					<div class="select-box">
						<select class="sort">
							<option value="전체">전체보기</option>
							<option value="식품">식품</option>
							<option value="잡화">잡화</option>
							<option value="주방">주방</option>
							<option value="욕실">욕실</option>
							<option value="여성용품">여성용품</option>
							<option value="반려동물">반려동물</option>
						</select>
					</div>
				</div>
				
			
			
				<!-- 제품관리 테이블 -->
				<div id="product-table-wrap" >
					<table id="product-table" class="table table-hover">
						<tr>
							<th>선택</th>
							<th>카테고리</th>
							<th>상품명</th>
							<th>상품설명</th>
							<th>기본가격</th>
							<th>이벤트명</th>
							<th>옵션여부</th>
							<th>판매상태</th>
							<th>등록날짜</th>
						</tr>
						<c:if test="${not empty list}">
							<c:forEach var="e" items="${list }">
								<tr>
									<td>
										<input type="checkbox" name="check" value="check">
										<input type="hidden" name="delNum" value="${e.pdtNo }">	
									</td>
									<td><c:out value="${e.pdtCategory}"/></td>
									<td>
										<a class="product-update" href="${path}/admin/productUpdate?pdtNo=${e.pdtNo}">
											<c:out value="${e.pdtName}"/>
										</a>
									</td>
									<td>
										<c:choose>
											
											<c:when test="${fn:length(e.pdtIntro)>9}">
												<c:out value="${fn:substring(e.pdtIntro,0,8) }"/>...
											</c:when>
											<c:otherwise>
												<c:out value="${e.pdtIntro}"/>
											</c:otherwise>
										</c:choose>
										</td>
									<td>
										<fmt:formatNumber value="${e.pdtPrice}" />원
									</td>
									<td>
										<c:choose>
											<c:when test="${not empty e.eventNoRef }">
												<c:out value="${e.eventNoRef}"/>
											</c:when>
											<c:otherwise>
												N
											</c:otherwise>
										</c:choose>
									</td>
									<td>
										<c:choose>
											<c:when test="${not empty e.pdtOptionNo }">
												Y
											</c:when>
											<c:otherwise>
												N
											</c:otherwise>
										</c:choose>
									</td>
									<td><c:out value="${e.pdtStatus}"/></td>
									<td><fmt:formatDate value="${e.pdtDate}" pattern="yyyy-MM-dd"/></td>
									
								</tr>
							</c:forEach>
						</c:if>
					</table>
				
				</div>
			
				<!-- 페이징바 -->
				 <div class="pageBar" >	
					${pageBar }
				</div>
			</div>
			
			
			
			<!-- 검색 -->
			<div id="search-wrap">
				<!-- 검색 카테고리 -->
				<div class="select-box">
					<select class="sort">
						<option>상품명</option>
						<option>이벤트명</option>
					</select>
				</div>
				<input type="text" id="search-text" size="30">
				<button class="btn btn-success" id="search-btn">검색</button>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	
	//전체 선택
	var checkAll = "false";
	var items = document.getElementsByName("check");
	function selectAll() {
		
		if (checkAll == "false") {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = true;
			}
			checkAll = "true";
		} else {
			for (let i = 0; i < items.length; i++) {
				items[i].checked = false;
			}
			checkAll = "false";
		}
	}
	
	//선택 삭제
	function deletePro(){
		if(confirm("정말 삭제하시겠습니까?")==true){
			
			var list=new Array();   
	        for (var i=0; i<items.length; i++){
	        	var check=$("input[name=check]").eq(i);
	            if(check.is(":checked")){
	            	//체크 되어있으면 해당 제품번호를 list에 넣기
	 				check.next().each(function(index,item){
	    				list.push($(item).val());
	    			}); 
	            }
	        }
	        
	        location.href='${path}/admin/deleteSelect?pdtNo='+list;
		}else{
			return false;
		}
	    
	}
	
	
	$(".sort").on("change",e=>{
		console.log($(e.target).val());
		$.ajax({
			
			url:"${path}/admin/productListAjax",
			data:{"sort":$(e.target).val()},
			type:"get",
			dataType:"html",
			success:data=>{
				console.log(data);
				$("#result").html(data);
			}
		});
	});

</script>


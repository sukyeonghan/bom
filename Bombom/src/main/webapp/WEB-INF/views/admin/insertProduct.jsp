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
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
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
		width:100%;
		margin:20px 0;
		padding:5px;
	}
	tr,th,td{
	
		padding:15px;
	}
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
	
    /*상품 설명*/
    #product-intro{
    	font-weight:bold;
    }
    #intro-text{
    	resize:none;
    }
    #bottom-div{
    	margin-left:20px;
    }
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container" class="container">
	<div class="media">
	
		<!--관리자 내비게이션바 -->
		<div id="" class=" mr-3 admin-nav">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link non-select" href="${path }/">회원관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link select" href="${path }/">제품관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">주문관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">1:1문의관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">이벤트관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">커뮤니티관리</a>
		    </li>
		  </ul>
		</div>
		
		<div id="admin-container" class="media-body">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">제품등록</h3> 
			<!-- 제품 등록 -->
			<table id="insert-table">
				<tr>
					<th>카테고리</th>
					<td colspan="3">
					<!-- 검색 카테고리 -->
						<div class="select-box">
							<select class="sort">
								<option>카테고리 선택</option>
								<option>식품</option>
								<option>잡화</option>
								<option>주방</option>
								<option>욕실</option>
								<option>여성용품</option>
								<option>반려동물</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td><input type="text"></td>
					<th>상품가격</th>
					<td><input type="text"></td>
				</tr>
				<tr>
					<th>이벤트</th>
						<td>
						<!-- 이벤트 카테고리 -->
							<div class="select-box">
								<select class="sort">
									<option>이벤트 선택</option>
								
								</select>
							</div>
						</td>
					<th>판매 상태</th>
					<td>
						<!-- 판매상태 카테고리 -->
						<div class="select-box">
							<select class="sort">
								<option>판매상태 선택</option>
								<option>Y</option>
								<option>N</option>
							</select>
						</div>
					</td>
				</tr>
				<tr>
					<th>추가 옵션</th>
					<td colspan="3"><button class="btn btn-success">옵션 추가하기</button></td>
				</tr>	
			</table>
			
			<!-- 제품 설명 -->
			<div id="bottom-div">
				<p id="product-intro">간단한 제품 설명</p>
				<textarea id="intro-text" rows="5" cols="100"></textarea>
			</div>
			
			<!-- 제품 썸네일,상세 이미지 등록 -->
			<div></div>
			<div></div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
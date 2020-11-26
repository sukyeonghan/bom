<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	
	/*상단 버튼과 셀렉트 박스 정렬*/
	.btns-category,.select-box{
		display:flex;
		justify-content:space-between;
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
		border:1px solid black;
		margin:20px 0;
		border-collapse: collapse;
		text-align:center;
		padding:5px;
	}
	th,td{
		border:1px solid black;
		padding:5px;
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
	  /*페이지바*/
    .pagebar{
    	margin-top:100px;
    	text-align:center;
    }
    .pagebar a{
    	font-size:18px;
    	color:black;
    }
    .pagebar a:link{
    	text-decoration:none;
    	color:black;
    }
    .pagebar a:hover{
    	text-decoration:none;
    	color:#45A663;
    }
    
    /*검색*/
    #search-wrap{
    	display: flex;
    	justify-content: center;
    	align-items: center;
    	margin-top:20px;
    }
    #search-text{
    	margin:0 15px;
    }
    
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="이벤트" />
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
		      	<a class="nav-link select" href="${path }/admin/moveProduct">제품관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">주문관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">1:1문의관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/admin/event/moveEvent">이벤트관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">커뮤니티관리</a>
		    </li>
		  </ul>
		</div>
		
		<div id="admin-container" class="media-body">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">이벤트목록</h3> 
			<div class="btns-category">
				<!-- 전체 선택, 선택 삭제 버튼 -->
				<div class="buttons">
					<button class="btn btn-success" id="selectAll" onclick="selectAll();">전체 선택</button>
					<button class="btn btn-success" id="selectDel" onclick="">선택 삭제</button>
				</div>
				<!--카테고리 정렬  -->
				<div class="select-box">
					<select class="sort">
						<option>전체보기</option>
						<option>할인</option>
						<option>커뮤니티</option>
						<option>기타</option>
					</select>
				</div>
			</div>
			
			<!-- 관리 테이블 -->
			<div id="event-table-wrap">
				<table id="event-table" class="table table-hover">
					<tr>
						<th></th>
						<th>번호</th>
						<th>제목</th>
						<th>할인품목</th>
						<th>할인율</th>
						<th>이벤트기간</th>
						<th></th> <!-- 삭제버튼용 -->
					</tr>
					<c:forEach items="${list }" var="e">
					<tr>
						<td><input type="checkbox" name="check" value="check"></td>
						<td><p class="eventNo"><c:out value="${e.eventNo}"/></p></td>
						<td><c:out value="${e.eventTitle }" /></td>
						<td><a class="direct-product" href="${path}/product/productAll">상품명---</a></td>
						<td><c:out value="${e.eventSalePer }" />%</td>
						<td><fmt:formatDate value="${e.eventStartDate }" /> ~ <fmt:formatDate value="${e.eventEndDate }" /></td>
						<td><button id="event-delete" class="btn btn-sm btn-outline-danger" onclick="fn_delete('${e.eventNo}');">삭제</button></td>
					</tr>
						
					</c:forEach>
				</table>
				<button class="btn btn-success" id="" onclick="location.href='${path}/admin/insertEvent'">이벤트 등록</button>
			</div>
			
			<!-- 페이징바 -->
			 <div class="w3-center pagebar">	
				<div class="w3-bar">
					<a href="#" class="w3-button w3-hover-black"> < </a>
					<a href="#" class="w3-button w3-hover-black">1</a>
					<a href="#" class="w3-button w3-hover-black">2</a>
					<a href="#" class="w3-button w3-hover-black">3</a>
					<a href="#" class="w3-button w3-hover-black">4</a>
					<a href="#" class="w3-button w3-hover-black"> > </a>
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
				<input type="text" id="search-text">
				<button class="btn btn-success" id="search-btn">검색</button>
			</div>
			
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
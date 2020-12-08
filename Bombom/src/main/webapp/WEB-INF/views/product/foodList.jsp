<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
	/*내비바*/
	.product-nav{padding-right:100px;font-size: 18px;line-height: 1.8;}
	.product-nav ul{list-style:none;}
	.product-nav ul a{text-decoration: none;font-weight:bolder;}
	.product-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 ,최대 컨텐츠 크기,여백*/
   .media{min-width: 768px;max-width:1300px; margin: 0 80px;} 
	
	/*카테고리 및 필터*/
	.category-sort{
		display:flex;
		justify-content:space-between;
	}
	/*해당 페이지 카테고리*/
	.item-count{
		display:flex;
	}
	.category{
		font-weight:bold;
	}
	.count{
		color:#45A663;
		font-weight:bold;
	}
	/*정렬*/
	.sort{
		border:none;
		outline:none;
		
	}
	
	/*각 상품*/
	.item-wrap{
		margin:10px;
		width:23%;
	}
	/*이미지 크기*/
     .item-img{
        width:100%;
        height: 250px;
        margin-bottom:10px;
    }

    /*상품 설명*/
    .item-intro{
        text-align: center;
        width:100%;
    }
    /*상품명*/
	.title-link{
		color:black;
        font-weight: bold;
    }
    .title-link:hover{
    	color:#265c37;
        text-decoration: none;
        font-weight: bold;
    }
    
    /*가격 및 아이콘*/
	.sale{
    	color:rgb(170, 170, 170);
    	text-decoration: line-through;
	}
    .item-price,.item-icon{
        display: flex;
        justify-content: center;
        align-items: center;
        font-size:15px;
    }
    .item-icon{
    	font-size:13px;
    }
    .sale-price,.sale-icon,.soldout-icon{
        margin-left:5%;
    }
    .new-icon{
        background-color:#45A663;
        color: white;
        padding: 1px 5px;

    }
    .sale-icon{
        background-color:#e04545;
        color: white;
        padding: 1px 5px;
    }
    .soldout-icon{
    	background-color:gray;
        color: white;
        padding: 1px 5px;
    }
    /*페이지바*/
    .pagebar{
    	margin-top:100px;
    	color:black;
    }
    
    .pagebar a:hover{
    	text-decoration:none;
    	color:black;
    }
    
</style>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container" class="container-fluid">

	<div class="media">
		<!-- 상품 내비게이션바 -->
		<div class="product-nav mr-3" style="min-width: 210px;">
			<ul>
        		<li><a class="non-select" href="${path }/product/productAll">전체제품</a></li>
	        	<li><a class="select" href="${path }/product/food">식품</a></li>
          	 	<li><a class="non-select" href="${path }/product/stuff">잡화</a></li>
            	<li><a class="non-select" href="${path }/product/kitchen">주방</a></li>
            	<li><a class="non-select" href="${path }/product/bathroom">욕실</a></li>
            	<li><a class="non-select" href="${path }/product/woman">여성용품</a></li>
            	<li><a class="non-select" href="${path }/product/pet">반려동물</a></li>
            	<li><a class="non-select" href="${path }/product/sale">할인상품</a></li>
        	</ul>
		</div>
		
		<div class="media-body" style="max-width: 80%;">
			<!-- 카테고리 및 정렬 -->
			<div class="category-sort">
				<div class="item-count">
					<p class="category">식품 &nbsp </p>
					<p class="count"><c:out value="${count}"/></p>
				</div>
				<div class="select-box">
					<select class="sort">
						<option>등록순</option>
						<option>인기순</option>
						<option>낮은 가격순</option>
						<option>높은 가격순</option>
					</select>
				</div>
			</div>
		  	
		  	<!-- 상품목록 -->
		  	<div class="all-item-wrap"  style="display: flex;min-width: 80%;flex-wrap: wrap;">
		  		<c:choose>
		  			<c:when test="${empty list }">
		  				<c:out value="해당하는 제품이 없습니다."/>
		  			</c:when>
		  			<c:otherwise>
		  				<c:forEach var="p" items="${list }" >
		  					<div class="item-wrap">
				                <div>
				                    <a href="#">
				                    	
				                    	<c:choose>
				                    		<c:when test="${fn:contains(p.thumbs,',') }">
				                    			<c:set var="thumbs" value="${fn:split(p.thumbs,',') }"/> 
				                    			<c:forEach begin="0" end="0" var="th" items="${thumbs }" varStatus="v">
							                    	<img alt="" src="${path}/resources/upload/product/<c:if test='${v.count==1 }'>${th }</c:if>" class="item-img hover" style="display: inline;"
							                         >
							                         <input type="hidden" class="firstPic" value="<c:if test='${v.count==1 }'>${th }</c:if>">
							                    </c:forEach>
							                    <c:forEach begin="1" end="1" var="th" items="${thumbs }" varStatus="v">
							                         <input type="hidden" class="secondPic" value="<c:if test='${v.count==1 }'>${th }</c:if>">
							                    </c:forEach>
							                  	
				                    		</c:when>
				                    		<c:otherwise>
				                    			<c:forEach begin="0" end="0" var="th" items="${p.thumbs }" varStatus="v">
							                    	<img alt="" src="${path}/resources/upload/product/${th }" class="item-img" style="display: inline;">
							                    </c:forEach>
				                    		</c:otherwise>
				                    	</c:choose>
					                    
				                        
				                   	</a>
				                </div>
				                <div class="item-intro">
				                    
				                    <p class="item-title">
				                        <a class="title-link" href=""><c:out value="${p.pdtName }"/></a>
				                    </p>
				                    <div class="item-price">
				                        <p class="ori-price"><c:out value="${p.pdtPrice }"/>원</p>				
				                        <!-- 세일하면  위에도 sale class 추가-->	
				                        <!-- <p class="sale-price">7,200원</p> -->
				                    </div>
				                    <div class="item-icon">
				                    	<!-- 등록한 날짜로 부터 7일 -->
				                       <!--  <div class="new-icon">NEW</div> -->
				                        <!-- 세일하면 -->
				                       <!--  <div class="sale-icon">SALE</div> -->
				                        <!-- 판매상태가 N으로 바뀌면 -->	
				                      <!--   <div class="soldout-icon">SOLDOUT</div>	 -->			
				                    </div>
				                    
				                </div>
           					 </div>
		  				</c:forEach>
		  			</c:otherwise>
		  		</c:choose>
		  		
            </div>
           
		  </div>
		  
		  <!-- 페이징바 -->
		 <!-- <div class="w3-center pagebar">	
			<div class="w3-bar">
				<a href="#" class="w3-button w3-hover-black"> < </a>
				<a href="#" class="w3-button w3-hover-black">1</a>
				<a href="#" class="w3-button w3-hover-black">2</a>
				<a href="#" class="w3-button w3-hover-black">3</a>
				<a href="#" class="w3-button w3-hover-black">4</a>
				<a href="#" class="w3-button w3-hover-black"> > </a>
			</div>
		</div> -->
	</div>
</div>
		

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<script>

	//호버 시 메인 이미지 변경 
	$(function() { 
		
		$(".hover").hover(function(){ 
			// console.log("올림");
			$(this).attr("src", $(this).attr("src").replace($(this).next().val(), $(this).next().next().val())); 
	
		}, function(){ 
			//console.log("내림");
			$(this).attr("src", $(this).attr("src").replace($(this).next().next().val(), $(this).next().val())); 
		}); 
	});
</script>
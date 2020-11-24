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
	}
	/*이미지 크기*/
     .item-img{
        width:250px;
        height: 250px;
        margin-bottom:10px;
    }

    /*상품 설명*/
    .item-intro{
        text-align: center;
        width:250px;
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
        		<li><a class="select" href="${path }/product/productAll">전체상품</a></li>
	        	<li><a class="non-select" href="#">식품</a></li>
          	 	<li><a class="non-select" href="#">잡화</a></li>
            	<li><a class="non-select" href="#">주방</a></li>
            	<li><a class="non-select" href="#">욕실</a></li>
            	<li><a class="non-select" href="#">여성용품</a></li>
            	<li><a class="non-select" href="#">반려동물</a></li>
            	<li><a class="non-select" href="#">할인상품</a></li>
        	</ul>
		</div>
		
		
		
		<div class="media-body">
			<!-- 카테고리 및 정렬 -->
			<div class="category-sort">
				<div class="item-count">
					<p class="category">전체상품 &nbsp </p>
					<p class="count">4</p>
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
			<%-- <div class="card" style="width:200px">
  			<img class="card-img-top" src="${path }/resources/images/product/soap1.jpg" alt="Card image" width="200px">
  			<div class="card-img-overlay">
		    <h4 class="card-title">John Doe</h4>
		    <p class="card-text">Some example text.</p>
		    <a href="#" class="close" aria-label="Close""><span aria-hidden="true">&times;</span></a>
		    <button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		  	</div> --%>
		  	
		  	<!-- 상품목록 -->
		  	<div class="all-item-wrap"  style="display: flex;min-width: 1000px;">
		  	
		  		<div class="item-wrap">
                <div class="" >
                    <a href="#" class="">
                        <img alt="" src="${path}/resources/images/product/soap1.jpg" class="item-img" style="display: inline;"
                         onmouseout="this.src='${path}/resources/images/product/soap1.jpg'" onmouseover="this.src='${path}/resources/images/product/soap2.jpg'">
                   	</a>
                </div>
                <div class="item-intro">
                    
                    <p class="item-title">
                        <a class="title-link" href="">유기농 온몸비누 제주</a>
                    </p>
                    <div class="item-price">
                        <p class="ori-price sale">8,000원</p>					
                        <p class="sale-price">7,200원</p>
                    </div>
                    <div class="item-icon">
                        <div class="new-icon">NEW</div>
                        <div class="sale-icon">SALE</div>	
                      <!--   <div class="soldout-icon">SOLDOUT</div>	 -->			
                    </div>
                    
                </div>
            </div>
            
            <div class="item-wrap">
                <div class="" >
                    <a href="#" class="">
                        <img alt="" src="${path}/resources/images/product/som1.jpg" class="item-img" style="display: inline;"
                         onmouseout="this.src='${path}/resources/images/product/som1.jpg'" onmouseover="this.src='${path}/resources/images/product/som2.jpg'">
                   	</a>
                </div>
                <div class="item-intro">
                    
                    <p class="item-title">
                        <a class="title-link" href="">유기농 햄프코튼 재사용 화장솜</a>
                    </p>
                    <div class="item-price">
                        <p class="ori-price">12,000원</p>					
                      <!--   <p class="sale-price">7,200원</p> -->
                    </div>
                    <div class="item-icon">
                        <!--<span class="">NEW</span>-->
                        <div class="new-icon">NEW</div>
                       <!--  <div class="sale-icon">SALE</div> -->					
                    </div>
                    
                </div>
            </div>
            
             <div class="item-wrap">
                <div class="" >
                    <a href="#" class="">
                        <img alt="" src="${path}/resources/images/product/coffee1.jpg" class="item-img" style="display: inline;"
                         onmouseout="this.src='${path}/resources/images/product/coffee1.jpg'" onmouseover="this.src='${path}/resources/images/product/coffee2.jpg'">
                   	</a>
                </div>
                <div class="item-intro">
                    
                    <p class="item-title">
                        <a class="title-link" href="">유기농 재사용 커피필터</a>
                    </p>
                    <div class="item-price">
                        <p class="ori-price">4,000원</p>					
                       <!--  <p class="sale-price">7,200원</p> -->
                    </div>
                    <div class="item-icon">
                        <!-- <div class="new-icon">NEW</div>
                        <div class="sale-icon">SALE</div> -->					
                    </div>
                    
                </div>
            </div>
            
            <div class="item-wrap">
                <div class="" >
                    <a href="#" class="">
                        <img alt="" src="${path}/resources/images/product/woman1.jpg" class="item-img" style="display: inline;"
                         onmouseout="this.src='${path}/resources/images/product/woman1.jpg'" onmouseover="this.src='${path}/resources/images/product/woman2.jpg'">
                   	</a>
                </div>
                <div class="item-intro">
                    
                    <p class="item-title">
                        <a class="title-link" href="">유기농 순면생리대 누르.Nur</a>
                    </p>
                    <div class="item-price">
                        <p class="ori-price sale">7,500원</p>					
                        <p class="sale-price">6,750원</p>
                    </div>
                    <div class="item-icon">
                        <!-- <div class="new-icon">NEW</div>  -->
                        <div class="sale-icon">SALE</div>	
                        <div class="soldout-icon">SOLDOUT</div>				
                    </div>
                    
                </div>
            </div>
            
           
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
	</div>
</div>
		

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
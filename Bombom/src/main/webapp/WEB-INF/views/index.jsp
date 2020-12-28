<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${path }/resources/css/common/index.css">


<!-- swiper css -->
<style>
.swiper-container {
	height: 500px;
	width: 1000px;
	min-width: 550px;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	/* Center slide text vertically */
	display: -webkit-box;
	display: -ms-flexbox;
	display: -webkit-flex;
	display: flex;
	-webkit-box-pack: center;
	-ms-flex-pack: center;
	-webkit-justify-content: center;
	justify-content: center;
	-webkit-box-align: center;
	-ms-flex-align: center;
	-webkit-align-items: center;
	align-items: center;
}


</style>

<script>
    $(function () {
        $('#mainBanner').carousel({
            interval: 5000, //기본값 5000= 5초,false면 자동 순환하지 않는다.
            pause: "hover", // hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
        });
    })

</script>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="Welcome springAgain" />
</jsp:include>

<section id="container">
    <!-- 슬라이드 쇼 -->
    <div id="swiperWrap-container">
        <div id="mainBanner" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#mainBanner" data-slide-to="0" class="active"></li>
                <li data-target="#mainBanner" data-slide-to="1"></li>
                <li data-target="#mainBanner" data-slide-to="2"></li>
                <li data-target="#mainBanner" data-slide-to="3"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active banner_div">
                    <img class="banner_img" src="${path }/resources/images/main/banner/main-banner1.jpg" alt="First slide">
                    <div class="carousel-caption" style="left:-35%;">
                       <h3>제로웨이스터라고<br>당당하게 말하기</h3>
                        <p>Zerowaste<br>Passion Pack ~20%</p>
                    </div>
                </div>

                <div class="carousel-item  banner_div">
                    <img class="banner_img" src="${path }/resources/images/main/banner/main-banner2.jpg" alt="Second slide">
                    <div class="carousel-caption" style="left:-35%;">
                        <h3>여행도 쓰레기 없이.<br>제로웨이스트 어메니티.</h3>
                        <p>대나무치솔&고체치약</p>
                    </div>
                </div>
                <div class="carousel-item  banner_div">
                    <img class="banner_img" src="${path }/resources/images/main/banner/main-banner3.jpg" alt="Third slide">
                    <div class="carousel-caption " style="left:-35%;">
                        <h3>영수증 안주셔도 되요<br>현명하게 거절하기</h3>
                        <p>제로 웨이스트 치어링 스티커팩</p>
                    </div>
                </div>
                <div class="carousel-item  banner_div">
                    <img class="banner_img" src="${path }/resources/images/main/banner/main-banner4.jpg" alt="Third slide">
                    <div class="carousel-caption " style="left:-35%;">
                        <h3>우리가 해야 할<br>미세플라스틱 없는<br>진짜 설거지,</h3>
                        <p>다시:봄 주방비누</p>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#mainBanner" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </a>
            <a class="carousel-control-next" href="#mainBanner" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
            </a>
        </div>
    </div>
    <!-- 슬라이드 쇼 끝 -->

<script>
	$(function () {
	    //메인배너 이미지크기 맞추기
	    var banners = $('.banner_div');
	    
	    for (var i = 0; i < banners.length; i++) {
	        var banner = banners[i];
	        var bannerAspect = banner.offsetHeight / banner.offsetWidth;
	        banner.style.overflow = 'hidden';
	
	        var img = banner.querySelector('.banner_img');
	        var imgAspect = img.height / img.width;
	
	        if (imgAspect >= bannerAspect) {
	        	 // 이미지가 div보다 세로가 더 길 경우 가로를 div에 맞추고 세로를 잘라낸다
	            var imgHeightActual = div.offsetWidth * imgAspect;
	            var imgHeightToBe = div.offsetWidth * bannerAspect;
	            var marginTop = Math.round((imgHeightActual - imgHeightToBe) / 2);
	            img.style.cssText = 'width: 100%; height: auto; margin-left:0;'
	        	
	        	
	            
	        } else {
	        	//이미지가 banner보다 가로가 더 길 경우 세로를 banner에 맞추고 가로는 잘라냄.
	            var imgWidthActual = banner.offsetHeight / imgAspect;
	            var imgWidthToBe = banner.offsetHeight / bannerAspect;
	            var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2);
	            img.style.cssText = 'width: auto; height: 100%; margin-left: ' + marginLeft + 'px;'
	            console.log(img);
	        }
	    }
	})
 	
</script>

    

    <!-- 상품 카테고리 홍보 section -->
    <div id="productAd-container" class="container">
    <div class="wrapper">
	    <div class="">
	        <a href="#"><img class="productAd" src="${path }/resources/images/main/productCategory/전체상품.png" alt=""></a>
	        <div id="productAd-text">
	            <h4>전체상품</h4>
	            <a href="#">GO</a>
	        </div>
	    </div>
	    <div class="">
	        <a href="#"><img class="productAd" src="${path }/resources/images/main/productCategory/일상에서.jpg" alt=""></a>
	        <div id="productAd-text">
	            <h4>일상에서</h4>
	            <a href="#">GO</a>
	        </div>
	    </div>
	
	    <div class="">
	        <a href="#"><img class="productAd" src="${path }/resources/images/main/productCategory/욕실에서.jpg" alt=""></a>
	        <div id="productAd-text">
	            <h4>욕실에서</h4>
	            <a href="#">GO</a>
	        </div>
	    </div>
	    <div class="">
	        <a href="#"><img class="productAd" src="${path }/resources/images/main/productCategory/여행갈때.jpg" alt=""></a>
	        <div id="productAd-text">
	            <h4>여행갈때</h4>
	            <a href="#">GO</a>
	        </div>
	    </div>
	    <div class="">
	        <a href="#"><img class="productAd" src="${path }/resources/images/main/productCategory/사무실에서.png" alt=""></a>
	        <div id="productAd-text">
	            <h4>사무실에서</h4>
	            <a href="#">GO</a>
	        </div>
	    </div>
	    <div class="">
	        <a href="#"><img class="productAd" src="${path }/resources/images/main/productCategory/부엌에서.jpg" alt=""></a>
	        <div id="productAd-text">
	            <h4>부엌에서</h4>
	            <a href="#">GO</a>
	        </div>
	    </div>
    </div>
    </div>
    <!-- 상품 카테고리 홍보 끝 -->

    <!-- 제품추천 슬라이드 -->
    <div id="BestProduct-container" class="container-fluid">
        <div class="d-flex">
            <div id="BestProduct-title" class="">
                <h3>Best Product</h3>
                <h2>베스트제품</h2>
                <div id="BestProduct-href">
                    <!-- 제품 탭으로 이동 -->
                    <a href="#">확인하러 가기</a>
                </div>
            </div>
            <div id="BestProduct-list" class="">
                <!-- Swiper -->
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="col-md-4">
								<a href="#"><img class="productAd"
									src="${path }/resources/images/main/productCategory/전체상품.png"
									alt=""></a>
								<div id="BestProduct-text">
									<h4>전체상품</h4>
									<a href="#">GO</a>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="col-md-4">
								<a href="#"><img class="productAd"
									src="${path }/resources/images/main/productCategory/전체상품.png"
									alt=""></a>
								<div id="BestProduct-text">
									<h4>전체상품</h4>
									<a href="#">GO</a>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="col-md-4">
								<a href="#"><img class="productAd"
									src="${path }/resources/images/main/productCategory/전체상품.png"
									alt=""></a>
								<div id="BestProduct-text">
									<h4>전체상품</h4>
									<a href="#">GO</a>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="col-md-4">
								<a href="#"><img class="productAd"
									src="${path }/resources/images/main/productCategory/전체상품.png"
									alt=""></a>
								<div id="BestProduct-text">
									<h4>전체상품</h4>
									<a href="#">GO</a>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="col-md-4">
								<a href="#"><img class="productAd"
									src="${path }/resources/images/main/productCategory/전체상품.png"
									alt=""></a>
								<div id="BestProduct-text">
									<h4>전체상품</h4>
									<a href="#">GO</a>
								</div>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="col-md-4">
								<a href="#"><img class="productAd"
									src="${path }/resources/images/main/productCategory/전체상품.png"
									alt=""></a>
								<div id="BestProduct-text">
									<h4>전체상품</h4>
									<a href="#">GO</a>
								</div>
							</div>
						</div>
					</div>
					<!-- Add Pagination -->
					<!-- <div class="swiper-pagination"></div> -->
					<!-- Add Arrows -->
					<div class="swiper-button-next"></div> 
					<div class="swiper-button-prev"></div> 
				</div>


				<!-- Initialize Swiper -->
                <script>
					var swiper = new Swiper('.swiper-container',
						{
							speed: 1000,
							slidesPerView : 4,
							spaceBetween : 30,
							slidesPerGroup : 2,
							loop : true,
							loopFillGroupWithBlank : true,
							pagination : {
								//el : '.swiper-pagination',
								//clickable : true,
							},
							navigation : {
								nextEl : '.swiper-button-next',
								prevEl : '.swiper-button-prev',
							},
							autoplay : {
								delay : 3000,
							},
						/* mousewheel: {
						    invert: true,
						}, */
					});
				</script>

            </div>
        </div>
    </div>

</section>


<jsp:include page="/WEB-INF/views/common/footer.jsp" />
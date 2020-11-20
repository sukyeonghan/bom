<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

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

<jsp:include page="/WEB-INF/views/common/header.jsp" >
	<jsp:param name="title" value="Welcom springAgain" />
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
                    <div class="carousel-item active">
                        <img class="d-block w-100" src="${path }/resources/images/main/banner/main-banner1.jpg" alt="First slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="${path }/resources/images/main/banner/main-banner2.jpg" alt="Second slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="${path }/resources/images/main/banner/main-banner3.jpg" alt="Third slide">
                    </div>
                    <div class="carousel-item">
                        <img class="d-block w-100" src="${path }/resources/images/main/banner/main-banner4.jpg" alt="Third slide">
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

        <!-- 상품 카테고리 홍보 section -->
        <div id="productAd-container" class="container term">
            <div class="row">
                <div class="col-4">
                    <a href="#"><img class="productAd" src="${path }/resources/images/main/productCategory/전체상품.png" alt=""></a>
                    <div id="productAd-text">
                        <h4>전체상품</h4>
                        <a href="#">GO</a>
                    </div>

                </div>
                <div class="col-4">
                    <img class="productAd" src="${path }/resources/images/main/productCategory/일상에서.jpg" alt="">
                    <div id="productAd-text">
                        <h4>일상에서</h4>
                        <a href="#">GO</a>
                    </div>
                </div>

                <div class="col-4">
                    <img class="productAd" src="${path }/resources/images/main/productCategory/욕실에서.jpg" alt="">
                    <div id="productAd-text">
                        <h4>욕실에서</h4>
                        <a href="#">GO</a>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-4">
                    <img class="productAd" src="${path }/resources/images/main/productCategory/여행갈때.jpg" alt="">
                    <div id="productAd-text">
                        <h4>여행갈때</h4>
                        <a href="#">GO</a>
                    </div>
                </div>
                <div class="col-4">
                    <img class="productAd" src="${path }/resources/images/main/productCategory/사무실에서.png" alt="">
                    <div id="productAd-text">
                        <h4>사무실에서</h4>
                        <a href="#">GO</a>
                    </div>
                </div>
                <div class="col-4">
                    <img class="productAd" src="${path }/resources/images/main/productCategory/부엌에서.jpg" alt="">
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
            <div class="media">
                <div id="BestProduct-title" class="mr-3">
                    <h3>Best Product</h3>
                    <h2>베스트제품</h2>
                    <div id="BestProduct-href">
                        <!-- 제품 탭으로 이동 -->
                        <a href="#">확인하러 가기</a>
                    </div>
                </div>
                <div id="BestProduct-list" class="media-body">
                    <!-- Swiper -->
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <div class="swiper-slide">
                                <div class="col-md-4">
                                    <a href="#"><img class="productAd" src="피그마이미지/제품홍보배너/전체상품.png" alt=""></a>
                                    <div id="productAd-text">
                                        <h4>전체상품</h4>
                                        <a href="#">GO</a>
                                    </div>
                                </div>
                            </div>
                            <div class="swiper-slide">Slide 2</div>
                            <div class="swiper-slide">Slide 3</div>
                            <div class="swiper-slide">Slide 4</div>
                            <div class="swiper-slide">Slide 5</div>
                            <div class="swiper-slide">Slide 6</div>
                        </div>
                        <!-- Add Pagination -->
                        <!-- <div class="swiper-pagination"></div> -->
                        <!-- Add Arrows -->
                        <!-- <div class="swiper-button-next"></div> -->
                        <!-- <div class="swiper-button-prev"></div> -->
                    </div>


                    <!-- Initialize Swiper -->
                    <script>
                        var swiper = new Swiper('.swiper-container', {
                        	slidesPerView: 3,
                            spaceBetween: 30,
                            slidesPerGroup: 2,
                            loop: true,
                            loopFillGroupWithBlank: true,
                            pagination: {
                                el: '.swiper-pagination',
                                clickable: true,
                            },
                            navigation: {
                                nextEl: '.swiper-button-next',
                                prevEl: '.swiper-button-prev',
                            },
                            autoplay: {
                                delay: 3000,
                            },
                            mousewheel: {
                                invert: true,
                            },
                        });
                    </script>

                </div>
            </div>
        </div>

    </section>

    
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
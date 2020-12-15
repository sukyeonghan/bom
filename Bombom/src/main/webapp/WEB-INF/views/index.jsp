<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="${path }/resources/css/common/index.css">


<!-- swiper css -->
<style>
#mainBanner_swiper .swiper-container {
	width: 100%;
	height: 100%;
	margin-left: auto;
	margin-right: auto;
}

#BestProduct-list .swiper-container {
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

.swiper-slide .title {
	font-size: 41px;
	font-weight: 300;
}

.swiper-slide .subtitle {
	font-size: 21px;
}

.swiper-slide .text {
	font-size: 14px;
	max-width: 400px;
	line-height: 1.3;
}
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="Welcome springAgain" />
</jsp:include>

<section id="container">
	<!-- 슬라이드 쇼-height400px -->
	<div id="mainBanner_swiper">
		<!-- Swiper -->
		<div class="swiper-container first-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<!--swiper-wrap : 이미지와 텍스트를 감싸는 div-->
					<div class="swiper-wrap" id="customSection">
						<img class="banner_img"
							src="${path }/resources/images/main/banner/main-banner1.jpg">
						<!--innerText : 텍스트와 버튼을 감싸는 div -->
						<div class="innerText">
							<!-- introText : 소개글 div -->
							<div class="introText" id="customIntro">
								<p class="introSubject">
									<strong>ㅋㅋㅋㅋㅋㅋ</strong>
								</p>
								<p>ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</p>
							</div>
						</div>
					</div>
				</div>
				</div>
				<c:forEach items="">
					<div class="swiper-slide">Slide 2</div>
				</c:forEach>
			</div>
			<!-- Add Pagination -->
			<div class="swiper-pagination"></div>
			<!-- Add Arrows -->
			<div class="swiper-button-next"></div>
			<div class="swiper-button-prev"></div>
		</div>
	</div>

	<!-- Swiper JS -->
	<script src="../package/swiper-bundle.min.js"></script>

	<!-- Initialize Swiper -->
	<script>
		var swiper = new Swiper('.first-container', {
			slidesPerView : 1,
			spaceBetween : 30,
			speed: 600,
		    parallax: true,
			loop : true,
			pagination : {
				el : '.swiper-pagination',
				clickable : true,
			},
			navigation : {
				nextEl : '.swiper-button-next',
				prevEl : '.swiper-button-prev',
			},
		});
	</script>



	<script type="text/javascript">
		/* $(function () {
			//메인배너 이미지크기 맞추기
		    var banners = $('.banner_div'); //이미지감싸는 배너 불러오기
		    for (var i = 0; i < banners.length; i++) {
		        var banner = banners[i];
		        var bannerAspect = banner.offsetHeight / banner.offsetWidth;//배너크기
		        banner.style.overflow = 'hidden';//넘어가는 이미지 숨기기
		        var img = banner.querySelector('.banner_img');//이미지가져오기
		        var imgAspect = img.height / img.width;//이미지크기
		        if (imgAspect <= bannerAspect) {
		            //이미지가 banner보다 가로가 더 길 경우 세로를 banner에 맞추고 가로는 잘라냄.
		            var imgWidthActual = banner.offsetHeight / imgAspect;
		            var imgWidthToBe = banner.offsetHeight / bannerAspect;
		            var marginLeft = -Math.round((imgWidthActual - imgWidthToBe) / 2); //소수점반올림
		            img.style.cssText = 'width: auto; height: 100%; margin-left: ' + marginLeft + 'px;'
		        } else {
		            // 이미지가 banner보다 세로가 더 길 경우 가로를 div에 맞추고 세로를 잘라낸다
		            //var imgHeightActual = banner.offsetWidth / imgAspect;
		            //var imgHeightToBe = banner.offsetWidth / bannerAspect;
		            //var marginTop = -Math.round((imgHeightActual - imgHeightToBe) / 2);
		            img.style.cssText = 'width: 100%; height: auto; margin-left:0;'
		        }
		    }
		}) */
	</script>

	<!-- 상품 카테고리 홍보 section -->
	<div id="productAd-container" class="container term">
		<div id="productAd-container_three">
			<div class="term">
				<a href="${path }/product/productAll"><img class="productAd"
					src="${path }/resources/images/main/productCategory/전체상품.png"
					alt=""></a>
				<div id="productAd-text" class="justify-content-between">
					<div>
						<h4>전체상품</h4>
					</div>
					<div class="">
						<a href="${path }/product/productAll">GO</a>
					</div>
				</div>

			</div>
			<div class="term">
				<a href="${path }/product/productAll"> <img class="productAd"
					src="${path }/resources/images/main/productCategory/일상에서.jpg"
					alt=""></a>
				<div id="productAd-text">
					<h4>일상에서</h4>
					<a href="#">GO</a>
				</div>
			</div>

			<div class="term">
				<a href="${path }/product/productAll"> <img class="productAd"
					src="${path }/resources/images/main/productCategory/욕실에서.jpg"
					alt=""></a>
				<div id="productAd-text">
					<h4>욕실에서</h4>
					<a href="#">GO</a>
				</div>
			</div>
		</div>
		<div id="productAd-container_three">
			<div class="term">
				<a href="${path }/product/productAll"> <img class="productAd"
					src="${path }/resources/images/main/productCategory/여행갈때.jpg"
					alt=""></a>
				<div id="productAd-text">
					<h4>여행갈때</h4>
					<a href="#">GO</a>
				</div>
			</div>
			<div class="term">
				<a href="${path }/product/productAll"> <img class="productAd"
					src="${path }/resources/images/main/productCategory/사무실에서.png"
					alt=""></a>
				<div id="productAd-text">
					<h4>사무실에서</h4>
					<a href="#">GO</a>
				</div>
			</div>
			<div class="term">
				<a href="${path }/product/productAll"> <img class="productAd"
					src="${path }/resources/images/main/productCategory/부엌에서.jpg"
					alt=""></a>
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
				<div class="swiper-container ad-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="col-md-4">
								<a href="#"><img class="productAd" src="" alt=""></a>
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
					<div class="swiper-pagination"></div>
					<!-- Add Arrows -->
					<!-- <div class="swiper-button-next"></div> -->
					<!-- <div class="swiper-button-prev"></div> -->
				</div>


				<!-- Initialize Swiper -->
				<script>
					var swiper = new Swiper('.ad-container', {
						slidesPerView : 3,
						spaceBetween : 30,
						slidesPerGroup : 2,
						loop : true,
						loopFillGroupWithBlank : true,
						pagination : {
							el : '.swiper-pagination',
							clickable : true,
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
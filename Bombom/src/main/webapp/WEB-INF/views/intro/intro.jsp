<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=792123d3de9502373d63c6793c179d1b"></script>
<style>
.first-intro, .sub-content {
	line-height: 1.8;
}

.sub-content{
	font-size:17px;
}
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #45A663;background: #45A663 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}

.margin7{
	margin-left:7%;
}

</style>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container">
	<div class="container" >
		<div class="row">
			<!-- 소개 타이틀 -->
			<div class="col-md-4" >
				<h3 class="font-weight-bold">
					&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
					건강한 소비가 만드는</h3>
				<h3 class="font-weight-bold text-right">건강한 지구</h3>
			</div>
			<!-- 소개 내용 -->
			<div class="col-md-8">
				<div>
					<br> <br> <br> <br> <br> <br> <br>
					<h5 class="first-intro ">
						다시:봄은 쓰레기없는 삶의 방식을 제안합니다.<br> 환경과 동식물 모두에게 친환경적인 제품을 소개하고
						불필요한 포장을 줄입니다.<br> 또한‘오늘:해봄’커뮤니티를 통해 고객과 함께 실천해 나가고자 합니다.<br>
					</h5>
				</div>
			</div>
		</div>
		<br> <br> <br>
		
		<!-- 소개 세부내용 -->
		<div class="media margin7">
			<img class="align-self-center mr-3"
				src="${path }/resources/images/intro/sprout.png" width="55px">
			<div class="media-body" style="margin: 0 5% 0 10%">
				<h5 class="sub-title font-weight-bold">소재에 대한 고민</h5>
				<br>
				<p class="sub-content">플라스틱은 가볍고 저렴한 소재이지만 환경에는 치명적인 소재입니다.
					다시:봄에서는 천연소재의 제품, 생분해성 소재 및 재활용 플라스틱 제품 등 플라스틱을 대체할 수 있는 다양한 제품을
					소개합니다.</p>
			</div>
		</div>
		<br> <br>

		<div class="media margin7">
			<img class="align-self-center mr-3"
				src="${path }/resources/images/intro/save.png" width="55px">
			<div class="media-body" style="margin: 0 5% 0 10%">
				<h5 class="sub-title font-weight-bold">모두에게 안전한 제품</h5>
				<br>
				<p class="sub-content">사람뿐만 아니라 모든 동식물이 행복한 지구를 꿈꿉니다. 제작과정에서 환경
					훼손을 최소화한 제품, 동물실험을 하지 않은 제품, 유해한 성분없는 제품을 소개하고자 합니다.</p>
			</div>
		</div>
		<br> <br>

		<div class="media margin7">
			<img class="align-self-center mr-3"
				src="${path }/resources/images/intro/recycle.png" width="55px">
			<div class="media-body" style="margin: 0 5% 0 10%">
				<h5 class="sub-title font-weight-bold">플라스틱 없는 배송</h5>
				<br>

				<p class="sub-content">종이 대체품 또는 재사용 택배 박스로 배송이 됩니다. 플라스틱을 사용하지
					않아도, 과도하게 포장재를 사용하지 않아도 안전하게 배송되도록 노력하고 있습니다.</p>
			</div>
		</div>
		<br> <br> <br>
		
		<!--지점 사진  -->
		<!-- <div class="container-fluid"> -->
		<div class="row">
			<div class="col-md-12">
				<img class="img-fluid"
					src="${path }/resources/images/intro/shop3.jpg">
			</div>
		</div>
		<br> <br> <br>
	
		<!-- 엣헴이 소개 -->
		<div class="media " style=" margin-left:32%;">
			<img class=" mr-3" src="${path }/resources/images/intro/mascot.png"
				width="130px">
			<div class="media-body">
				<p style="font-size:18px;">
					<br>다시:봄의 마스코트, <br>
					<mark>엣헴이</mark>
					와 함께 합니다.<br> 다시:봄에서 지켜내고자 하는 <br> 모든 동식물 및 환경을 대표합니다.
				</p>
			</div>
		</div>
		<br> <br> <br>
		
		<div class="media" style="margin-left: 10%">
			
			<!-- 지도 API적용 -->
			<div id="map" class="mr-6" style="width:550px;height:400px;"></div>
			
			<!-- 운영시간, 위치 설명 -->
			<div class="media-body align-self-center" style="margin: 0 5% 0 10%">
				<h5 class="sub-title font-weight-bold">
					<img src="${path }/resources/images/intro/clock.png" style="width:25px">
					운영시간</h5>
				<br>
				<p class="sub-content"> 
					평일 : 10:00~21:00<br>
					주말,공휴일 : 10:00~22:00<br>
					(월요일 휴무)
				</p>
				<br>
				<h5 class="sub-title font-weight-bold">
					<img src="${path }/resources/images/intro/placeholder.png " style="width:25px">
					위치</h5>
				<br>
				<p class="sub-content"> 
					서울시 성동구 왕십리로 115,<br>
					헤이그라운드 1층(서울숲점)
				</p>
			</div>
		</div>
	</div>

</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>

	//지도 API
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    	mapOption = { 
        center: new kakao.maps.LatLng(37.54794198339092, 127.04415298640215), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };
	//지도 생성
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
	//var mapTypeControl = new kakao.maps.MapTypeControl();
	
	// 지도에 컨트롤을 추가
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치, TOPRIGHT는 오른쪽 위
	//map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
	var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
	var imageSrc = '${path }/resources/images/intro/mascot2.png', // 마커이미지의 주소    
		imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기
		imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정.
	  
	// 마커이미지 생성
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
		markerPosition = new kakao.maps.LatLng(37.54794198339092, 127.04415298640215); // 마커가 표시될 위치입니다
	
	//마커를 생성
	var marker = new kakao.maps.Marker({
		position: markerPosition, 
		image: markerImage, // 마커이미지 설정 
		clickable: true
	});
	
	//마커가 지도 위에 표시되도록 설정
	marker.setMap(map); 
	
	// 커스텀 오버레이
	var content = '<div class="customoverlay">' +
	    '  <a href="https://place.map.kakao.com/1030330263" target="_blank">' +
	    '    <span class="title">다시 : 봄</span>' +
	    '  </a>' +
	    '</div>';

	// 커스텀 오버레이가 표시될 위치
	var position = new kakao.maps.LatLng(37.54794198339092, 127.04415298640215);  

	// 커스텀 오버레이를 생성
	var customOverlay = new kakao.maps.CustomOverlay({
	    map: map,
	    position: position,
	    content: content,
	    yAnchor: 1 
	});
</script>



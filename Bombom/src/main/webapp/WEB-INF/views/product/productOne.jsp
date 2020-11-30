<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp" >
   <jsp:param name="title" value="" />
</jsp:include>
<style>
    /* 바로가기 이동 */
    a:link {
        color: black;
        text-decoration: none;
    }

    a:visited {
        color: black;
        text-decoration: none;
    }

    a:hover {
        color: #45A663;
        text-decoration: none;
    }
    
   	/* 글씨크기 조정 스타일 */ 
	.information{
		padding:4px;
		font-size:15px;
	}
	.size-up{
		font-size:23px;
	}
	.size-mid{
		font-size:17px;
	}    

    /* 썸네일 이미지 */
    .goods_thumbs_image ul {
        padding: 0;
        list-style: none;
        margin-bottom: 0;
    }
    .goods_thumbs_image ul li {
        /* border: 1px blueviolet solid; */
        float: left;
        /* padding-right: 7px; */
        padding:0 4px 0 0px;
        /* width: 100%;
        height: 100%; */
        display: inline-block;
        cursor: pointer;
    }
    .goods_thumbs_image ul li img{
        width:100%;
       /*  height:100%; */
        object-fit: contain;
    }
    .goods_thumbs_image ul li img:focus{
        border: 1px black solid;
    }
	
    /*셀렉트박스 디자인*/
    .optionChoice {
        width: 100%;
        height: 45px;
        display: inline-block;
        background-color: #fff;
        border-radius: 4px;
        border: #28a745 1px solid;
        transition: all .5s ease;
        position: relative;
        cursor:pointer;
    }
    .optionChoice .select {
        cursor: pointer;
        padding: 10px;
        -webkit-appearance: none;
        /* 네이티브 외형 감추기 */
        -moz-appearance: none;
        appearance: none;
    }
    .optionChoice .dropdown-menu {
        position: absolute;
        background-color: #fff;
        text-align: left;
        width: 100%;
        border-radius: 0 0 4px 4px;
        border: #28a745 1px solid;
        overflow: hidden;
        display: none;
        overflow-y: auto;
    }
    .optionChoice .dropdown-menu li {
        padding: 10px;
        transition: all .2s ease-in-out;
        cursor: pointer;
    }
    .optionChoice .dropdown-menu {
        padding: 0;
        list-style: none
    }
    .optionChoice .dropdown-menu li:hover {
        color: #28a745;
    }
    .optionChoice .dropdown-menu li:active {
        background-color: #28a745;
    }	
 
    /*수량 스타일*/
    #info_count {
        border: #28a745 1px solid;
        width: 100%;
        height: 100px;
    }    
    .input_count {
        border: #28a745 1px solid;
        background-color: #fff;
        color: 00000;
        width: 26px;
        font-size: 13px;
        display: table-cell;
        vertical-align: middle;
        text-align: center;
    }
    .input_count2 {
        border: #28a745 1px solid;
        background-color: #fff;
        color: 00000;
        width: 26px;
        font-size: 13px;
        display: table-cell;
        vertical-align: middle;
        text-align: center;
    }
    
    /* 버튼 크기 조절 */
    .custom{
    	width:163px !important;
    }
    
    /* 네비바 스타일 */
    button {
        background: none;
        border: 0;
        outline: 0;
        cursor: pointer;
    }

    button:focus {
        border: none;
        outline: none;
    }

    .tab_menu_container {
        text-align: center;
        padding-top: 80px;
    }

    .tab_menu_btn {
        width: 200px;
        height: 40px;
        transition: 0.3s all;
    }

    .tab_menu_btn.on {
        border-bottom: 1px solid #45A663;
        color: #45A663;
    }

    .tab_menu_btn:hover {
        color: #45A663;
    }

    .tab_box {
        display: none;
        padding: 25px;
    }

    .tab_box.on {
        display: block;
    }
    .tab_box img{
        width:100%;
    }
    
    /* 배송 안내사항 */
    #information p{
        font-size:12px;
    }   
    
    /* 연관상품 스와이프 css */
    .swiper-container {
    	/* width:1100px; */
    	width:100%;
        height: 300px;
    }
    .swiper-slide {
        font-size: 13px;
        background: #fff;
        border:#45A663 1px solid;

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
    .swiper-slide img{
        /* 이미지 최대너비 제한 */
        max-width:100%;
        max-height:100%; 
        object-fit: contain;
    }
    .slideImg{
    	padding-top:10px;
    }
    
    
    /*상품문의 박스 스타일*/
    div.wrap-category{
        margin: 7px 0px 7px 0px;
        text-align: left;
    }
    .span_textarea{
        position:relative;
        padding:8px;
        width:auto;
        border:lightslategray 1px solid;
        border-radius: 4px;
        display: inline-block;
        width:100%;
        height:250px;
    }
    textarea{
        width: 99%;
        height: 80%;
        resize: none;
        border:none;
    }
    textarea:focus{
        outline:none;
    }            
        
</style>

<section id="container" class="container">
    <h5><small><a href="${path}">홈</a> > <a href="${path}/product/productAll">제품</a> > <a href="#">욕실</a></small></h5>
    <div class="row">
    	<!-- 썸네일 -->
        <div class="col-6">
            <!-- <div class="goods_thumbs" id="main_image"> -->
                <img alt="" class="img-fluid" id="main_image" style="padding-bottom:7px;" src="${path }/resources/upload/product/천연목욕수세미1.jpg"/>
            <!-- </div> -->
            <div class="goods_thumbs_image row container">
                <ul class="clearfix">
                    <li class="col-2 small_image"><a href="${path }/resources/upload/product/천연목욕수세미1.jpg"><img src="${path }/resources/upload/product/천연목욕수세미1.jpg"></a></li>
                    <li class="col-2 small_image"><a href="${path }/resources/upload/product/천연목욕수세미2.jpg"><img src="${path }/resources/upload/product/천연목욕수세미2.jpg"></a></li>
                    <li class="col-2 small_image"><a href="${path }/resources/upload/product/천연목욕수세미3.jpg"><img src="${path }/resources/upload/product/천연목욕수세미3.jpg"></a></li>
                    <li class="col-2 small_image"><a href="${path }/resources/upload/product/천연목욕수세미4.jpg"><img src="${path }/resources/upload/product/천연목욕수세미4.jpg"></a></li>
                    <li class="col-2 small_image"><a href="#">5</a></li>
                    <li class="col-2 small_image"><a href="#">6</a></li>
                </ul>
            </div>
        </div>
        <!-- 제품 info -->
        <div class="col-6 info-container">
        	<div class="inner_goods_form container">
        		<div class="head" style="margin-top:0px;">
        			<div class="information size-up" style="padding-top:10px;">제품명&nbsp;&nbsp;<img src="${path}/resources/images/product/sale.jpg" width="50px"></div>
        			<div class="information size-up">4,000원&nbsp;
        				<span id="sale_price" value="4000" style="text-decoration:line-through; font-size:18px; color:dimgray;">5,000원</span>
        			</div>
                    <div class="information size-mid row">
	                    <div class="col-10">별점</div>
	                    <div class="col-2"><a href=""><img src="${path}/resources/images/product/SNS.png" width="35px" style="right:0;"></a></div>
                    </div>
                    <hr>
                    <div class="information size-mid">제품 간단설명</div>
                    <div class="information size-mid">구매 시 포인트</div>
                    <div class="information size-mid">배송비 2,500원(50,000원이상 무료배송) | 도서산간 배송비 추가</div>
                    <hr>
                    
                    <!-- 1.기본선택창:옵션이 없을 경우 나올 화면 -->
                   <!--  <div class="information" style="padding-bottom:10px;">
                    	<div id="info_count" style="border-radius:4px;">
                    		<div class="information" style="margin:10px;">옵션선택확인</div>
                    		<div class="inforamtion row">
                    			<div class="col" style="margin-left:10px;">
                    				<input type="button" class="input_count" value="-" id="minus" onclick="minus();">
                    				<input type="text" class="input_count2" value="1" id="count" style="width:40px; text-align:center;">
                    				<input type="button" class="input_count" value="+" id="plus" onclick="plus();">
                    			</div>
                    			<div class="col-3">
                    				<input type="text" value="4000" id="total_count" hidden="hidden"/>
                    				<input type="text" value="4000" id="total_count_view" style="width:60px;text-align:right; border:none;" readonly/>원
                    			</div>
                    		</div>
                    	</div>
                    </div>  -->                   
                    <!-- 2.옵션선택창:옵션이 있을 경우 반드시 선택해야함 -->
                    <div class="information">
                    	<div class="optionChoice">
                    		<div class="select">
                    			<span class="size-mid">옵션선택</span>
                    		</div>
                    		<input type="hidden" name="option">
                    		<ul class="dropdown-menu">
                    			<li id="one">1번</li>
                    			<li id="two">2번</li>
                    		</ul>
                    	</div>
                    </div>
                    <div class="information" style="padding-bottom:10px;">
                    	<div id="info_count" style="border-radius:4px;">
                    		<div class="information" style="margin:10px;">옵션선택확인</div>
                    		<div class="inforamtion row">
                    			<div class="col" style="margin-left:10px;">
                    				<input type="button" class="input_count" value="-" id="minus" onclick="minus();">
                    				<input type="text" class="input_count2" value="1" id="count" style="width:40px; text-align:center;">
                    				<input type="button" class="input_count" value="+" id="plus" onclick="plus();">
                    			</div>
                    			<div class="col-3">
                    				<input type="text" value="4000" id="total_count" hidden="hidden"/>
                    				<input type="text" value="4000" id="total_count_view" style="width:60px;text-align:right; border:none;" readonly/>원
                    			</div>
                    		</div>
                    	</div>
                    </div>        			
                    <!-- 버튼 3개,로그인 안 할 경우 클릭 못하게 방지 -->        			
                    <div class="information container">
                    	<c:if test="${loginMember!=null }">
		                    <button type="button" href="#" class="btn btn-success custom">구매하기</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom">장바구니</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom">찜하기</button>
	                    </c:if>
	                    <c:if test="${loginMember==null }">
		                    <button type="button" href="#" class="btn btn-success custom loginCheck">구매하기</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom loginCheck">장바구니</button>
		                    <button type="button" href="#" class="btn btn-outline-success custom loginCheck">찜하기</button>
	                    </c:if>
                    </div>                            			     			
        		</div><!-- class="head" 끝 -->
        	</div>
        </div><!-- 제품 div끝 -->
 
		<!-- 네비바 -->
		<div class="tab_wrap container">
		    <div class="tab_menu_container container">
			    <button class="tab_menu_btn on" type="button">상품상세</button>
			    <button class="tab_menu_btn" type="button">구매평(숫자)</button>
			    <button class="tab_menu_btn" type="button">상품문의(<c:out value="${count }"/>)</button>
		    </div> <!-- tab_menu_container e -->
		    <div class="tab_box_container">
		    	<!-- 상품상세 시작 -->
		    	<div class="tab_box on">
					<!--제품이미지 삽입-->
					<img src="${path}/resources/upload/product/천연목욕수세미5.jpg" style="width:80%; display:block;margin:auto;">
					<!--배송안내 시작!-->
					<div id="information">
						<hr>
						<p>
							<strong>■ 배송안내</strong>
						</p>
						<p>- 결제 완료일로부터 주말 및 공휴일 제외 2~5일 안에 배송됩니다.</p>
						<p>- 제주지역의 경우 추가 운임이 발생합니다.</p>
						<hr>
						<p>
							<strong>■ 교환 및 반품 안내</strong>
						</p>
						<p>- 전자상거래법에 의거하여 교환 및 반품 요청은 수령일로부터 7일 이내 입니다.</p>
						<p>- 고객의 단순 변심이나 실수로 인한 교환 및 반품의 경우 왕복 배송비는 고객이 부담하셔야 합니다.</p>
						<p>- 상품을 사용하였을 경우는 교환 및 반품이 불가합니다.(*상품 하자의 경우 예외)</p>
						<p>
							<strong>■ 제품불량에 따른 교환 및 반품 정책</strong>
						</p>
						<p>- 제품 수령일을 기준으로 7일이내 가능하며 뚜렷한 파손 및 제품 기능에 중대한 영향이 있는 경우에 한하여
							가능합니다.</p>
						<p>
							<strong>■ 단순 변심에 의한 교환 및 환불 정책</strong>
						</p>
						<p>- 제품 공급을 위한 운송비 전액(왕복 및 재발송)을 제한 금액이 환불됩니다.</p>
						<p>
							<strong>■ 교환 및 반품이 불가능한 경우</strong>
						</p>
						<p>- 포장을 개봉하였거나 훼손되어 상품 가치가 상실된 경우</p>
						<p>- 고객님의 사용 또는 일부 소비에 의해 상품의 가치가 현저히 감소한 경우</p>
						<p>- 교환 및 반품 접수 기간(7일)의 경과 혹은 시간의 경과에 의해 재판매가 곤란할 정도로 상품등의 가치가
							현저히 감소된 경우</p>
					</div>
				</div>
				
		    	<!-- 상품평 시작 -->
		    	<div class="tab_box">
		    		상품평 블라블라
		    	</div>
		    	
		    	<!-- 상품문의 시작 -->
				<div class="tab_box">
			        <!--상품문의 작성창-->
			        <form name="" action="${path}/product/insertInquiry">
				        <div class="writebox_wrap container col-lg-11" style="float:none; margin:0 auto;">
				            <button type="button" id="showBox" class="btn btn-success">상품문의</button>
					        <div class="wrap-category" style="display:none;">
						        <span class="span_textarea">
							        <textarea name="inqContent" id="" placeholder="문의내용을 입력해주세요"></textarea>
									<div style="float:right;">
								        <label>
								        	<img id="lockUnlock" src="${path}/resources/images/product/unlock.png" name="inqSecret" style="width:25px;height:25px;">
								        	<input type="hidden" id="secret" name="inqSecret" value="N">
								        </label>
								        <c:if test="${loginMember!=null }">
								        	<input type="hidden" name="memNo" value="${loginMember.memNo}">
								        	<input type="submit" class="btn btn-success" value="등록" style="right:0;">
								        </c:if>
								        <c:if test="${loginMember==null }">
								        	<input type="button" class="btn btn-success loginCheck" value="등록" style="right:0;">
								        </c:if>
						        	</div>
						        </span>
					        </div>
				        </div>
			        </form><!-- 상품문의 작성창 끝 -->
			        <!-- 상품문의 게시글 -->
			        <div class="container col-lg-11">
				        <table class="table">
					        <thead>
					        	<tr>
					        		<td scope="col">내용</td>
					        		<td scope="col">문의날짜</td>
					        		<td scope="col">작성자</td>
					        		<td scope="col">상태</td>
					        	</tr>
					        </thead>	
						<c:forEach items="${list}" var="i">
				        	<thead>
				        		<tr>
				        			<td scope="col"><c:out value="${i.inqContent }"/></td>
				        			<td scope="col"><c:out value="${i.inqDate }"/></td>
				        			<td scope="col"><c:out value="${i.memNo}"/></td>
				        			<td scope="col">
				        				<c:if test="${i.inqAnswerYn=='N'}">
				        					답변대기
				        				</c:if>
				        				<c:if test="${i.inqAnswerYn=='Y'}">
				        					답변완료
				        				</c:if>
				        			</td>
				        		</tr>
				        	</thead>
				        </c:forEach>
				        </table>
			        </div>

				</div>
			</div><!-- tab_box_container -->
		</div><!--네비바 끝 -->
		
		<!--연관상품 스와이프-->
		<div id="recommand_wrap" style="padding-top: 50px;">
			<div class="information">연관상품</div>
			<div class="swiper-container container">
				<div class="swiper-wrapper">
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/images/product/coffee1.jpg">
						</div>
						<div class="slideImg"><span>제품명1</span><br><span>제품가격</span></div>
						<div>
							<img src="${path}/resources/images/product/sale.jpg" width="50px">
						</div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/images/product/soap1.jpg">
						</div>
						<div class="slideImg"><span>제품명2</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/images/product/som1.jpg">
						</div>
						<div class="slideImg"><span>제품명3</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/images/product/woman1.jpg">
						</div>
						<div class="slideImg"><span>제품명4</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/images/product/coffee1.jpg">
						</div>
						<div class="slideImg"><span>제품명5</span><br><span>제품가격</span></div>
					</div>
					<div class="swiper-slide" style="display: block">
						<div>
							<img src="${path}/resources/images/product/coffee1.jpg">
						</div>
						<div class="slideImg"><span>제품명6</span><br><span>제품가격</span></div>
					</div>
				</div>
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
				<!-- Add Arrows -->
				<!-- <div class="swiper-button-next"></div>
                     <div class="swiper-button-prev"></div> -->
			</div>
		</div>


	</div><!-- class="row"끝 -->

</section>
<script>
	//썸네일 바꾸기 스크립트
	$(function() {
		$(".small_image a").click(function() {
			$("#main_image").attr("src", $(this).attr("href"));
			return false;
		});
	});

	//옵션선택 스크립트
	$('.optionChoice').click(function() {
		$(this).attr('tabindex', 1).focus();
		$(this).toggleClass('active');
		$(this).find('.dropdown-menu').slideToggle(300);
	});
	$('.optionChoice').focusout(function() {
		$(this).removeClass('active');
		$(this).find('.dropdown-menu').slideUp(300);
	});
	$('.optionChoice .dropdown-menu li').click(
			function() {
				$(this).parents('.optionChoice').find('span').text(
						$(this).text());
				$(this).parents('.optionChoice').find('input').attr('value',
						$(this).attr('id'));
			});

	
	//수량선택 스크립트
	var count = 1;
	var countEl = document.getElementById("count");
	var total_count = document.getElementById("total_count");
	var total_count_view = document.getElementById("total_count_view");

	function minus(){
		if(count > 1) {
			count--;
			countEl.value = count;
			total_count_view.value = total_count_view.value - total_count.value;
		}
	}
	function plus(){
		count++;
		countEl.value = count;
		total_count_view.value = total_count.value * countEl.value;
	}

	
	//네비바
	$(".tab_menu_btn").on("click", function() {
		//버튼 색 제거,추가
		$(".tab_menu_btn").removeClass("on");
		$(this).addClass("on");

		//컨텐츠 제거 후 인덱스에 맞는 컨텐츠 노출
		var idx = $(".tab_menu_btn").index(this);

		$(".tab_box").hide();
		$(".tab_box").eq(idx).show();
	});

	//연관상품 스와이프 스크립트
	var swiper = new Swiper('.swiper-container', {
		slidesPerView : 5, //보여줄 슬라이드 갯수
		spaceBetween : 20, //슬라이드간 간격
		slidesPerGroup : 5, //그룹으로 묶을 수
		loop : true, //무한반복
		loopFillGroupWithBlank : false, //그룹수가 맞지 않을 경우 빈칸 채우기(true)/그림으로 채우기(false)
		pagination : { //페이징처리
			el : '.swiper-pagination',
			clickable : true, //페이징 클릭 시 해당 영역으로 이동
		},
		autoplay : {
			delay : 2000,
		},
	});
	//연관상품 위에 마우스 올렸을 시 이벤트
	var mySwiper = document.querySelector('.swiper-container').swiper;
	//마우스 오버시 STOP!
	$(".swiper-container").mouseenter(function() {
		mySwiper.autoplay.stop();
		console.log('slider stopped');
	});
	//마우스 나갔을 시 다시 시작
	$(".swiper-container").mouseleave(function() {
		mySwiper.autoplay.start();
		console.log('slider started again');
	});

	
	//상품문의 클릭 시 박스 보였다가 안보였다가 이벤트
	$(function() {
		$("#showBox").click(function() {
			if ($(this).next().css("display") == "none") {
				$(this).next().show(1000);
			} else {
				$(this).next().hide(1000);
			}
		});
	});
	
	//상품문의 자물쇠그림바꾸기 + 비밀글 파라미터값 넘기기
	$("#lockUnlock").click(function() {
		$(this).attr("src", function(index, attr) {
			if(attr.match("unlock")) {
				$("#secret").attr("value",function(index,attr){
					if(attr.match("N")){
						console.log("Y");
						return attr.replace("N","Y");
					}
				});
				return attr.replace("unlock.png", "lock.png");
			} else {
				$("#secret").attr("value",function(index,attr){
					if(attr.match("Y")){
						console.log("N");
						return attr.replace("Y","N");
					}
				});
				return attr.replace("lock.png", "unlock.png");
			}
		});
	});
	
	//구매하기,장바구니,찜하기,상품문의 클릭 시 로그인 체크
	$(function() {
		$(".loginCheck").click(function() {
			alert("로그인을 먼저 해주세요");
		});
	});
	
	
	
	
	
</script>
    
<jsp:include page="/WEB-INF/views/common/footer.jsp" />
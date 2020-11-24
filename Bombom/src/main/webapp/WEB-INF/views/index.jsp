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
    /*모달 창  */
    .social-container {
        text-align: center;
        padding: 16px;
      }
      p.p-info {
        margin: 1rem 0 1rem 0;
      }
      #verification {
        margin-top: 20px;
      }
      .info {
        background-color: #e9ecef;
        text-align: center;
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

<!--모달 회원가입/로그인  -->
<div class="container"> 

      <!-- The Modal -->
      <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
              <h4 class="modal-title">다시:봄으로 회원가입</h4>
              <button type="button" class="close" data-dismiss="modal">
               X
              </button>
            </div>

            <!-- Modal body -->
            <form action="${path}/member/enrollMember.do" method="post">
              <div class="modal-body">
                <div class="form-group">
                  <input
                    type="text"
                    class="form-control"
                    placeholder="닉네임"
                    name="nick"
                  />
                  <label for="email">ajax 당신의 닉네임을 입력해주세요.</label>
                </div>
                <div class="form-group">
                  <input
                    type="email"
                    class="form-control"
                    placeholder="이메일주소"
                    name="email"
                  />
                  <label for="email">ajax 이메일 주소를 입력해주세요.</label>
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    class="form-control"
                    placeholder="비밀번호"
                    name="password"
                  />
                  <label for="pwd"
                    >ajax 8~16자리 비밀번호를 입력해주세요.
                  </label>
                </div>
                <div class="form-group form-check">
                  <label class="form-check-label">
                    <input class="form-check-input" type="checkbox" />
                    다시:봄 이용 약관 및 개인정보 취급방침에 대한 내용을 모두
                    <br />
                    확인하였으며, 이에 동의합니다.
                  </label>
                </div>
                <button type="submit" class="btn btn-success btn-block">
                 회원가입
                </button>
              </div>

              <!-- Modal footer -->
              <div class="social-container">
                <p>소셜 계정으로 간편하게 로그인 하세요 !</p>
                <div class="row">
                  <div class="col">구글</div>
                  <div class="col">카카오</div>
                  <div class="col">네이버</div>
                </div>
                <br />
                <p class="p-class">이미 회원이신가요?</p>
                <a
                  class="login"
                  data-toggle="modal"
                  data-target="#loginModal"
                  data-dismiss="modal"
                >
                  로그인 하기</a
                >
              </div>
            </form>
          </div>
        </div>
      </div>

      <!--로그인창  -->
          <!-- The Modal -->
      <div class="modal fade" id="loginModal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
              <h4 class="modal-title">다시:봄으로 로그인</h4>
              <button type="button" class="close" data-dismiss="modal">
                X
              </button>
            </div>

            <!-- Modal body -->
            <form action="" method="">
              <div class="modal-body">
                <div class="form-group">
                  <input
                    type="email"
                    class="form-control"
                    placeholder="이메일주소"
                    id="email"
                    required
                  />
                  <label for="email">ajax 이메일 주소를 입력해주세요.</label>
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    class="form-control"
                    placeholder="비밀번호"
                    id="pwd"
                    required
                  />
                  <label for="pwd"
                    >ajax 8~16자리 비밀번호를 입력해주세요.
                  </label>
                </div>
                <div class="form-group form-check">
                  <label class="form-check-label">
                    <input class="form-check-input" type="checkbox" /> ID저장
                  </label>
                </div>
                <button type="submit" class="btn btn-success btn-block">
                  로그인
                </button>
              </div>

              <!-- Modal footer -->
              <div class="social-container">
                <p>소셜 계정으로 간편하게 로그인 하세요 !</p>
                <div class="row">
                  <div class="col">구글</div>
                  <div class="col">카카오</div>
                  <div class="col">네이버</div>
                </div>
                <br />
                <a class="lostPwd"
                  data-toggle="modal"
                  data-target="#pwModal"
                  data-dismiss="modal">비밀번호를 잊어 버렸어요.</a>
                <p class="p-class">아직 회원이 아니신가요?</p>
                <a href="#"
                class="signUp"
                  data-toggle="modal"
                  data-target="#myModal"
                  data-dismiss="modal"
                  >회원 가입하기</a>
              </div>
            </form>
          </div>
        </div>
      </div> 
      
      <!--비밀번호 모달  -->
      <div class="modal fade" id="pwModal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
              <h4 class="modal-title">다시:봄 비밀번호 찾기</h4>
              <button type="button" class="close" data-dismiss="modal">
                X
              </button>
            </div>

            <!-- Modal body -->
            <div class="info">
              <p class="p-info">
                가입한 이메일 주소로 인증번호를 알려드립니다. <br />
                인증 확인 후, 새비밀번호를 설정합니다.
              </p>
            </div>
            <div class="modal-body">
              <input
                type="email"
                class="form-control"
                placeholder="이메일주소"
                id="email"
              />
              <label for="email">ajax 이메일 주소를 입력해주세요.</label>

              <button
                type="button"
                class="btn btn-success btn-block"
                onclick=""
              >
                인증하기
              </button>

              <input
                type="text"
                class="form-control"
                placeholder="인증번호"
                id="verification"
              />
              <label for="email">ajax 인증 시간:4분 59초</label>
              <div class="row">
                <div class="col">
                  <button
                  type="button"
                  class="btn btn-success btn-block"
                  data-toggle="modal"
                  data-target="#resetModal"
                  data-dismiss="modal"
                  >
                    인증확인
                  </button>
                </div>
                <div class="col">
                  <button
                   
             	
                  
                    type="button"
                    class="btn btn-success btn-block"
                    onclick=""
                  >
                    재전송
                  </button>
                </div>
              </div>
            </div>

            <!-- Modal footer -->
            <div class="social-container">
              <p class="p-class">비밀번호가 기억나셨다고요?</p>
              <a 
             	 class="login"
                  data-toggle="modal"
                  data-target="#loginModal"
                  data-dismiss="modal"
              >로그인 하기</a>
            </div>
          </div>
        </div>
      </div>
      <!--비밀번호 재설정  -->
      <div class="modal fade" id="resetModal">
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
              <h4 class="modal-title">다시:봄 비밀번호 찾기</h4>
              <button type="button" class="close" data-dismiss="modal">
                X
              </button>
            </div>

            <!-- Modal body -->
            <div class="info">
              <p class="p-info">
                새로운 비밀번호를 설정해주세요. <br />
        
              </p>
            </div>
            <form action="" method="">
                <div class="modal-body">
                  <div class="form-group">
                    <input
                      type="password"
                      class="form-control"
                      placeholder="새 비밀번호"
                      id="pwd"
                    />
                    <label for="email">ajax 정규표현식?? </label>
                  </div>
                  <div class="form-group">
                    <input
                      type="password"
                      class="form-control"
                      placeholder="새 비밀번호 확인"
                      id="pwdCheck"
                    />
                    <label for="pwd"
                      >ajax 입력한 새 비밀번호와 일치여부.
                    </label>
                  </div>
                  <button type="submit" class="btn btn-success btn-block">
                    재설정 완료
                  </button>
                </div>
          </div>
        </div>
      </div>
 </div>	<!--container div 모달끝  -->
 
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
                        <div class="swiper-pagination"></div>
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
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
      input[type=password] {font-family: "NanumSquare";}
</style>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MainTest</title>
    <script src="${path}/resources/js/jquery-3.5.1.min.js"></script>
    <link rel="stylesheet" href="${path }/resources/css/common/allPage.css">
    <!-- <link rel="stylesheet" href="css/header1440.css"> -->
    <!-- <link rel="stylesheet" href="css/header768.css"> -->
    
    <!-- swiper -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <script src="https://unpkg.com/swiper/swiper-bundle.js"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    
    <!-- 부트스트랩 -->
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
	<!-- sweet alert -->
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>

<body>
    <script>
        $(function () {
            $('#mainBanner').carousel({
                interval: 5000, //기본값 5000= 5초,false면 자동 순환하지 않는다.
                pause: "hover", // hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
            });
        })
    </script>
    <header id="spring-main-header" class="container-fluid fixed-top">
        <!-- header -->
        <div id="header-container">
            <div id="loginJoin" class="d-flex flex-row-reverse">
                <ul class="nav">
                    <li class="nav-item">
                    <c:if test="${loginMember == null }">
                    <a class="nav-link"  data-toggle="modal"data-target="#loginModal">로그인</a></li>
                    </c:if>
                    <c:if test="${loginMember!=null }">
                    <a class="nav-link"  onclick="location.replace('${path}/member/logout');">로그아웃</a></li>
                    </c:if>
                    <li class="nav-item">
                    <a class="nav-link"  data-toggle="modal"data-target="#myModal">회원가입</a>
                    </li>
                    <!-- 로그인시  나올 메뉴-->
                    <li class="nav-item"><a class="nav-link" href="${path }/mypage/orderStatus">마이페이지</a></li>
                  
                    <li class="nav-item"><a class="nav-link" href="${path }/order/basket">장바구니</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">검색</a></li>
                </ul>
            </div>
            <div id="logo-wrap">
            <a href="${path }"><img id="logo" class="img-responsive center-block" src="${path }/resources/images/springAgainLogo.png" alt="mainLogo"></a>
            </div>
            <div id="menuNav" class="dropmenu">
                <nav>
                    <ul id="menu_ul" class="nav justify-content-center pt-3">
                        <li class="nav-item">
                            <a class="nav-link" href="${path }/intro/moveIntro">다시:봄 소개</a></li>
                        <li class="nav-item dropdown">
                            <a id="menuNav-product" class="nav-link" href="${path }/product/productAll">제품</a>
                            <ul class="">
                            	<li><a class="" href="${path }/product/productAll">전체상품</a></li>
                            	<li><a class="" href="#">식품</a></li>
                                <li><a class="" href="#">잡화</a></li>
                                <li><a class="" href="#">주방</a></li>
                                <li><a class="" href="#">욕실</a></li>
                                <li><a class="" href="#">여성용품</a></li>
                                <li><a class="" href="#">반려동물</a></li>
                                <li><a class="" href="#">할인상품</a></li>
                                <li><a class="" href="${path }/admin/moveProduct">관리자테스트</a></li>
                            </ul>
                        </li>
                        <li class="nav-item"><a class="nav-link" href="#">커뮤니티</a></li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">게시판</a>
                            <ul class="">
                                <li><a class="" href="${path }/notice/noticeListMember">공지사항</a></li>
                                <li><a class="" href="${path }/faq/faqList">자주묻는질문</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a id="menuNav-product" class="nav-link" href="${path }/product/productAll">관리자페이지</a>
                            <ul class="">
                            	<li><a class="" href="${path }/product/productAll">전체상품</a></li>
                            	<li><a class="" href="#">회원관리</a></li>
                                <li><a class="" href="#">상품관리</a></li>
                                <li><a class="" href="${path }/admin/moveProduct">주문관리</a></li>
                                <li><a class="" href="#">1:1문의 관리</a></li>
                                <li><a class="" href="#">이벤트관리</a></li>
                                <li><a class="" href="#">커뮤니티관리</a></li>
                                <li><a class="" href="${path }/notice/noticeList">공지사항 관리</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
            </div>

            <script>
                $(function(){
                    $(".dropmenu ul li").hover(function(){
                       $(this).find("ul").stop().fadeToggle(300);
                    });
                })

            </script>
        </div>
    </header>  

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
            <form action="${path}/member/enrollMember" method="post">
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
            <form action="${path}/member/loginMember" method="post">
              <div class="modal-body">
                <div class="form-group">
                  <input
                    type="email"
                    class="form-control"
                    placeholder="이메일주소"
                    name="email"
                    required
                  />
                  <label for="email">ajax 이메일 주소를 입력해주세요.</label>
                </div>
                <div class="form-group">
                  <input
                    type="password"
                    class="form-control"
                    placeholder="비밀번호"
                    name="password"
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
                </form>
          </div>
        </div>
      </div>
 </div>	<!--container div 모달끝  -->
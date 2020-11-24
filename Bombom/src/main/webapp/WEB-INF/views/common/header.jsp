<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MainTest</title>
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
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
                    <li class="nav-item"><a class="nav-link" href="#">로그인</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">회원가입</a></li>
                    
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
                                <li><a class="" href="${path }/notice/noticeList">공지사항</a></li>
                                <li><a class="" href="${path }/faq/faqList">자주묻는질문</a></li>
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

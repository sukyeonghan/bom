<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="org.springframework.web.util.UrlPathHelper" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
    <!-- footer -->
    <footer>
        <div id="spring-main-footer">
        	
	        <div id="site-info">
	            <p>회사명: 주식회사 다시:봄&nbsp;&nbsp;대표:엣헴이&nbsp;&nbsp;사업자등록번호111-86-11111&nbsp;&nbsp;통신판매업신고: 제2018-서울강남-0000호
	            <p>주소: 서울특별시 강남구 테헤란로14길 6 남도빌딩 4F&nbsp;&nbsp;이메일: ehem@spring.com&nbsp;&nbsp;개인정보보호담당자:엣헴이&nbsp;&nbsp;고객센터: 070-0000-0000
	            <p>Copyright ⓒ 2021. SpringAgain, Inc. All Rights Reserved Hostiog by (주)엣헴이가족</p>
	        </div>
       		 <div id="site-phone">
	        	<a href="${path }/agreement/view"><p class="a-link">약관 및 개인정보 취급방침</p></a>
       		 	<h4>070-0000-0000</h4>
       		 </div>
        </div>
    </footer>
</body>
</html>
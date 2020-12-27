<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="에러페이지" />
</jsp:include>

<section id="container">
	<div id="imgnBtbs">
		<img alt="" src="${path}/resources/images/404error.png" width="545px">
		<div id="btns">
			<input type="button" id="first" class="btn" onclick="location.href='${path}/'" value="메인으로">
			<input type="button" class="btn" onclick="location.href='javascript:history.back();'" value="이전페이지">
		</div>
	</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<style>
	#imgnBtbs{
		text-align:center;
	}
	#btns{
		display:flex;
		justify-content: center;
		margin-top:30px;
	}
	#first{
		margin-right: 20px;
	}
	.btn{
		font-size: 18px;
    	border: 1px black solid;
	}
</style>
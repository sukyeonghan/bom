<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품문의 수정/삭제</title>
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

<style>
	.all_wrap{
		padding:15px 0 15px 0;
	}
	.inquiry_wrap{
		border:1px orange solid;
		width:100%;
		height:200px;
	}
	.inquiryAnswer_wrap{
		border:1px violet solid;
		width:100%;
		height:200px;
	}
</style>

<body>
	<section class="container">

 		<div class="all_wrap">
	 		<div class="inquiry_wrap">
				<c:if test="${inquiry==null}">
					등록된 상품문의가 없습니다
				</c:if>
				<c:if test="${inquiry!=null }">
	 				<div class="col-8"><c:out value="${inquiry.inqContent}"/></div>
	 				<div class="col-2"><c:out value="${inquiry.inqDate}"/></div>
	 				<div class="col-2"><c:out value="${inquiry.inqNo}"/></div>
	 				<c:out value="${memNick }"/>
				</c:if>
	 		</div>
	 		
	 		
	 		<div class="inquiryAnswer_wrap">
	 		
	 		</div>
 		</div>		
	
	</section>
	
	
	
	
	
	
	
	

</body>


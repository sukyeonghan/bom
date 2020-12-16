<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<div class="zzimFolder">
	<div class="checkFilter"></div>
	<input type="checkbox" class="delZzimCkbox" name="delZzimNo" value="${zzim.zzimNo }">
	<a href="${path }/zzim/selectZzimContent?zzimNo=${zzim.zzimNo }&zzimName=${zzim.zzimName}">
		<div class="zzimImgDiv">
				<c:if test="${zzim.zzimFolderImg != null}">
			<img src="${path }/resources/upload/product/${zzim.zzimFolderImg };" width="100%">
			</c:if>
			<div class="zzimInfo">
				<p><c:out value="${zzim.zzimName }"/></p>
				<p><i class="fas fa-heart"></i> <c:out value="${zzim.zzimContentCount==null?0:zzim.zzimContentCount }"/></p>
			</div>
		</div>		
	</a>
</div>

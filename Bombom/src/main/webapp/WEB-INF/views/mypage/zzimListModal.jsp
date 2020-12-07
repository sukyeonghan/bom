<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<style>
	ul#zzimListUl{list-style-type:none;padding:0;}
	ul#zzimListUl>*{cursor:pointer;}
	
	li#addFolderLi,li.zzimFolderLi{padding: 10px; border-bottom: 2px lightgray solid;width:100%;}
	div#addFolderDiv,div.zzimFolderDiv{width:100%; height: 50px; display:flex;}
	div#inputbox{width:100%; height: 50px; display:none; }
	
	.folderInfo{height: 50px; margin-left:20px;}
	.folderInfo>p{line-height: 50px}
	.zzimFolderImgDiv{width:50px;height: 50px;}
	
	#addBtn,#cancelBtn{height:40px;}
</style>
<ul id="zzimListUl">
	<li id="addFolderLi">
		<div id="addFolderDiv">
			<div style="width:50px;height: 50px; background-color:#45A663;border-radius:20%;">
				<p style="line-height:50px; font-size: 30px; text-align: center; color:#ffffff;"><i class="fas fa-plus"></i><P>
    	   	</div>
    	   	<div class="folderInfo">
    	   		<p>폴더생성</p>
    	   	</div>
		</div>
		<form name="addFrm">
		<div id="inputbox" class="form-group">
				<input type="text" class="form-control" name="zzimName" >
				<input type="button" class="btn btn-success" id="addBtn" value="확인" >
				<input type="button" class="btn btn-outline-danger" id="cancelBtn" value="취소">
		</div>
		</form>
   	</li>
   	   		
	<c:forEach items="${zzimList }" var="zzim">
		<li class="zzimFolderLi">
			<div class="zzimFolderDiv">
				<div class="zzimFolderImgDiv">
    	   			<c:if test="${zzim.zzimFolderImg != null}">
						<img src="${path }/resources/upload/product/${zzim.zzimFolderImg };"  style="width:50px; height:50px;border-radius:20%;">
					</c:if>
					<c:if test="${zzim.zzimFolderImg == null}">
						<div style="width:50px;height: 50px; background-color:lightgray;border-radius:20%;"></div>
					</c:if>
   	   			</div>
    	   		<div class="folderInfo">
    	   			<p><c:out value="${zzim.zzimName }"/></p>
    	   		</div>
			</div>
		</li>
	</c:forEach>
</ul>

<script>
	
	$("#addFolderDiv>*,#addFolderDiv").click(e=>{
		$("#addFolderDiv").hide();
		$("#inputbox").show();
		$("#inputbox").attr("display","flex");
		$("#cancelBtn").click(e=>{
			$("#addFolderDiv").show();
			$("#inputbox").hide();
		});
	});

</script>
	        
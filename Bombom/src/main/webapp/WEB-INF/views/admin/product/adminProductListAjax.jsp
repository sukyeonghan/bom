<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />


	<!-- 제품관리 테이블 -->
	<div id="product-table-wrap">
		<table id="product-table" class="table table-hover">
			<tr>
				<th>선택</th>
				<th>카테고리</th>
				<th>상품명</th>
				<th>상품설명</th>
				<th>기본가격</th>
				<th>이벤트명</th>
				<th>옵션여부</th>
				<th>판매상태</th>
				<th>등록날짜</th>
			</tr>
			<c:if test="${not empty list}">
				<input type="hidden" name="count" value="${count}">
				<c:forEach var="e" items="${list }">
					<tr>
						<td>
							<input type="checkbox" name="check" value="check">
							<input type="hidden" name="delNum" value="${e.pdtNo }">	
						</td>
						<td><c:out value="${e.pdtCategory}"/></td>
						<td>
							<a class="product-update" href="${path}/admin/productUpdate?pdtNo=${e.pdtNo}">
								<c:out value="${e.pdtName}"/>
							</a>
						</td>
						<td>
							<c:choose>
								
								<c:when test="${fn:length(e.pdtIntro)>9}">
									<c:out value="${fn:substring(e.pdtIntro,0,8) }"/>...
								</c:when>
								<c:otherwise>
									<c:out value="${e.pdtIntro}"/>
								</c:otherwise>
							</c:choose>
							</td>
						<td>
							<fmt:formatNumber value="${e.pdtPrice}" />원
						</td>
						<td>
							<c:choose>
								<c:when test="${not empty e.eventNoRef }">
									<c:out value="${e.eventNoRef}"/>
								</c:when>
								<c:otherwise>
									N
								</c:otherwise>
							</c:choose>
						</td>
						<td>
							<c:choose>
								<c:when test="${not empty e.pdtOptionNo }">
									Y
								</c:when>
								<c:otherwise>
									N
								</c:otherwise>
							</c:choose>
						</td>
						<td><c:out value="${e.pdtStatus}"/></td>
						<td><fmt:formatDate value="${e.pdtDate}" pattern="yyyy-MM-dd"/></td>
						
					</tr>
				</c:forEach>
			</c:if>
		</table>
		
		<!-- 페이징바 -->
		 <div >	
			${pageBar }
		</div>
		
		<!-- 검색 -->
		<div id="search-wrap">
			<!-- 검색 카테고리 -->
			<div class="select-box">
				<select class="searchSort form-control" name="searchSort">
					<option value="">검색타입</option>
					<option value="pdtName">상품명</option>
					<option value="eventNo">이벤트명</option>
				</select>
			</div>
			<input type="text" id="search-text" class="form-control"  name="keyword">
			<button class="btn btn-success" id="search-btn" onclick="search();">검색</button>
		</div>
		
	</div>
			
<script>
	
	//검색버튼 누르면
	function search(){
		
		if($("select[name=searchSort]").val()==""){
			swal("검색 타입을 설정해주세요.");
		}else if($("#search-text").val()==""){
			swal("검색어를 입력해주세요.");
		}else{
			//검색 타입과 검색어를 입력했으면
			$.ajax({
				
				url:"${path}/admin/productSearchAjax",
				data:{"searchType":$("select[name=searchSort]").val(),"keyword":$("#search-text").val().trim(),"sort":"${sort}",count:"${count}"},
				type:"get",
				dataType:"html",
				success:data=>{
					
					$("#result").html("");
					var tbody=$("#result").html(data).find('tbody');
					var tr=tbody.find('tr');
					//검색 결과가 없으면
					if(tr.length==1){
						let tr=$("<tr>").html();
						let td=$("<td colspan=9>").html("해당하는 제품이 없습니다.");
						tbody.append(td);
						tbody.append(tr);
						$("#countResult").text('0');
						
					} else {
						$("#result").html(data);
						let count=$("#result").html(data).find('input[name=count]').val();
						console.log(count);
						$("#countResult").text(count);
					}
				}
			});
		}
	}
</script>


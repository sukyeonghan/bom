<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=" "/>
</jsp:include>
<style>
	#flexDiv{display:flex; padding: 0px 10% 0px 10%;}
	#mypage-container{min-width:800px; width:100%; padding-right:100px;}
	.right{text-align: right;}
	#mypage-container table{text-align:center;  margin-top: 20px;}
	#point-searchDiv{background: #E4F7BA; height:60px; border-radius: 10px; vertical-align: middle; min-width:800px;}
	#point-innerDiv{padding: 12px; display: flex; justify-content: space-around;}
	#searchDateDiv{display: flex;}
	.form-control{margin-right:10px;}
	.pointChange{font-weight:bolder;}
</style>
<section id="container">
	<div id="flexDiv">
		<!-- 좌측 메뉴 -->
		<jsp:include page="/WEB-INF/views/common/mypageMenu.jsp"/>
		<!-- 우측 메뉴내용 -->
		<div id="mypage-container">
			<div style="display:flex; justify-content: space-between; margin-bottom:20px;">
				<h3>적립금</h3> 
				<h5 style="margin-top:10px;">총 적립금:&nbsp;<strong><fmt:formatNumber type="number" value="${totalPoint }"/></strong>봄</h5>
			</div>
			<div id="point-searchDiv" >
				<div id="point-innerDiv">
					<!-- 오늘날짜 -->
					<jsp:useBean id="now" class="java.util.Date" />
					<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
					<fmt:formatDate value="${now}" pattern="MM" var="nowMonth" />
					
					<div>
					<div class="btn-group">
						<c:forEach begin="1" end="5" varStatus="vs" step="1">
						  <button type="button" class="btn btn-success monthBtn" >
							<c:if test="${nowMonth-5+vs.index <=0}">
								<c:out value="${nowMonth-5+vs.index+12}월"/>
							</c:if>
							<c:if test="${nowMonth-5+vs.index >0}">
								<c:out value="${nowMonth-5+vs.index}월"/>
							</c:if>
							</button>
						</c:forEach>
					</div>
					</div>
					<div id="searchDateDiv">
						<form name="pointFrm" id="pointFrm" class="form-inline" >
						
							<c:if test="${start != '' }">
								<input type="date" name="start" class="form-control" value="${start}"/>
							</c:if>
							<c:if test="${start == ''}">
								<input type="date" name="start" class="form-control"  value=""/>
							</c:if>
							
							<span style="margin-right:10px;">&nbsp;~&nbsp;</span>
							<c:if test="${end != ''}">
								<input type="date" name="end" class="form-control" value="${end }" />
							</c:if>
							<c:if test="${end ==''}">
								<input type="date" name="end" class="form-control" value="${today }"/>
							</c:if>
							<select class="form-control" name="filter">
								<option selected="selected" value="all">전체</option>
								<option value="minus">사용</option>
								<option value="plus">적립</option>
							</select>
							<input type="button" class="btn btn-success" value="검색" onclick="fn_pointDateSearch();"/>
						</form>
					</div>
				</div>
			
			</div>
			<div id="result">
				<table class="table table-hover">
				    <thead>
				      <tr>
				        <th>날짜</th>
				        <th>사유/내용</th>
				        <th>포인트내역</th>
				      </tr>
				    </thead>
				    <tbody>
				    <c:if test="${not empty list}">
				    	<c:forEach items="${list}" var="p">
					      <tr>
					        <td><fmt:formatDate type="both" timeStyle="short" value="${p.pointDate }"/></td>
					        <td>
					        	<!-- 주문번호 여부 체크 -->
					        	<c:if test ="${fn:contains(p.pointContent, '주문번호')}">
						        	<c:set var="start" value="${fn:indexOf(p.pointContent,'주문번호') }"/>
						        	<c:set var="end" value="${fn:indexOf(p.pointContent,')') }"/>
						        	<c:set var="orderNo" value="${fn:substring(p.pointContent,start+5,end) }"/>
						        	<a href="${path }/mypage/orderDetail?orderNo=${orderNo}"> 
						        		<c:out value="${p.pointContent }"/>
						        	</a>
					        	</c:if>
					        	
					        	<c:if test ="${not fn:contains(p.pointContent, '주문번호')}">
					        		<c:out value="${p.pointContent }"/>
					        	</c:if>
					        </td>
					        <td class="pointChange">
					        	<c:if test="${p.pointChange ge 0 }">
					        		<span style="color:green;"><c:out value="+${p.pointChange}봄"/></span>
					        	</c:if>
					        	<c:if test="${p.pointChange lt 0 }">
					        		<span style="color:red;"><c:out value="${p.pointChange}봄"/></span>
					        	</c:if>
					        </td>
					      </tr>
				      	</c:forEach>
				      </c:if>
				      <c:if test="${empty list }">
				      		<tr>
				      			<td colspan="3"> 검색된 결과가 없습니다.</td>
				      		</tr>
				      </c:if>
				    </tbody>
				</table>
				<br>
				
				<div id="pageBar">
					${pageBar }
		    	</div> 
	    	
	    	</div>
		</div>
		
		
		
	</div>
</section>
<script>
	//날짜 -> 스트링 변환함수
	function getDateToString(date)
	{
		var yyyy = date.getFullYear();
		var mm = date.getMonth()+1; 
		var dd = date.getDate();
		if(dd<10){dd='0'+dd};
		if(mm<10){mm='0'+mm};
		yyyy = yyyy.toString();
		mm = mm.toString();
		dd = dd.toString();
		return yyyy+"-"+mm+"-"+dd;
	}
	$(".monthBtn").click(e=>{
		var mon=$(e.target).text().trim();//버튼에 해당하는 달		
		var idx=mon.indexOf("월");
		mon=Number(mon.substring(0,idx));//숫자만
		
		var now = new Date();
	    var nowYear = now.getFullYear();
	    var nowMonth = now.getMonth()+1;
	    var firstDate;
	    var lastDate;
		if(nowMonth>0 && nowMonth<5 && mon<13 && mon>8 ){
			firstDate = new Date(nowYear-1 ,mon-1, 1);
    		lastDate = new Date(nowYear-1 ,mon, 0);
		}else{
			firstDate = new Date(now.getFullYear(),mon-1, 1);
	    	lastDate = new Date(now.getFullYear(),mon, 0);
		}  
		
		$("input[name=start]").val(getDateToString(firstDate));
		$("input[name=end]").val(getDateToString(lastDate)); 
	})

	
	function fn_pointDateSearch(){
		 var form = $("#pointFrm")[0];        
	     var formData = new FormData(form);
		$.ajax({
			url : "${path}/mypage/myPointListAjax",
            processData: false,
            contentType: false,
            type : 'POST', 
            data : formData, 
            dataType:"html",
            success:data=>{
            	$("#result").html("");
            	$("#result").html(data);
            }
		});
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
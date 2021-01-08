<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
#titleDiv{
	display:flex;
	justify-content: space-between;
	width:80%;
	margin:0 auto;}
/*타이틀&개수*/
#titleWrap{
	display:flex; 
	width: 500px; 
	cursor: default;
}
/*페이지 타이틀*/
#title{
	font-size: 30px;
    margin: 0 20px 3px 0px
}
/*알림 개수*/
#allCount{
	font-size: 19px;
	margin-top:10px;
}

/*알람 전체 감싼 div*/
#alarmWrap{
	width:80%;
	margin:0 auto;
}
/*메세지 */
#alarmWrap>div{
	border: 1px gray solid;
    height: 10%;
    align-items: center;
    display: flex;
}
/*x버튼*/
.close{height: 100%;}
#allAlarmDel{font-size: 19px; margin-top:10px; font-weight:bolder; 	cursor: pointer;}

</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="�Ұ�" />
</jsp:include>

<section id="container">
	<!-- 알림메세지 상세화면 -->
	<div id="titleDiv">
		<div id="titleWrap">
			<p id="title">알림 메세지</p>
			<p id="allCount">총 <c:out value="${countAlarm}"/>개</p>
		</div>
		<div><p id="allAlarmDel" onclick="location.href='${path}/member/deleteAlarmAll?receiverNo=${loginMember.memNo }'">전체삭제</p></div>
	</div>

	<div id="alarmWrap">
	<c:forEach var="a" items="${alarmList }">
		
		<div class="alert alert-light alert-dismissible fade show" style="border: 1px gray solid; height:10%">
			<!--x버튼 누르면 알림 삭제 -->
    		<button type="button" class="close" data-dismiss="alert" 
    			onclick="location.href='${path}/member/deleteAlarm?alarmNo=${a.alarmNo}'">X</button>
    		<strong>${a.message }</strong>
		</div>
  
	</c:forEach>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

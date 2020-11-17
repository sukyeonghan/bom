<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<style>
    #first-intro{
        text-align: left;
        display: flex;
        justify-content: flex-end; 
        font-size: 15px;
    }
    .icons,.sub-title,.sub-content{
        display: inline;
    }
</style>
<%-- <jsp:include page="/WEB-INF/views/common/header.jsp" > 
	<jsp:param name="title" value="소개"/>
</jsp:include> --%>

<section id="content">
  <div id="content-box">
        <h2>건강한 소비가 만드는 건강한 지구</h2>
        <div  id="first-intro">
            <pre>
    다시:봄은 쓰레기없는 삶의 방식을 제안합니다. 
    환경과 동식물 모두에게 친환경적인 제품을 소개하고 불필요한 포장을 줄입니다.  
    또한‘오늘:해봄’커뮤니티를 통해 고객과 함께 실천해 나가고자 합니다.
            </pre>
        </div>
        <div>
            <img class="icons" src="${path }/resources/images/intro/save.png" width="50px" height="50px">
            <h4 class="sub-title">소재에 대한 고민</h4>
            <p class="sub-content">플라스틱은 가볍고 저렴한 소재이지만 환경에는 치명적인 소재입니다. 다시:봄에서는 천연소재의 제품, 생분해성 소재 및 재활용 플라스틱 제품 등 플라스틱을 대체할 수 있는 다양한 제품을 소개합니다. </p>
        </div>
    </div>
</section>

<%-- <jsp:include page="/WEB-INF/views/common/footer.jsp" />  --%>
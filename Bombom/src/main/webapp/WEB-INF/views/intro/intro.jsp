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

<jsp:include page="/WEB-INF/views/common/header.jsp" > 
	<jsp:param name="title" value="소개"/>
</jsp:include> 

<section>
  <div class="container">
        <div class="row">
            <div class="col-md-5">
                <h3>건강한 소비가 만드는 건강한 지구</h3><br>
            </div>
            <div class="col-md-7">
                <div>
                    <p class="first-intro">
                        <br>
                        <br>
                        <br>
                        다시:봄은 쓰레기없는 삶의 방식을 제안합니다.<br>
                        환경과 동식물 모두에게 친환경적인 제품을 소개하고 불필요한 포장을 줄입니다.<br>
                        또한‘오늘:해봄’커뮤니티를 통해 고객과 함께 실천해 나가고자 합니다.<br>
                    </p>
                </div>
            </div>
        </div>
        <br>
        <br>
        <div class="media" style="margin-left: 7%"> 
            <img class="align-self-center mr-3" src="${path }/resources/images/intro/sprout.png" width="50px">
            <div class="media-body" style="margin: 0 5% 0 10%">
                <h5 class="sub-title">소재에 대한 고민</h5>
                <br>
                <p class="sub-content">플라스틱은 가볍고 저렴한 소재이지만 환경에는 치명적인 소재입니다. 다시:봄에서는 천연소재의 제품, 생분해성 소재 및 재활용 플라스틱 제품 등 플라스틱을 대체할 수 있는 다양한 제품을 소개합니다.  </p>
            </div>
        </div>
        <br>
        <br>

        <div class="media" style="margin-left: 7%"> 
            <img class="align-self-center mr-3" src="${path }/resources/images/intro/save.png" width="50px">
            <div class="media-body" style="margin: 0 5% 0 10%">
                <h5 class="sub-title">모두에게 안전한 제품</h5>
                <br>
                <p class="sub-content">사람뿐만 아니라 모든 동식물이 행복한 지구를 꿈꿉니다. 제작과정에서 환경 훼손을 최소화한 제품, 동물실험을 하지 않은 제품, 유해한 성분없는 제품을 소개하고자 합니다. </p>
            </div>
        </div>
        <br>
        <br>

        <div class="media" style="margin-left: 7%"> 
            <img class="align-self-center mr-3" src="${path }/resources/images/intro/recycle.png" width="50px">
            <div class="media-body" style="margin: 0 5% 0 10%">
                <h5 class="sub-title">플라스틱 없는 배송</h5>
                <br>
         		
                <p class="sub-content">종이 대체품 또는 재사용 택배 박스로 배송이 됩니다.  플라스틱을 사용하지 않아도, 과도하게 포장재를 사용하지 않아도 안전하게 배송되도록 노력하고 있습니다. </p>
            </div>
        </div>
        <br>
        <br>
    
    <!-- <div class="container-fluid"> -->
        <div class="row">
            <div class="col-md-12">
                <img class="img-fluid" src="${path }/resources/images/intro/shop3.jpg">
            </div>
        </div>
        <br>

        <div class="media" style="margin-left: 100px" > 
            <img class="align-self-center mr-3" src="${path }/resources/images/intro/mascot.png" width="130px">
            <div class="media-body">
                <p><br>다시:봄의 마스코트 <br>
                    <mark>엣헴이</mark>와 함께 합니다.<br>
                   	 다시:봄에서 지켜내고자 하는 <br>
                    	모든 동식물 및 환경을 대표합니다. </p>
            </div>
        </div>
      

    </div>
  
  
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" /> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<style>
	/*좌측메뉴*/
	.admin-nav{padding-right:100px; min-width: 230px;}
	.admin-nav a{font-weight:bolder;}
	.admin-nav a:hover{color: #45A663;}
	.select{color:#45A663;}
	.non-select{color:black;}
	
	/*최소 컨텐츠 크기*/
	.media{min-width: 768px;} 
	
	/*페이지 타이틀*/
	.page-title{margin-bottom:5%;}
	
	/*셀렉트 박스 정렬*/
	.select-box{
		display:flex;
		justify-content:space-between;
	}
	/*정렬*/
	.sort{
		border:none;
		outline:none;
	}
	
	/*제품 등록 테이블*/
	#insert-table{
		width:100%;
		margin:20px 0;
		padding:5px;
	}
	tr,th,td{
		padding:15px;
	}
	
    /*제품 설명*/
     #middle-div{
    	margin-left:15px;
    	margin-bottom:20px;
    }
    .title{
    	font-weight:bold;
    }
    #intro-text{
    	resize:none;
    }
   
   /* 제품 썸네일,상세 이미지 등록*/
    #bottom-div{
    	margin-left:15px;
    	margin-top: 40px;
    }
    
    /*썸네일*/
    /*썸네일 이미지 전체 div*/
    #thumbWrap{
    	overflow:hidden;
    }
    /*바깥 div*/
    .test{
    	width:150px;
    	height:170px;
    	float:left;
    	margin:35px;
    	position:relative;
   	}
   	/*썸네일1,썸네일2.. 타이틀*/
   	.sumTitle{
   		margin:0;
   	}
   	/*사진 미리보기 div*/
    .proDiv{
    	border:1px solid black;
    	width:150px;
    	height:150px;
    	position:relative;
    	float:left;
    }
    /*썸네일 사진*/
    .proImg{
 		position:absolute;
        max-width:100%; 
        max-height:100%;
        width:auto; 
        height:auto;
        margin:auto;
        top:0; bottom:0; left:0; right:0;
    }
    /*이미지 삭제 버튼*/
    .close{border:none;}
 
   
    /*상세 이미지 등록 div*/
    #detail-image{
    	margin-top:20px;
    	width:88%;
    }
    
  
    /*옵션*/
    .trOption{
    	margin-left:10px;
    }
    /*옵션 삭제버튼*/
    .delBtn{
    	margin-left:10px;
    }
    
    /*등록하기,목록 버튼*/
    #bottom-btns{
    	text-align:center;
    	margin-top:100px;
    }
    .insertPro,.goList{
    	display:flex;
    }
</style>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value="소개" />
</jsp:include>

<section id="container" class="container">
	<div class="media">
	
		<!--관리자 내비게이션바 -->
		<div id="" class=" mr-3 admin-nav">
		  <ul class="nav flex-column">
		    <li class="nav-item">
      			<a class="nav-link non-select" href="${path }/">회원관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link select" href="${path }/admin/moveProduct">제품관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">주문관리</a>
		    </li>
		    <li class="nav-item">
		     	 <a class="nav-link non-select" href="${path }/">1:1문의관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">이벤트관리</a>
		    </li>
		    <li class="nav-item">
		      	<a class="nav-link non-select" href="${path }/">커뮤니티관리</a>
		    </li>
		  </ul>
		</div>
		
		<div id="admin-container" class="media-body">
			<!-- 페이지 타이틀 -->
			<h3 class="page-title">제품등록</h3> 
			
			<!-- 제품 등록 -->
			<form>
				<table id="insert-table">
					<tr>
						<th>카테고리</th>
						<td>
						<!-- 검색 카테고리 -->
							<div class="select-box">
								<select class="sort">
									<option selected disabled hidden>카테고리 선택</option>
									<option>식품</option>
									<option>잡화</option>
									<option>주방</option>
									<option>욕실</option>
									<option>여성용품</option>
									<option>반려동물</option>
								</select>
							</div>
						</td>
						<th>판매 상태</th>
						<td>
							<!-- 판매상태 카테고리 -->
							<div class="select-box">
								<select class="sort">
									<option selected disabled hidden>판매상태 선택</option>
									<option>Y</option>
									<option>N</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th>제품명</th>
						<td><input type="text"></td>
						<th>제품기본가격</th>
						<td>
							<input type="text">
						</td>
					</tr>
					<tr>
						<th>이벤트</th>
						<td colspan=3">
						<!-- 이벤트 카테고리 -->
							<div class="select-box">
								<select class="sort">
									<option>이벤트 선택</option>
									<c:if test="${not empty list}">
										<c:forEach var="e" items="${list}">
											<option><c:out value="${e.eventTitle }"/></option>
										</c:forEach>
									</c:if>
								</select>
							</div>
						</td>
						
					</tr>
					<tr>
                        <th>추가 옵션</th>
                        <td colspan="3">
                        	<input type="button" class="btn btn-success" id="add-option" value="옵션 추가하기">
                        </td>
                    </tr>
                    <tr class="trOption" name="trOption">
                        <th>&nbsp&nbsp옵션 내용</th>
                        <td><input type="text"></td>
                        <th>추가 요금</th>
                        <td><input type="text"><button class="btn btn-success delBtn" name="delBtn" >삭제</button></td>
                    </tr>
				</table>
				
				<!-- 제품 설명-50자 이내로 받기 -->
				<div id="middle-div">
					<p class="title" id="product-intro">간단한 제품 설명</p>
					<textarea id="intro-text" rows="5" cols="100" placeholder="50자 이내로 적어주세요"></textarea>
				</div>
				
				<!-- 제품 썸네일,상세 이미지 등록 -->
				<div id="bottom-div">
					<p class="title">제품 썸네일 이미지(최대 6장)</p>
					<div id="thumbWrap">
						<div class="test" > 
			     			<div>
			     				<p class="sumTitle">썸네일1(메인)</p>
			     			</div>
							<div class="proDiv" id="1"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								<input type="file" class="proPic" id="input1" accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
			     		</div>
			     				
			     		<div class="test" > 
			     			<div>
			     				<p class="sumTitle">썸네일2</p>
			     			</div>
			     			<div class="proDiv" id="2">
				     			<img class="proImg" src="${path }/resources/images/product/plus2.png">
								<input type="file" class="proPic" id="input2" accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
							</div>
			     		</div>
			     		
			     		<div class="test" > 
			     			<div>
			     				<p class="sumTitle">썸네일3</p>
			     			</div>
				     		<div class="proDiv" id="3"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								<input type="file"  class="proPic" id="input3"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="test" > 
			     			<div>
			     				<p class="sumTitle">썸네일4</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="4"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								<input type="file"  class="proPic" id="input4"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="test" > 
			     			<div>
			     				<p class="sumTitle">썸네일5</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="5"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								<input type="file"  class="proPic" id="input5"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     		
			     		<div class="test" > 
			     			<div>
			     				<p class="sumTitle">썸네일6</p>
			     			</div>
				     		<div class="proDiv" style="float:left" id="6"> 
								<img class="proImg" src="${path }/resources/images/product/plus2.png">
								<input type="file"  class="proPic" id="input6"  accept="image/gif, image/jpeg, image/png" style="display:none;">
								<input type="button" class="close" value="x">
				     		</div>
				     	</div>
			     	
					</div>
					
		      		<div id="detail-image">
			      		<p class="title">제품 상세 이미지(총 1장)</p>
			      		<input type="file" class="form-control-file border">
		      		</div>
				</div>
				
				<div id="bottom-btns">
					<input type="submit" class="btn btn-success insertPro" value="등록하기">
					<input type="button" class="btn btn-success goList" onclick="location.href='${path}/admin/moveProduct'" value="목록">
				</div>
				
			</form>
				
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<script>
	//간단한 설명 - 글자 수 제한
	$(document).ready(function(){
		$("#intro-text").on('keyup',function(){
			if($(this).val().length>50){
				$(this).val($(this).val().substring(0,50));
				swal("50자를 초과하였습니다.");
			}
		});
	});
	//옵션 추가하기 
	$("#add-option").click(function(){
		var addOption="";
        addOption+='<tr class="trOption" name="trOption">';
        addOption+='<th>&nbsp&nbsp옵션 내용</th>';
        addOption+='<td><input type="text"></td>';
        addOption+='<th>추가 요금</th>';
        addOption+='<td><input type="text"><button class="btn btn-success delBtn" name="delBtn" onclick="">삭제</button></td>';
        addOption+='</tr>';

   		$("#insert-table").append(addOption);
	});
    
	//옵션 삭제 
	$(document).on("click","button[name=delBtn]",function(){

	    var trHtml=$(this).parent().parent();
	    trHtml.remove();
	});
	
	//이미지 업로드 
	$(function(){
		   //div 클릭시 파일업로드실행함수 실행
		   $("#1,#2,#3,#4,#5,#6").on("click",e=>{
			  
			   $(e.target).next().click();
		   });
		   //파일 업로드시 이미지 체인지
		   $("#input1,#input2,#input3,#input4,#input5,#input6").on("change",e =>{ 
			   console.log(e.target);
			   console.log($(e.target).prev().attr("src"));
			 
		      let reader=new FileReader();
		      let img=  $(e.target).prev();
		      reader.onload=e=>{
		       
		       img.attr("src",e.target.result); 
		      }
		      reader.readAsDataURL($(e.target)[0].files[0]);
		   }); 
	});
	
	//이미지 삭제 버튼
	$(function(){
		$(".close").on("click",e=>{	  
			   let chImg=$(e.target).prev().prev();
			   chImg.attr("src","${path }/resources/images/product/plus2.png");
		   });
	});
</script>
	
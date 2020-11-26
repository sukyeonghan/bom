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
	/*상품 수정,삭제페이지로 넘어가는 a태그 */
	/*클릭 안 했을 때*/
	.product-update:link{
		text-decoration:none;
		color:#45A663;
	}
	/*방문했을 때*/
	.product-update:visited{
		text-decoration:none;
		color:#45A663;
	}
	/*마우스 올렸을 때*/
	.product-update:hover{
		text-decoration:none;
		color:black;
	}
	/*상품등록 버튼*/
	#insertPro{
		float:right;
	}
	
    /*상품 설명*/
    .title{
    	font-weight:bold;
    }
    #intro-text{
    	resize:none;
    }
    #middle-div{
    	margin-left:15px;
    	margin-bottom:20px;
    }
    #bottom-div{
    	margin-left:15px;
    }
    /*썸네일 등록 div*/
    .proDiv{
    	border:1px solid black;
    	width:150px;
    	height:150px;
    	position:relative;
    }
    .proImg{
 		position:absolute;
        max-width:50%; 
        max-height:50%;
        width:auto; 
        height:auto;
        margin:auto;
        top:0; bottom:0; left:0; right:0;
    }
    /*상세 이미지 등록 div*/
    #detail-image{
    	margin-top:20px;
    	width:88%;
    }
    
    #bottom-btns{
    	text-align:center;
    	margin-top:100px;
    }
    /*옵션*/
    .trOption{
    	margin-left:10px;
    }
    /*옵션 삭제버튼*/
    .delBtn{
    	margin-left:10px;
    }
    .test{
    	display:flex;
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
			
			<form>
				<!-- 제품 등록 -->
				<table id="insert-table">
					<tr>
						<th>카테고리</th>
						<td colspan="3">
						<!-- 검색 카테고리 -->
							<div class="select-box">
								<select class="sort">
									<option>카테고리 선택</option>
									<option>식품</option>
									<option>잡화</option>
									<option>주방</option>
									<option>욕실</option>
									<option>여성용품</option>
									<option>반려동물</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th>상품명</th>
						<td><input type="text"></td>
						<th>상품기본가격</th>
						<td>
							<input type="text">
						</td>
					</tr>
					<tr>
						<th>이벤트</th>
							<td>
							<!-- 이벤트 카테고리 -->
								<div class="select-box">
									<select class="sort">
										<option>이벤트 선택</option>
									
									</select>
								</div>
							</td>
						<th>판매 상태</th>
						<td>
							<!-- 판매상태 카테고리 -->
							<div class="select-box">
								<select class="sort">
									<option>판매상태 선택</option>
									<option>Y</option>
									<option>N</option>
								</select>
							</div>
						</td>
					</tr>
					<!-- <tr>
						<th>추가 옵션</th>
						<td colspan="3"><button class="btn btn-success">옵션 추가하기</button></td>
					</tr>	 -->
					<tr>
                        <th>추가 옵션</th>
                        <td colspan="3"><input type="button" class="btn btn-success" id="add-option" value="옵션 추가하기"></td>
                        <!-- <button class="btn btn-success" id="add-option" name="addOption" onclick="">옵션 추가하기</button></td> -->
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
					<p class="title">제품 썸네일 이미지</p>
					
					<!-- <input type="file" class="form-control-file border" multiple id="proImage"> -->
					<input type="file" class="form-control-file border" id="upload" multiple>
					<div class="proDiv"> 
						<%-- <img src="${path }/resources/upload/product/plus.png" class="proImg" id=""  alt="기본" width="50" height="50"><br>  --%>
						 <img class="profile" id="img">
	
			     	</div>
			     	<!-- <input type="file" id="memPro" name="upload" accept="image/gif, image/jpeg, image/png" style="display:none;">  -->
		      		<div id="detail-image">
			      		<p class="title">제품 상세 이미지</p>
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
	
	//이지미 미리보기
/* 	var proImage;
	$(document).ready(function(){
		$("#proImage").on("change",fileSelect);
	});
	
	function fileSelect(e){
		var files= e.target.files;
		var filesArr=
	}
	 */
	
	$(document).ready(function (e){
	    $("input[type='file']").change(function(e){

	      //div 내용 비워주기
	      $('.proDiv').empty();

	      var files = e.target.files;
	      var arr =Array.prototype.slice.call(files);
	      
	      preview(arr);
	      
	    });
	    
	
	    
	    function preview(arr){
	      arr.forEach(function(f){
	        
	        //파일명이 길면 파일명...으로 처리
	       /*  var fileName = f.name;
	        if(fileName.length > 10){
	          fileName = fileName.substring(0,7)+"...";
	        } */
	        
	        //div에 이미지 추가
	        var str = '<div class="test" style="display:flex; padding: 10px;">';
	       /*  str += '<span>'+fileName+'</span><br>'; */
	        
	        //이미지 파일 미리보기
	        if(f.type.match('image.*')){
	          var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	          reader.onload = function (e) { //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
	            //str += '<button type="button" class="delBtn" value="'+f.name+'" style="background: red">x</button><br>';
	            str += '<img src="'+e.target.result+'" title="'+f.name+'" width=150 height=150 />';
	            str += '</div>';
	            $(str).appendTo('.proDiv');
	          } 
	          reader.readAsDataURL(f);
	        }
	      });
	    }
	  });
</script>
	
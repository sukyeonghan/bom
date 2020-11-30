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
<title>배송지 등록/수정</title>
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
<!-- daum 우편번호 서비스 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	header{
		width:100%;
		background-color: #45A663;
		color:white;
		text-align:center;
		padding: 10px;
		margin-bottom: 20px;
	}
	body{min-width:480px;}
	table{margin:auto;}
	th{width: 120px;}
	tr{height: 65px;}
	/*버튼 가운데정렬*/
	.red{color:red;}
	#sample4_postcode{display:inline-block; width:200px;}
	.phone{display:inline-block; width: 80px;}
	.btn-box{text-align: center;}
	.last-btns{width:150px; margin: 10px;} 
	.form-check-label{margin-left: 20px;}
	.form-check-input{margin-left: 3px;}
	
</style>

</head>
<body>
	<header>
		<h3>배송지 등록/수정</h3>
	</header>
	<section class="container">
		<c:if test="${ship == null }">
			<form name="shipFrm" action="${path }/ship/insertShipEnd">
		</c:if>
		<c:if test="${ship != null }">
			<form name="shipFrm2" action="${path }/ship/updateShipEnd">
		</c:if>
			<table>
				<tr>
					<th>배송지명 <span class="red">*</span></th>
					<td><input type="text" class="form-control" name="shipLocalName" value="${ship.shipLocalName }" required></td>
				</tr>
				<tr>
					<th>수령인 <span class="red">*</span></th>
					<td><input type="text" class="form-control" name="shipRecipient" value="${ship.shipRecipient }" required></td>
				</tr>
				<tr>
					<th>주소 <span class="red">*</span></th>
					<td>
						<input type="text" id="sample4_postcode" class="form-control input-sm" name="shipZipCode" placeholder="우편번호" value="${ship.shipZipCode }" readonly>
						<input type="button" onclick="sample4_execDaumPostcode()" class="btn btn-outline-success" 
							style="margin-bottom:6px;" value="주소검색">
						<input type="text" id="sample4_roadAddress" class="form-control input-sm" placeholder="도로명주소" name="shipAddress"  value="${ship.shipAddress }" readonly>
						<input type="hidden" id="sample4_jibunAddress" class="form-control input-sm" placeholder="지번주소">
						<span id="guide" style="color:#999;display:none"></span>
						<input type="text" id="sample4_detailAddress" class="form-control input-sm" name="shipDetailAddress" placeholder="상세주소를 입력해주세요" value="${ship.shipDetailAddress }">
						<input type="text" id="sample4_extraAddress" class="form-control input-sm" name="shipExtraAddress" placeholder="참고항목" value="${ship.shipExtraAddress }" readonly>
					</td>
				</tr>
				<tr>
					<th>연락처 <span class="red">*</span></th>
					<td>
					<c:forTokens items="${ship.shipPhone}" var="p" delims="-" varStatus="vs">
						<c:if test="${vs.index == 0 }">
							<c:set var="phone1" value="${p }"/>
						</c:if>
						<c:if test="${vs.index == 1 }">
							<c:set var="phone2" value="${p }"/>
						</c:if>
						<c:if test="${vs.index == 2 }">
							<c:set var="phone3" value="${p }"/>
						</c:if>
					</c:forTokens>
						<select name="phone1" id="phone1" class="form-control phone" required="required">
						    <option value=" " disabled selected>선택</option>
						    <option value="010" ${phone1 eq "010"? "selected":"" }>010</option>
						    <option value="011" ${phone1 eq "011"? "selected":"" }>011</option>
						    <option value="016" ${phone1 eq "016"? "selected":"" }>016</option>
						    <option value="017" ${phone1 eq "017"? "selected":"" }>017</option>
						    <option value="018" ${phone1 eq "018"? "selected":"" }>018</option>
						    <option value="019" ${phone1 eq "019"? "selected":"" }>019</option>
						    <option value="02"  ${phone1 eq "02"? "selected":"" }>02</option>
						    <option value="031" ${phone1 eq "031"? "selected":"" }>031</option>
						    <option value="032" ${phone1 eq "032"? "selected":"" }>032</option>
						    <option value="033" ${phone1 eq "033"? "selected":"" }>033</option>
						 <!--<option value="041" ${phone1 eq "041"? "selected":"" }>041</option>
						    <option value="042" ${phone1 eq "042"? "selected":"" }>042</option>
						    <option value="043" ${phone1 eq "043"? "selected":"" }>043</option>
						    <option value="044" ${phone1 eq "044"? "selected":"" }>044</option>
						    <option value="051" ${phone1 eq "051"? "selected":"" }>051</option>
						    <option value="052" ${phone1 eq "052"? "selected":"" }>052</option>
						    <option value="053" ${phone1 eq "053"? "selected":"" }>053</option>
						    <option value="054" ${phone1 eq "054"? "selected":"" }>054</option>
						    <option value="055" ${phone1 eq "055"? "selected":"" }>055</option>
						    <option value="061" ${phone1 eq "061"? "selected":"" }>061</option>
						    <option value="062" ${phone1 eq "062"? "selected":"" }>062</option>
						    <option value="063" ${phone1 eq "063"? "selected":"" }>063</option>
						    <option value="064" ${phone1 eq "064"? "selected":"" }>064</option>
						    <option value="070" ${phone1 eq "070"? "selected":"" }>070</option>
						    <option value="080" ${phone1 eq "080"? "selected":"" }>080</option>
						    <option value="050" ${phone1 eq "050"? "selected":"" }>050</option>
						    <option value="012" ${phone1 eq "012"? "selected":"" }>012</option>
						    <option value="059" ${phone1 eq "059"? "selected":"" }>059</option> -->
					  	</select>
					
					  	&nbsp;-&nbsp;<input type="text" class="form-control phone" name="phone2" value="${phone2 }" required>
						&nbsp;-&nbsp;<input type="text" class="form-control phone" name="phone3" value="${phone3 }" required>
						<input type="hidden" name="shipPhone"/>
					</td>
				</tr>
				<tr>
					<th>기본배송지</th>
					<td>
						<input type="checkbox" class="form-check-input" id="yn" name="shipYn" ${ship.shipYn eq "Y"?"checked":"" }>
						<label class="form-check-label" for="yn">기본배송지로 설정</label>
					</td>
				</tr>
			</table>
			<br>
			<div class="btn-box">
				<input type="hidden" name="shipNo" value="${ship.shipNo}"/>
				<input type="hidden" name="memNo" value="${loginMember.memNo }"/>
				<input type="button" class="btn btn-outline-success last-btns" value="닫기" onclick="self.close();"/>
				<input type="submit" class="btn btn-success last-btns" value="등록" onclick="return fn_check();">
			</div>
		</form>
	</section>
</body>
<script>

function fn_check(){	
	var phoneCheck =/^[0-9]*$/;
	var phone1 = $("select[name=phone1]>option:selected").val();
	var phone2 = $("input[name=phone2]").val();
	var phone3 = $("input[name=phone3]").val(); 
	var phone="";
	
	if(phone1==" "){
		alert("연락처를 확인해주세요.");
		return false;
	}
	
	if(!phoneCheck.test(phone2)){		
		alert("잘못된 연락처 형식입니다.[연락처 두번째칸]을 확인해주세요");
		return false;
	}
	
	if(!phoneCheck.test(phone3)){		
		alert("잘못된 연락처 형식입니다.[연락처 세번째칸]을 확인해주세요");
		return false;
		
	}else{
		
		phone=phone1+"-"+phone2+"-"+phone3;
	
		$("input[name=shipPhone]").val(phone);
		
		if($("input[name=shipAddress]").val().length<1){
			alert("주소를 입력해주세요");
			return false;
		} 
		
	}
	
};

	
	//우편번호, 주소검색
	function sample4_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var extraRoadAddr = ''; // 참고 항목 변수
	
	            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraRoadAddr += data.bname;
	            }
	            // 건물명이 있고, 공동주택일 경우 추가한다.
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	            if(extraRoadAddr !== ''){
	                extraRoadAddr = ' (' + extraRoadAddr + ')';
	            }
	
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('sample4_postcode').value = data.zonecode;
	            document.getElementById("sample4_roadAddress").value = roadAddr;
	            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	            
	            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	            if(roadAddr !== ''){
	                document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	            } else {
	                document.getElementById("sample4_extraAddress").value = '';
	            }
	
	            var guideTextBox = document.getElementById("guide");
	            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	            if(data.autoRoadAddress) {
	                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                guideTextBox.style.display = 'block';
	
	            } else if(data.autoJibunAddress) {
	                var expJibunAddr = data.autoJibunAddress;
	                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                guideTextBox.style.display = 'block';
	            } else {
	                guideTextBox.innerHTML = '';
	                guideTextBox.style.display = 'none';
	            }
	        }
	    }).open();
	}
</script>
</html>
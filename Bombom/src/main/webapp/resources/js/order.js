$(function(){$(".point").text(0)});



var ba;
//주소 api
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            var address=$(".address-detail").val();
            
            if(address.includes("서울")||address.includes("경기")){
            	ba=2500;
            }else if(address.includes("제주")||address.includes("강원")){
            	ba=7000;
            }else{
            	ba=5000;
            }

            var mileage =Number($(".point").html().replace(/,/g, "")); //총 할인 금액가져오기
            $(".deli").html(ba.toLocaleString());
            $(".total-pay").html((parseInt($(".total-price")[0].textContent.replace(/,/g, ""))+ba-mileage).toLocaleString());//상품총가격+배송비 최종가격
            $("#total").val((parseInt($(".total-price")[0].textContent.replace(/,/g, ""))+ba-mileage));
            $("#ba").val(ba);
            
            document.getElementById("sample6_detailAddress").focus(); 
        }
    }).open();
}


//결제 API
$(document).on("click",".payBtn",function(){
 	
	if($(".address-detail")[0].value==""||$(".address-detail")[1].value==""||$(".address-detail")[2].value==""){
		//0번 우편번호  1번 일반 주소  2번 상세주소
		alert("주소를 입력해주세요");
		return;
	}
		IMP.init('imp93954987');
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '주문명:카드결제',
		    amount : parseInt($(".")[0].textContent.replace(/,/g, "")),
		    buyer_email : $("#ordererEmail").value,
		    buyer_name : $("#orderer").value,
		    buyer_tel : $("#ordererPhone").value,
		    buyer_addr : $(".address-detail")[1].value+$(".address-detail")[2].value,
		    buyer_postcode : $(".zipCode").value,
		    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
		}	, function(rsp) {
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '고유ID : ' + rsp.imp_uid;
		        msg += '상점 거래ID : ' + rsp.merchant_uid;
		        msg += '결제 금액 : ' + rsp.paid_amount;
		        msg += '카드 승인번호 : ' + rsp.apply_num;
		        orderInfo.submit();
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		});

});

	//select box ID로 접근하여 선택된 값 읽기
	//$("#셀렉트박스ID option:selected").val();
	var prices = $(".pdtOnePrice").html(); //상품가격(할인됐으면 할인적용)
	var pNos = $(".pNo"); //상품번호
	var bNos = $(".bNo"); //장바구니번호
	var opNos = $(".opNo"); //상품옵션번호
	var removes = $(".remove"); //삭제버튼
	
	//text에 숫자만 입력할 수 있도록 하기
    function onlyNumber(event){
        event = event || window.event;
        var keyID = (event.which) ? event.which : event.keyCode;
        if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
            return;
        else
            return false;
    }
    //text에 글자 입력 못하게하기
    function removeChar(event) {
        event = event || window.event;
        var keyID = (event.which) ? event.which : event.keyCode;
        if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
            return;
        else
            event.target.value = event.target.value.replace(/[^0-9]/g, "");
    }
	
	//장바구니 상품삭제하기
	function fn_delete(pdtNo, basketNo,memNo){
		console.log("삭제");
		var no = {"pdtNo":pdtNo, "basketNo":basketNo,"memNo":memNo};
		var url = "${path}/order/deleteBasketOne";
		var ck = confirm("삭제하시겠습니까?");
		if(ck){
			window.location = url + "?" + $.param(no);
		}
	}
	
	
	
	
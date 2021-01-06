package com.kh.bom.order.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Order {
	private String orderNo; //주문한날짜+랜덤번호6~8자리 부여 EX)20201114-******** not null
	private String memNo; //회원번호 
	private int ordAmount; //총금액 not null
	private int ordUsePoint; //사용적립금
	private String ordZipcode; //우편번호
	private String ordAddr; //도로명주소
	private String ordDetailAddr; //상세주소
	private String ordExtraAddr; //참고주소
	private long ordTrack; //운송장
	private String ordMemo; //배송메모
	private int ordDeliPrice; //배송비
	private String ordConfirmYn; //구매확정여부
	private String ordStatus;//배송상태 //('주문대기','주문완료','배송준비','배송중','배송완료','주문취소','취소완료')
	private String ordCancel; //취소사유 //단순변심','상품불량','배송지연','상품정보와 상이
	private Date ordDate;//주문날짜
	private String ordOname;//주문자이름
	private String ordOphone;//주문자 전화번호
	private String ordRname;//받는사람 이름
	private String ordRphone;//받는사람 전화번호
	private String ordMngMemo;//관리자메모
	//-------원래 order table ---------------------
	private String pdtThumbImage; //상품이미지
	private String pdtName; //상품명
	private String pdtOptionContent; //상품옵션
	private int inorderQty; //상품수량
	private int pdtPrice; //상품가격 
	private String memEmail; //주문자 이메일
	private int pdtOptionAddprice; //옵션 가격 
	private String pdtNo; //상품번호 
	private String pdtOptionNo;//상품옵션번호
	private String rownum;
	private String revYn;//구매평작성여부
	private String revContent;//구매평



	
}

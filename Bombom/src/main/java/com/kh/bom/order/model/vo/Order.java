package com.kh.bom.order.model.vo;

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
	private String ordDetailAddr; //상세주소
	private String ordExtraAddr; //참고주소
	private int ordTrack; //운송장
	private String ordMemo; //배송메모
	private int ordDeliPrice; //배송비
	private String ordConfirmYn; //구매확정여부
	private String ordStatus;//배송상태 //('주문대기','주문완료','배송준비','배송중','배송완료','주문취소','취소완료')
	private String ordCancel; //취소사유 //단순변심','상품불량','배송지연','상품정보와 상이
}

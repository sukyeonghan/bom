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
	private String ordDeliAddr; //배송지 not null
	private String ordMemo; //배송메모
	private int ordDeliPrice; //배송비
	private String ordStatus;//배송상태 //('주문대기','주문완료','배송준비','배송중','배송완료','주문취소','취소완료')
}

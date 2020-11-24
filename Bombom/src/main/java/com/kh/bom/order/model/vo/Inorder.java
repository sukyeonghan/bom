package com.kh.bom.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Inorder {
	private String orderNo; //주문번호
	private String pdtNo; //상품번호 
	private String pdtOptionNo;//상품옵션번호
	private int inorderQty; //상품갯수
}

package com.kh.bom.order.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Basket {
	private String basketNo;
	private String memNo;
	private String pdtNo;
	private String pdtOptionNo;
	private int inbasQty;
	private String pdtName;
	private String pdtThumbImage;
	private String pdtOptionContent;
	private int pdtPrice;
	private int pdtOptionAddprice;
	private int salePer; //이벤트 할인율
	
}

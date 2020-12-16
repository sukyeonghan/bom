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
public class Inbasket {
	private String pdtNo;
	private String basketNo;
	private String pdtOptionNo;
	private int inbasQty;
	//상품정보가져오기 위한 VO
	private String pdtCategory;
	private int pdtPrice;
	private String pdtName;
	private String pdtIntro;
	private String pdtStatus;
	private Date pdtDate;
	private String pdtDetailImage;
	private String eventNoRef;
	private String pdtOptionContent;
	private int pdtOptionAddprice;
	private String thumbs;
	private int salePer;
	private String pdtThumbNo;
	private String pdtThumbImage;
}

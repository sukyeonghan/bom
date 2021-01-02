package com.kh.bom.product.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product {
	
	private String pdtNo;
	private String pdtCategory;
	private int pdtPrice;
	private String pdtName;
	private String pdtIntro;
	private String pdtStatus;
	private Date pdtDate;
	private String pdtDetailImage;
	private String eventNoRef;
	private String pdtOptionNo;
	private String pdtOptionContent;
	private int pdtOptionAddprice;
	private String thumbs;
	private int salePer;
	private String pdtThumbNo;
	private String pdtThumbImage;
	private int zzimCount;
	private int reviewCount;
	private String[] category;
	private String sort;
	private String star;
	private String soldout;
	private int fromPrice;
	private int toPrice;
	private String pdtReviewAvg;
	private int totCnt;
	private String newYn;
}

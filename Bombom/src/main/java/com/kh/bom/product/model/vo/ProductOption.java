package com.kh.bom.product.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductOption {
	
	private String pdtOptionNo;
	private String pdtNo;
	private String pdtOptionContent;
	private int pdtOptionAddprice;
	private String pdtOptionStatus;
}

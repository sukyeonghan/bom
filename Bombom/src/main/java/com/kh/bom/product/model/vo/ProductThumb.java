package com.kh.bom.product.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ProductThumb {
	
	private String pdtThumbNo;
	private String pdtNo;
	private String pdtThumbImage;
	private String originalFileName;
	private String renamedFileName;
}

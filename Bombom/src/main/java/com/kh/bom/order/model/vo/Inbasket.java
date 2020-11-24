package com.kh.bom.order.model.vo;

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
}

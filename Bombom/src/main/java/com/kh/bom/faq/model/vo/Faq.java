package com.kh.bom.faq.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Faq {
	private String faqNo;
	private String faqCategory;
	private String faqTitle;
	private String faqContent;
	private int rownum;
}

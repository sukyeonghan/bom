package com.kh.bom.faq.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Faq {
	String faqNo;
	String faqCategory;
	String faqTitle;
	String faqContent;
	
}

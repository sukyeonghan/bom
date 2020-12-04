package com.kh.bom.inquiry.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Inquiry {
	
	private String inqNo;
	private String pdtNo;
	private String memNo;
	private String inqContent;
	private Date inqDate;
	private String inqSecret;
	private String inqAnswerYn;
	private String inqAnswer;
	private Date inqAnswerDate;
	private String memNick;
	private String memManagerYn;
	

}

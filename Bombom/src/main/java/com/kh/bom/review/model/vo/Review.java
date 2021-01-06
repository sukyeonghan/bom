package com.kh.bom.review.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {
	
	private String revNo;
	private String pdtNo;
	private String memNo;
	private String orderNo;
	private int revScore;
	private String revContent;
	private String revImage;
	private Date revDate;
	private String memNick;
	private String memPro;
	private String pdtName;
	private String revYn;
	private String revDeleteYn;
}

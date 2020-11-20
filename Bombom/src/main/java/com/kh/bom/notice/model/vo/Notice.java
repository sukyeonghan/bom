package com.kh.bom.notice.model.vo;

import java.sql.Date;

import com.kh.bom.faq.model.vo.Faq;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Notice {
	
	private String noticeNo;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeDate;
	
	

}

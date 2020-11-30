package com.kh.bom.admin.model.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Event {
	private String eventNo;
	private String eventTitle;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date eventStartDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date eventEndDate;
	private String eventCategory;
	private int eventSalePer;
}

package com.kh.bom.admin.model.vo;

import java.util.Date;

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
	private Date eventStartDate;
	private Date eventEndDate;
	private String eventCategory;
	private int eventSalePer;
}

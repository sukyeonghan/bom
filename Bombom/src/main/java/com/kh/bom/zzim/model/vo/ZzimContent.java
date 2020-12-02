package com.kh.bom.zzim.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ZzimContent {
	private String pdtNo;
	private String zzimNo;
	private Date zzimDate;
}

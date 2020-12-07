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
	private String zzimPdtName; //제품이름
	private String zzimPdtImage; //제품이미지
	private String zzimContentNo; //콘텐츠별 고유번호
}

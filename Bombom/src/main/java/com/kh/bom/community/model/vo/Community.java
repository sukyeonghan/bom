package com.kh.bom.community.model.vo;

import java.sql.Date;

import com.kh.bom.community.model.vo.Community;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Community {
	
	private String cmNo;
	private String cmWriter;
	private int cmLike;
	private int cmView;
	private Date cmDate;
	private String cmTitle;
	private String cmContent;
	private String cmThumbnail;
	
 
}

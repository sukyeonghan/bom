package com.kh.bom.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class MainBanner {
	private String bannerNo;
	private String pdtNo;
	private String bannerTitle;
	private String bannerSubtitle;
	private String bannerThumb;
}

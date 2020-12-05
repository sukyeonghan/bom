package com.kh.bom.zzim.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Zzim {
	private String zzimNo;
	private String memNo;
	private String zzimName;
	private String zzimContentCount;//찜상품갯수
	private String zzimFolderImg;//찜폴더이미지
}

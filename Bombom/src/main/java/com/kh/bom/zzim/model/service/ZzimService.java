package com.kh.bom.zzim.model.service;

import java.util.List;

import com.kh.bom.zzim.model.vo.Zzim;
import com.kh.bom.zzim.model.vo.ZzimContent;

public interface ZzimService {

	List<Zzim> selectZzimList(String memNo);

	int insertZzim(Zzim z);

	List<ZzimContent> selectZzimContentList(String zzimNo);

	int deleteZzim(List<String> zzimNoList);

	String selectSeqZzimNo();

	


}

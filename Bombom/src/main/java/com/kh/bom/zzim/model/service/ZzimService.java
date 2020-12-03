package com.kh.bom.zzim.model.service;

import java.util.List;

import com.kh.bom.zzim.model.vo.Zzim;

public interface ZzimService {

	List<Zzim> selectZzimList(String memNo);

	int insertZzim(Zzim z);


}

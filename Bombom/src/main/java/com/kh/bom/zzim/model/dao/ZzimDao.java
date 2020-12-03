package com.kh.bom.zzim.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.zzim.model.vo.Zzim;

public interface ZzimDao {

	List<Zzim> selectZzimList(SqlSession session, String memNo);

	int insertZzim(SqlSession session, Zzim z);

}

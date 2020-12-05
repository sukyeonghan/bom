package com.kh.bom.zzim.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.zzim.model.vo.Zzim;
import com.kh.bom.zzim.model.vo.ZzimContent;

public interface ZzimDao {

	List<Zzim> selectZzimList(SqlSession session, String memNo);

	int insertZzim(SqlSession session, Zzim z);

	List<ZzimContent> selectZzimContentList(SqlSession session,String zzimNo);

	int deleteZzim(SqlSession session, List<String> zzimNoList);

	String selectSeqZzimNo(SqlSession session);

}

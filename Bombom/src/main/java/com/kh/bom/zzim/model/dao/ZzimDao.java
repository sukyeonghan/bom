package com.kh.bom.zzim.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.zzim.model.vo.Zzim;
import com.kh.bom.zzim.model.vo.ZzimContent;

public interface ZzimDao {

	List<Zzim> selectZzimList(SqlSession session, String memNo);

	int insertZzim(SqlSession session, Zzim z);

	List<ZzimContent> selectZzimContentList(SqlSession session,String zzimNo);

	int deleteZzim(SqlSession session, List<String> zzimNoList);

	String selectSeqZzimNo(SqlSession session);

	int updateZzimName(SqlSession session, Zzim zzim);

	int deleteZzimOne(SqlSession session, String zzimNo);

	int deleteZzimContent(SqlSession session, List<String> pdtNoList);

	Zzim selectZzimOne(SqlSession session, String zzimNo);

	int updateZzimNo(SqlSession session, Map map);
	
	int proInsertZzim(SqlSession session, Zzim z);
	
	int proInsertZzimContent(SqlSession session, Map map);
	
	List selectfavlist(SqlSession session, String zzimNo);
	
	int proDeleteZzim(SqlSession session, Map map);
	
	List selectFavPdtList(SqlSession session, String memNo);

}

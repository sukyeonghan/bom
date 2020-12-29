package com.kh.bom.zzim.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.zzim.model.vo.Zzim;
import com.kh.bom.zzim.model.vo.ZzimContent;

@Repository
public class ZzimDaoImpl implements ZzimDao {

	@Override
	public List<Zzim> selectZzimList(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectList("zzim.selectZzimList",memNo);
	}

	@Override
	public int insertZzim(SqlSession session, Zzim z) {
		// TODO Auto-generated method stub
		return session.insert("zzim.insertZzim",z);
	}

	@Override
	public List<ZzimContent> selectZzimContentList(SqlSession session, String zzimNo) {
		// TODO Auto-generated method stub
		return session.selectList("zzim.selectZzimContentList",zzimNo);
	}

	@Override
	public int deleteZzim(SqlSession session, List<String> zzimNoList) {
		// TODO Auto-generated method stub
		return session.delete("zzim.deleteZzim", zzimNoList);
	}

	@Override
	public String selectSeqZzimNo(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("zzim.selectSeqZzimNo");
	}

	@Override
	public int updateZzimName(SqlSession session, Zzim zzim) {
		// TODO Auto-generated method stub
		return session.update("zzim.updateZzimName", zzim);
	}

	@Override
	public int deleteZzimOne(SqlSession session, String zzimNo) {
		// TODO Auto-generated method stub
		return session.delete("zzim.deleteZzimOne",zzimNo);
	}

	@Override
	public int deleteZzimContent(SqlSession session, List<String> pdtNoList) {
		// TODO Auto-generated method stub
		return session.delete("zzim.deleteZzimContent", pdtNoList);
	}

	@Override
	public Zzim selectZzimOne(SqlSession session, String zzimNo) {
		// TODO Auto-generated method stub
		return session.selectOne("zzim.selectZzimOne", zzimNo);
	}

	@Override
	public int updateZzimNo(SqlSession session, Map map) {
		// TODO Auto-generated method stub
		return session.update("zzim.updateZzimNo",map);
	}

	@Override
	public int proInsertZzim(SqlSession session, Zzim z) {
		return session.insert("zzim.proInsertZzim", z);
	}

	@Override
	public int proInsertZzimContent(SqlSession session, Map map) {
		return session.insert("zzim.proInsertZzimContent", map);
	}

	@Override
	public List selectfavlist(SqlSession session, String zzimNo) {
		return session.selectList("zzim.selectfavlist", zzimNo);
	}

	
	
	
	
	
	
}

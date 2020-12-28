package com.kh.bom.zzim.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.zzim.model.dao.ZzimDao;
import com.kh.bom.zzim.model.vo.Zzim;
import com.kh.bom.zzim.model.vo.ZzimContent;
@Service
public class ZzimServiceImpl implements ZzimService {
	@Autowired
	private SqlSession session;
	
	@Autowired
	private ZzimDao dao;

	@Override
	public List<Zzim> selectZzimList(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectZzimList(session,memNo);
	}

	@Override
	public int insertZzim(Zzim z) {
		// TODO Auto-generated method stub
		return dao.insertZzim(session,z);
	}

	@Override
	public List<ZzimContent> selectZzimContentList(String zzimNo) {
		// TODO Auto-generated method stub
		return dao.selectZzimContentList(session,zzimNo);
	}

	@Override
	public int deleteZzim(List<String> zzimNoList) {
		// TODO Auto-generated method stub
		return dao.deleteZzim(session,zzimNoList);
	}

	@Override
	public String selectSeqZzimNo() {
		// TODO Auto-generated method stub
		return dao.selectSeqZzimNo(session);
	}

	@Override
	public int updateZzimName(Zzim zzim) {
		// TODO Auto-generated method stub
		return dao.updateZzimName(session,zzim);
	}

	@Override
	public int deleteZzimOne(String zzimNo) {
		// TODO Auto-generated method stub
		return dao.deleteZzimOne(session,zzimNo);
	}

	@Override
	public int deleteZzimContent(List<String> pdtNoList) {
		// TODO Auto-generated method stub
		return dao.deleteZzimContent(session,pdtNoList);
	}

	@Override
	public Zzim selectZzimOne(String zzimNo) {
		// TODO Auto-generated method stub
		return dao.selectZzimOne(session,zzimNo);
	}

	@Override
	public int updateZzimNo(Map map) {
		// TODO Auto-generated method stub
		return dao.updateZzimNo(session,map);
	}

	@Override
	public int proInsertZzim(Zzim z) {
		return dao.proInsertZzim(session, z);
	}

	@Override
	public int proInsertZzimContent(Map map) {
		return dao.proInsertZzimContent(session, map);
	}

	@Override
	public List<Zzim> selectzzimlovelist(String memNo) {
		return dao.selectzzimlovelist(session, memNo);
	}

	@Override
	public int proInsertZzim2(Zzim z) {
		return dao.proInsertZzim2(session, z);
	}

	@Override
	public List selectfavlist(String zzimNo) {
		return dao.selectfavlist(session, zzimNo);
	}
	
	
	
	
}

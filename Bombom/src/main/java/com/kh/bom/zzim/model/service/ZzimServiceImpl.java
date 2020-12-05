package com.kh.bom.zzim.model.service;

import java.util.List;

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
	
	
	
	
}

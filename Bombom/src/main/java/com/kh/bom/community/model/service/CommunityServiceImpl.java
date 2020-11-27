package com.kh.bom.community.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.community.model.dao.CommunityDao;
import com.kh.bom.community.model.vo.Community;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao dao;
	@Autowired
	private SqlSession session;
	
	
	@Override
	public int insertCommunity(Community community) {
		// TODO Auto-generated method stub
		return dao.insertCommunity(session,community);
	}


	@Override
	public List<Community> selectCommunityList() {
		// TODO Auto-generated method stub
		return dao.selectCommunityList(session);
	}


	@Override
	public Community selectCommunityOne(String cmNo) {
		// TODO Auto-generated method stub
		return dao.selectCommunityOne(session,cmNo);
	}


	@Override
	public int deleteCommunity(String cmNo) {
		// TODO Auto-generated method stub
		return dao.deleteCommunity(session,cmNo);
	}


	@Override
	public int updateCommunity(Community community) {
		// TODO Auto-generated method stub
		return dao.updateCommunity(session,community);
	}
	
	

	

}

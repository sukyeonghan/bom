package com.kh.bom.community.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.community.model.vo.Community;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	@Override
	public int insertCommunity(SqlSession session, Community community) {
		// TODO Auto-generated method stub
		return session.insert("community.insertCommunity",community);
	}

	@Override
	public List<Community> selectCommunityList(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("community.selectCommunityList");
	}

	@Override
	public Community selectCommunityOne(SqlSession session, String cmNo) {
		// TODO Auto-generated method stub
		return session.selectOne("community.selectCommunityOne",cmNo);
	}

	@Override
	public int deleteCommunity(SqlSession session, String cmNo) {
		// TODO Auto-generated method stub
		return session.delete("community.deleteCommunity",cmNo);
	}

	@Override
	public int updateCommunity(SqlSession session, Community community) {
		// TODO Auto-generated method stub
		return session.update("community.updateCommunity",community);
	}

	@Override
	public int communityView(SqlSession session, String cmNo) {
		// TODO Auto-generated method stub
		return session.update("community.communityView",cmNo);
	}

	
	

	
}

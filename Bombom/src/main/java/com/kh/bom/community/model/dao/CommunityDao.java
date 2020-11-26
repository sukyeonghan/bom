package com.kh.bom.community.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.community.model.vo.Community;

public interface CommunityDao {
	
	int insertCommunity(SqlSession session,Community community);
	
	List<Community> selectCommunityList(SqlSession session);

	Community selectCommunityOne(SqlSession session,String cmNo);
	
	int deleteCommunity(SqlSession session, String cmNo);
	
	int updateCommunity(SqlSession session, Community community);
}

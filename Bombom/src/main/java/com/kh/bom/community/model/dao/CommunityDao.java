package com.kh.bom.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;

public interface CommunityDao {

	int insertCommunity(SqlSession session, Community community);

	List<Community> selectCommunityList(SqlSession session, int cPage, int numPerpage);

	int selectCount(SqlSession session);

	Community selectCommunityOne(SqlSession session, String cmNo);

	int deleteCommunity(SqlSession session, String cmNo);

	int updateCommunity(SqlSession session, Community community);

	int communityView(SqlSession session, String cmNo);
	
	 List<BoardReply> getReplyList(SqlSession session,Map<String, Object> paramMap);

	int regReply(SqlSession session,Map<String, Object> paramMap);

	int delReply(SqlSession session,Map<String, Object> paramMap);

	boolean checkReply(SqlSession session,Map<String, Object> paramMap);

	boolean updateReply(SqlSession session,Map<String, Object> paramMap);

	String selectSeqReply(SqlSession session);

	BoardReply selectBoardReplyOne(SqlSession session, String number);
	
	
	
	
	

}

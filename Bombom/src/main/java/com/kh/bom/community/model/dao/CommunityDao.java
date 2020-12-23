package com.kh.bom.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;

public interface CommunityDao {

	int insertCommunity(SqlSession session, Community community);

	List<Community> selectCommunityList(SqlSession session, int cPage, int numPerpage,Map m);

	int selectCount(SqlSession session);

	Community selectCommunityOne(SqlSession session, String cmNo);

	int deleteCommunity(SqlSession session, String cmNo);

	int updateCommunity(SqlSession session, Community community);

	int communityView(SqlSession session, String cmNo);
	
	 List<BoardReply> getReplyList(SqlSession session,Map<String, Object> paramMap);

	int regReply(SqlSession session,Map<String, Object> paramMap);

	int deleteReply(SqlSession session,String reply_id);


	String selectSeqReply(SqlSession session);

	BoardReply selectBoardReplyOne(SqlSession session, String number);

	int updateCount(SqlSession session,Map<String,Object> map);
	
	int selectLikeCount(SqlSession session,String cmNo);
	
	int updateLikeNo(SqlSession session,Map<String,Object> map);
	
	int deleteLikeNo(SqlSession session,Map<String,Object> map);

	int reportReply(SqlSession session,BoardReply reply);

	
	
	

}

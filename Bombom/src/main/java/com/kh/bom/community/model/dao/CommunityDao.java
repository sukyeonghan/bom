package com.kh.bom.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.vo.Member;

public interface CommunityDao {

	int insertCommunity(SqlSession session, Community community);

	List<Community> selectCommunityList(SqlSession session, int cPage, int numPerpage,Map m);

	int selectCount(SqlSession session);

	Community selectCommunityOne(SqlSession session, String cmNo);

	int deleteCommunity(SqlSession session, String cmNo);

	int updateCommunity(SqlSession session, Community community);

	int communityView(SqlSession session, String cmNo);
	
	//댓글 목록 불러오기
	 List<BoardReply> getReplyList(SqlSession session,String cmNo);
	 
	 BoardReply getChildReplyList(SqlSession session, String reply_id);

	int insertReply(SqlSession session,BoardReply br);
	
	//대댓글 입력하기
	int insertReReply(SqlSession session,BoardReply br);

	int deleteReply(SqlSession session,BoardReply br);


	String selectSeqReply(SqlSession session);

	BoardReply selectBoardReplyOne(SqlSession session, String number);

	int updateCount(SqlSession session,Map<String,Object> map);
	
	int selectLikeCount(SqlSession session,String cmNo);
	
	int updateLikeNo(SqlSession session,Map<String,Object> map);
	
	int deleteLikeNo(SqlSession session,Map<String,Object> map);

	int reportReply(SqlSession session,BoardReply reply);

	Member selectLikeNo(SqlSession session,String memNo);
	
	

}

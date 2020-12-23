package com.kh.bom.community.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.vo.Member;

public interface CommunityService{

	int insertCommunity(Community community);

	List<Community> selectCommunityList(int cPage, int numPerpage);

	int selectCount();

	Community selectCommunityOne(String cmNo);

	int deleteCommunity(String cmNo);

	int updateCommunity(Community community);

	int communityView(String cmNo);
	

	List<BoardReply> getReplyList(Map<String, Object> paramMap);
	
	int regReply(Map<String, Object> paramMap);

	boolean checkReply(Map<String, Object> paramMap);

	boolean updateReply(Map<String, Object> paramMap);

	int delReply(Map<String, Object> paramMap);
	
	String selectSeqReply();

	BoardReply selectBoardReplyOne(String number);
	
	//좋아요 업데이트
	int insertLike(Member m,String cmNo,int likeCount,int value);
	//바뀐 좋아요 수
	int selectLikeCount(String cmNo);
	//좋아요한 글인지 체크
	//boolean checkLike(Member m);
}

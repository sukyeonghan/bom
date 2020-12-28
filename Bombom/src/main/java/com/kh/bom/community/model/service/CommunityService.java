package com.kh.bom.community.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.vo.Alarm;
import com.kh.bom.member.model.vo.Member;

public interface CommunityService{

	int insertCommunity(Community community);

	List<Community> selectCommunityList(int cPage, int numPerpage, Map m);

	int selectCount();

	Community selectCommunityOne(String cmNo);

	int deleteCommunity(String cmNo);

	int updateCommunity(Community community);

	int communityView(String cmNo);
	
	List<BoardReply> getReplyList(Map<String, Object> paramMap);
	
	int regReply(Map<String, Object> paramMap);

	int deleteReply(String reply_id);
	
	String selectSeqReply();

	BoardReply selectBoardReplyOne(String number);
	
	int reportReply(BoardReply reply);

	//좋아요 업데이트
	int insertLike(Member m,String cmNo,int likeCount,int value,Alarm a);
	//바뀐 좋아요 수
	int selectLikeCount(String cmNo);
	//좋아요한 글인지 체크
	Member selectLikeNo(String memNo);

}

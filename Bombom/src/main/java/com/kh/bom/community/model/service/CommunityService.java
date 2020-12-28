package com.kh.bom.community.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.vo.Member;

public interface CommunityService{

	int insertCommunity(Community community);

	List<Community> selectCommunityList(int cPage, int numPerpage, Map m);

	int selectCount();

	Community selectCommunityOne(String cmNo);

	int deleteCommunity(String cmNo);

	int updateCommunity(Community community);

	int communityView(String cmNo);
	
	//댓글 목록
	List<BoardReply> getReplyList(String cmNo);
	
	//insert update delete 는 반환은 int, 값을 받을때는 매개변수 형태에 (자료형, 변수명)
	int insertReply(BoardReply br); 
	
	//대댓글 등록
	int insertReReply(BoardReply br);

	int deleteReply(BoardReply br);
	
	String selectSeqReply();

	BoardReply selectBoardReplyOne(String number);
	
	int reportReply(BoardReply reply);

	//좋아요 업데이트
	int insertLike(Member m,String cmNo,int likeCount,int value);
	//바뀐 좋아요 수
	int selectLikeCount(String cmNo);
	//좋아요한 글인지 체크
	Member selectLikeNo(String memNo);

}

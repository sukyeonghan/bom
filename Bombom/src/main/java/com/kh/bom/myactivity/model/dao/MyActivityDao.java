package com.kh.bom.myactivity.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.review.model.vo.Review;
public interface MyActivityDao {

	List<Review> selectReviewList(SqlSession session, String memNo, int cPage, int numPerpage);

	int selectReviewCount(SqlSession session, String memNo);

	List<Community> selectComList(SqlSession session, String memNo, int cPage, int numPerpage);

	int selectComCount(SqlSession session, String memNo);

	List<BoardReply> selectReplyList(SqlSession session, String memNo, int cPage, int numPerpage);

	int selectReplyCount(SqlSession session, String memNo);

	int deleteMyReview(SqlSession session, List<String> revNo);

	int deleteMyCommunity(SqlSession session, List<String> cmNo);

	int deleteMyReply(SqlSession session, List<String> replyNo);
	
	

}

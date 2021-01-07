package com.kh.bom.myactivity.model.service;

import java.util.List;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.review.model.vo.Review;

public interface MyActivityService {

	List<Review> selectReviewList(String memNo, int cPage, int numPerpage);

	int selectReviewCount(String memNo);

	List<Community> selectComList(String memNo, int cPage, int numPerpage);

	int selectComCount(String memNo);

	List<BoardReply> selectReplyList(String memNo, int cPage, int numPerpage);

	int selectReplyCount(String memNo);

	int deleteMyReview(List<String> revNo);

	int deleteMyCommunity(List<String> cmNo);

	int deleteMyReply(List<String> replyNo);

}

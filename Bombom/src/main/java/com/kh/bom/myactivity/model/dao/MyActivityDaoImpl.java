package com.kh.bom.myactivity.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.review.model.vo.Review;

@Repository
public class MyActivityDaoImpl implements MyActivityDao {
	//구매평
	@Override
	public List<Review> selectReviewList(SqlSession session, String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("review.selectReviewList", memNo, new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int selectReviewCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("review.selectReviewCount",memNo);
	}
	//커뮤니티 
	@Override
	public List<Community> selectComList(SqlSession session, String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("community.selectComList",memNo, new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int selectComCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("community.selectComCount",memNo);
	}

	@Override
	public List<BoardReply> selectReplyList(SqlSession session, String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("community.selectMyReplyList",memNo,new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int selectReplyCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("community.selectMyReplyCount",memNo);
	}

	@Override
	public int deleteMyReview(SqlSession session, List<String> revNo) {
		// TODO Auto-generated method stub
		return session.update("review.deleteMyReview",revNo);
	}

	@Override
	public int deleteMyCommunity(SqlSession session, List<String> cmNo) {
		// TODO Auto-generated method stub
		return session.delete("community.deleteMyCommunity",cmNo);
	}

	@Override
	public int deleteMyReply(SqlSession session, List<String> replyNo) {
		// TODO Auto-generated method stub
		return session.delete("community.deleteMyReply",replyNo);
	}
	
	
	
	
}

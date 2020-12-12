package com.kh.bom.myactivity.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.community.model.vo.Community;
import com.kh.bom.review.model.vo.Review;
public interface MyActivityDao {

	List<Review> selectReviewList(SqlSession session, String memNo, int cPage, int numPerpage);

	int selectReviewCount(SqlSession session, String memNo);

	List<Community> selectComList(SqlSession session, String memNo, int cPage, int numPerpage);

}

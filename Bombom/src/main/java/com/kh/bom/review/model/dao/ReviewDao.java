package com.kh.bom.review.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.review.model.vo.Review;

public interface ReviewDao {
	
	int insertReview(SqlSession session, Review r);

}

package com.kh.bom.review.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.order.model.vo.Order;
import com.kh.bom.review.model.vo.Review;

public interface ReviewDao {
	
	List<Order> selectOrder(SqlSession session, Map map);
	
	int insertReview(SqlSession session, Review r);
	
	int deleteRevivew(SqlSession session, String revNo);
	
	int updateReview(SqlSession session, Review r);

}

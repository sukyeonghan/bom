package com.kh.bom.review.model.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.review.model.vo.Review;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Override
	public Order selectOneOrder(SqlSession session, Map map) {
		return session.selectOne("order.selectOneOrder", map);
	}

	@Override
	public int insertReview(SqlSession session, Review r) {
		return session.insert("review.insertReview", r);
	}

	@Override
	public int deleteRevivew(SqlSession session, String revNo) {
		return session.delete("review.deleteReview", revNo);
	}




}

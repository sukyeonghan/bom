package com.kh.bom.review.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.order.model.vo.Order;
import com.kh.bom.review.model.vo.Review;

public interface ReviewService {
	
	//구매평 등록 전 상품구입 확인
	List<Order> selectOrder(Map map);
	
	int insertReview(Review r) throws Exception;
	
	int deleteRevivew(String revNo);

	int updateReview(Review r);

}

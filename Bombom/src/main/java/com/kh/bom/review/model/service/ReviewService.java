package com.kh.bom.review.model.service;

import java.util.Map;

import com.kh.bom.order.model.vo.Order;
import com.kh.bom.review.model.vo.Review;

public interface ReviewService {
	
	//로그인 한 사람이 상품평작성하기 위해 먼저 구매했는지 확인 
	Order selectOneOrder(Map map);
	
	int insertReview(Review r) throws Exception;
	
	int deleteRevivew(String revNo);

}

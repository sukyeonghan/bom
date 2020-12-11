package com.kh.bom.review.model.service;

import com.kh.bom.review.model.vo.Review;

public interface ReviewService {
	
	int insertReview(Review r) throws Exception;
	
	int deleteRevivew(String revNo);

}

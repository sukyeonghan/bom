package com.kh.bom.myactivity.model.service;

import java.util.List;

import com.kh.bom.community.model.vo.Community;
import com.kh.bom.inquiry.model.vo.Inquiry;

public interface MyActivityService {

	List<Inquiry> selectReviewList(String memNo, int cPage, int numPerpage);

	int selectReviewCount(String memNo);

	List<Community> selectComList(String memNo, int cPage, int numPerpage);

}

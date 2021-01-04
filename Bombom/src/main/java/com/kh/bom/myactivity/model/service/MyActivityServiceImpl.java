package com.kh.bom.myactivity.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.community.model.vo.Community;
import com.kh.bom.review.model.vo.Review;
import com.kh.bom.myactivity.model.dao.MyActivityDao;

@Service
public class MyActivityServiceImpl implements MyActivityService {

	@Autowired
	private SqlSession session;
	
	@Autowired
	private MyActivityDao dao;
	
	//구매평
	@Override
	public List<Review> selectReviewList(String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectReviewList(session,memNo,cPage,numPerpage);
	}
	//구매평 페이지
	@Override
	public int selectReviewCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectReviewCount(session,memNo);
	}
	//내가 쓴 커뮤니티 글 (sm) 
	@Override
	public List<Community> selectComList(String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectComList(session,memNo,cPage,numPerpage);
	}
	//내가 쓴 커뮤글 페이징
	@Override
	public int selectComCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectComCount(session,memNo);
	}
	//구매평 ajax 
	@Override
	public List<Review> reviewList(String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.reviewList(session,memNo);
	}
	@Override
	public int reviewCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.reviewCount(session, memNo);
	}
	
	
	
	

	
}

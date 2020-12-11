package com.kh.bom.product.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.dao.ProductDao;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.review.model.vo.Review;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductDao dao;
	
	@Autowired
	private SqlSession session;

	@Override
	public List<Inquiry> inquiryList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.inquiryList(session,cPage,numPerpage);
	}

	@Override
	public int inquiryCount() {
		// TODO Auto-generated method stub
		return dao.inquiryCount(session);
	}
	
	@Override
	public List<Review> reviewList(int cPage, int numPerpage) {
		return dao.reviewList(session, cPage, numPerpage);
	}
	
	@Override
	public int reviewCount() {
		return dao.reviewCount(session);
	}

	@Override
	public int productAllCount() {
		// TODO Auto-generated method stub
		return dao.productAllCount(session);
	}
	
	@Override
	public int productCateCount(String category) {
		// TODO Auto-generated method stub
		return dao.productCateCount(session,category);
	}
	//전체 제품 출력
	@Override
	public List<Product> selectProductList(int cPage,int numPerPage,String sort) {
		// TODO Auto-generated method stub
		return dao.selectProductList(session,cPage,numPerPage,sort);
	}
	//카테고리별 제품 출력
	@Override
	public List<Product> cateProductList(String category) {
		// TODO Auto-generated method stub
		return dao.cateProductList(session,category);
	}
	//최신 등록 제품 리스트
	@Override
	public List<Product> selectNewList() {
		// TODO Auto-generated method stub
		return dao.selectNewList(session);
	}
	//카테고리별 신상품 리스트
	@Override
	public List<Product> selectNewCateList(String category) {
		// TODO Auto-generated method stub
		return dao.selectNewCateList(session,category);
	}



}

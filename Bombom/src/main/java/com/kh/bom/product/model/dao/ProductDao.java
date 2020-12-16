package com.kh.bom.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.review.model.vo.Review;

public interface ProductDao {
	
	Product selectProductOne(SqlSession session, String pdtNo);
	
	List<Inquiry> inquiryList(SqlSession session,String pdtNo,int cPage,int numPerpage);
	
	int inquiryCount(SqlSession session);
	
	List<Review> reviewList(SqlSession session, int cPage, int numPerpage);
	
	int reviewCount(SqlSession session);

	int productCount(SqlSession session,String category);
	int countSale(SqlSession session);
	List<Product> selectProductList(SqlSession session,int cPage,int numPerPage,String sort,String category);
	List<Product> selectNewCateList(SqlSession session,String category);
	List<Product> selectSaleList(SqlSession session,int cPage,int numPerPage,String sort,String category);

}

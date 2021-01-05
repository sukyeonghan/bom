package com.kh.bom.product.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.review.model.vo.Review;

public interface ProductDao {
	
	Product selectProductOne(SqlSession session, String pdtNo);
	
	List<ProductOption> selectpdtOption(SqlSession session, String pdtNo);
	
	List<Inquiry> inquiryList(SqlSession session,String pdtNo,int cPage,int numPerpage);
	
	int inquiryCount(SqlSession session, String pdtNo);
	
	List<Review> reviewList(SqlSession session, String pdtNo, int cPage, int numPerpage);
	
	int reviewCount(SqlSession session, String pdtNo);
	
	String reviewAvg(SqlSession session, String pdtNo);
	
	Product selectproductDate(SqlSession session, String pdtNo);
	
	List<Product> slidelist(SqlSession session);


	List<Product> selectProductList(SqlSession session,int cPage,int numPerPage,Product p);
	int selectMaxPrice(SqlSession session, String category);
}

package com.kh.bom.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;

public interface ProductDao {
	
	List<Inquiry> inquiryList(SqlSession session,int cPage,int numPerpage);
	
	int inquiryCount(SqlSession session);

	int productAllCount(SqlSession session);
	int productCateCount(SqlSession session,String category);
	List<Product> selectProductList(SqlSession session);
	List<Product> cateProductList(SqlSession session,String category);
	List<Product> selectNewList(SqlSession session);
	List<Product> selectNewCateList(SqlSession session,String category);
}

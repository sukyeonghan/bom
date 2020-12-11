package com.kh.bom.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;

public interface ProductDao {
	
	List<Inquiry> inquiryList(SqlSession session,int cPage,int numPerpage);
	
	int inquiryCount(SqlSession session);

	int productCount(SqlSession session,String category);
	int countSale(SqlSession session);
	List<Product> selectProductList(SqlSession session,int cPage,int numPerPage,String sort,String category);
	List<Product> selectNewCateList(SqlSession session,String category);
	List<Product> selectSaleList(SqlSession session,int cPage,int numPerPage,String sort,String category);
}

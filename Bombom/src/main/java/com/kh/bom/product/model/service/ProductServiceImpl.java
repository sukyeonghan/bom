package com.kh.bom.product.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.dao.ProductDao;
import com.kh.bom.product.model.vo.Product;

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
	public int productAllCount() {
		// TODO Auto-generated method stub
		return dao.productAllCount(session);
	}
	
	@Override
	public int productCateCount(String category) {
		// TODO Auto-generated method stub
		return dao.productCateCount(session,category);
	}
	@Override
	public List<Product> cateProductList(String category) {
		// TODO Auto-generated method stub
		return dao.cateProductList(session,category);
	}
	
}

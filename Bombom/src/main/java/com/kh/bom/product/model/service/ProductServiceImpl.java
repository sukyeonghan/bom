package com.kh.bom.product.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.dao.ProductDao;

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

	
}

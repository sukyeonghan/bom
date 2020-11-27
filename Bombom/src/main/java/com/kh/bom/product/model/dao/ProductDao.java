package com.kh.bom.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.inquiry.model.vo.Inquiry;

public interface ProductDao {
	
	List<Inquiry> inquiryList(SqlSession session,int cPage,int numPerpage);
	
	int selectInquiryCount(SqlSession session);

}

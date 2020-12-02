package com.kh.bom.inquiry.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.inquiry.model.vo.Inquiry;

public interface InquiryDao {
	
	int insertInquiry(SqlSession session, Inquiry i);
	
	Inquiry selectInquiryOne(SqlSession session, String inqNo);
	

}

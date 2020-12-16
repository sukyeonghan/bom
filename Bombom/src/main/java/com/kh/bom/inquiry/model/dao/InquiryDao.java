package com.kh.bom.inquiry.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.inquiry.model.vo.Inquiry;

public interface InquiryDao {
	
	int insertInquiry(SqlSession session, Inquiry i);
	
	int insertInquiryAnswer(SqlSession session, Inquiry i);

	int deleteInquiry(SqlSession session, String inqNo);
	
	int deleteInquiryAnswer(SqlSession session, String inqNo);
	
	int updateInquiry(SqlSession session, Inquiry i);
	
	int updateInquiryAnswer(SqlSession session, Inquiry i);
}

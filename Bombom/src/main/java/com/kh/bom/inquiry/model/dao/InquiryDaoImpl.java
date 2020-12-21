package com.kh.bom.inquiry.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.inquiry.model.vo.Inquiry;

@Repository
public class InquiryDaoImpl implements InquiryDao {

	@Override
	public int insertInquiry(SqlSession session, Inquiry i) {
		return session.insert("inquiry.insertInquiry", i);
	}

	@Override
	public int insertInquiryAnswer(SqlSession session, Inquiry i) {
		return session.update("inquiry.insertInquiryAnswer",i);
	}

	@Override
	public int deleteInquiry(SqlSession session, String inqNo) {
		return session.delete("inquiry.deleteInquiry", inqNo);
	}

	@Override
	public int deleteInquiryAnswer(SqlSession session, String inqNo) {
		return session.update("inquiry.deleteInquiryAnswer", inqNo);
	}

	@Override
	public int updateInquiry(SqlSession session, Inquiry i) {
		return session.update("inquiry.updateInquiry", i);
	}

	@Override
	public int updateInquiryAnswer(SqlSession session, Inquiry i) {
		return session.update("inquiry.updateInquiryAnswer", i);
	}
	

}

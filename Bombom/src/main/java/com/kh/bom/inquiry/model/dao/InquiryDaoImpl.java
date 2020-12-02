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
	public Inquiry selectInquiryOne(SqlSession session, String inqNo) {
		return session.selectOne("inquiry.selectInquiryOne", inqNo);
	}


}

package com.kh.bom.inquiry.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.inquiry.model.dao.InquiryDao;
import com.kh.bom.inquiry.model.vo.Inquiry;

@Service
public class InquiryServiceImpl implements InquiryService {
	@Autowired
	private InquiryDao dao;
	
	@Autowired
	private SqlSession session;

	@Override
	public int insertInquiry(Inquiry i) {
		return dao.insertInquiry(session, i);
	}

	@Override
	public int insertInquiryAnswer(Inquiry i) {
		return dao.insertInquiryAnswer(session, i);
	}
	
	@Override
	public int deleteInquiry(String inqNo) {
		return dao.deleteInquiry(session, inqNo);
	}

	@Override
	public int deleteInquiryAnswer(String inqNo) {
		return dao.deleteInquiryAnswer(session, inqNo);
	}

	@Override
	public int updateInquiry(Inquiry i) {
		return dao.updateInquiry(session, i);
	}

	@Override
	public int updateInquiryAnswer(Inquiry i) {
		return dao.updateInquiryAnswer(session, i);
	}

	

}

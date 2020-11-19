package com.kh.bom.faq.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.faq.model.dao.FaqDao;
import com.kh.bom.faq.model.vo.Faq;

@Service
public class FaqServiceImpl implements FaqService {
	@Autowired
	private FaqDao dao;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Faq> selectFaqList(int cPage,int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectFaqList(session,cPage,numPerpage);
	}


	@Override
	public int selectFaqCount() {
		// TODO Auto-generated method stub
		return dao.selectFaqCount(session);
	}



	@Override
	public int insertFaq(Faq f) {
		// TODO Auto-generated method stub
		return dao.insertFaq(session,f);
	}

	@Override
	public int deleteFaq(String faqNo) {
		// TODO Auto-generated method stub
		return dao.deleteFaq(session,faqNo);
	}

	@Override
	public Faq selectFaqOne(String faqNo) {
		// TODO Auto-generated method stub
		return dao.selectFaqOne(session,faqNo);
	}

	@Override
	public int updateFaq(Faq f) {
		// TODO Auto-generated method stub
		return dao.updateFaq(session,f);
	}
	
	
}
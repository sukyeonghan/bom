package com.kh.bom.faq.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.faq.model.vo.Faq;

public interface FaqDao {
	List<Faq> selectFaqList(SqlSession session,int cPage,int numPerpage,String category);
		
	int selectFaqCount(SqlSession session,String category);
	
	int insertFaq(SqlSession session,Faq f);	
	
	int deleteFaq(SqlSession session,String faqNo);
	
	Faq selectFaqOne(SqlSession session,String faqNo);
	
	int updateFaq(SqlSession session, Faq f);
}

package com.kh.bom.faq.model.service;

import java.util.List;

import com.kh.bom.faq.model.vo.Faq;

public interface FaqService {
	
	List<Faq> selectFaqList(int cPage,int numPerpage,String category);
	
	int selectFaqCount(String category);
	
	int insertFaq(Faq f);
	
	int deleteFaq(String faqNo);
	
	Faq selectFaqOne(String faqNo);
	
	int updateFaq(Faq f);
	
	
}

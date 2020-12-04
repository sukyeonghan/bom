package com.kh.bom.inquiry.model.service;

import com.kh.bom.inquiry.model.vo.Inquiry;

public interface InquiryService {
	
	//상품문의 등록
	int insertInquiry(Inquiry i);
	
	//상품문의 상세보기
	Inquiry selectInquiryOne(String inqNo);
	
	//상품문의 모달창 답변등록
	int insertInquiryAnswer(Inquiry i);

}
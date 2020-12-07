package com.kh.bom.inquiry.model.service;

import com.kh.bom.inquiry.model.vo.Inquiry;

public interface InquiryService {
	
	//상품문의 등록
	int insertInquiry(Inquiry i);
	
	//상품문의 모달창 답변등록
	int insertInquiryAnswer(Inquiry i);
	
	//상품문의 삭제
	int deleteInquiry(String inqNo);
	
	//상품문의 답변삭제
	int deleteInquiryAnswer(String inqNo);
	
	//상품문의 수정
	int updateInquiry(Inquiry i);
	
	//상품문의 관리자답변 수정
	int updateInquiryAnswer(Inquiry i);

}

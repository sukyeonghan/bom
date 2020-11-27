package com.kh.bom.product.model.service;

import java.util.List;

import com.kh.bom.inquiry.model.vo.Inquiry;

public interface ProductService {
	
	List<Inquiry> inquiryList(int cPage, int numPerpage);
	
	int inquiryCount();
	
	

}

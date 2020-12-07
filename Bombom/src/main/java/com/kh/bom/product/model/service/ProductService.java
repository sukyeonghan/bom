package com.kh.bom.product.model.service;

import java.util.List;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;

public interface ProductService {
	
	List<Inquiry> inquiryList(int cPage, int numPerpage);
	
	int inquiryCount();
	
	int productAllCount();//전체 제품 개수
	int productCateCount(String category);//카테고리별 제품 개수
	List<Product> selectProductList();//전체 제품 출력
	List<Product> cateProductList(String category);//카테고리별 제품 출력

}

package com.kh.bom.product.model.service;

import java.util.List;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.review.model.vo.Review;

public interface ProductService {
	
	//상품문의
	List<Inquiry> inquiryList(int cPage, int numPerpage);
	
	//상품갯수
	int inquiryCount();
	
	//구매평
	List<Review> reviewList(int cPage, int numPerpage);
	
	//구매평 갯수
	int reviewCount();
	
	
	int productAllCount();//전체 제품 개수
	int productCateCount(String category);//카테고리별 제품 개수
	List<Product> selectProductList(int cPage,int numPerPage,String sort);//전체 제품 출력
	List<Product> cateProductList(String category);//카테고리별 제품 출력
	List<Product> selectNewList();//새상품 리스트
	List<Product> selectNewCateList(String category);//카테고리별 새상품 리스트
}

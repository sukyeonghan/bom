package com.kh.bom.product.model.service;

import java.util.List;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.review.model.vo.Review;

public interface ProductService {
	
	//상품불러오기
	Product selectProductOne(String pdtNo);
	
	//상품문의
	List<Inquiry> inquiryList(String pdtNo, int cPage, int numPerpage);
	
	//상품갯수
	int inquiryCount();
	
	//구매평
	List<Review> reviewList(int cPage, int numPerpage);
		
	//구매평 갯수
	int reviewCount();


	int productCount(String category);//제품 개수
	int countSale();//세일제품개수
	List<Product> selectProductList(int cPage,int numPerPage,String sort,String category);//전체 제품 출력
	List<Product> selectNewCateList(String category);//카테고리별 새상품 리스트
	List<Product> selectSaleList(int cPage,int numPerPage,String sort,String category);//세일제품 리스트
}

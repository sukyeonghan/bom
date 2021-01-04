package com.kh.bom.product.model.service;

import java.util.List;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.review.model.vo.Review;

public interface ProductService {
	
	//상품불러오기
	Product selectProductOne(String pdtNo);
	
	//상품문의
	List<Inquiry> inquiryList(String pdtNo, int cPage, int numPerpage);
	
	//상품 옵션 불러오기
	List<ProductOption> selectpdtOption(String pdtNo);
	
	//상품갯수
	int inquiryCount(String pdtNo);
	
	//구매평
	List<Review> reviewList(String pdtNo, int cPage, int numPerpage);
		
	//구매평 갯수
	int reviewCount(String pdtNo);
	
	//구매평 별점평균
	String reviewAvg(String pdtNo);
	
	//제품등록날짜
	Product selectproductDate(String pdtNo);
	
	//연관상품
	List<Product> slidelist();

	//수정-제품리스트 출력
	List<Product> selectProductList(int cPage,int numPerPage,Product p);
	//가격 최대값 가져오기
	int selectMaxPrice(String category);
}

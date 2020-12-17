package com.kh.bom.product.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.AjaxPageBarFactory;
import com.kh.bom.common.page.ProAjaxPageBarFactory;
import com.kh.bom.common.page.ProPageBarFactory;
import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.service.ProductService;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.review.model.vo.Review;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductController {

	@Autowired
	private ProductService service;
	
	//전체제품 페이지
	@RequestMapping("/product/productAll") 
	public ModelAndView allProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="전체제품";
		int count=service.productCount(cate);
		List<Product> newList=service.selectNewCateList(cate);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort,cate));
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "productAll"));
		m.addObject("cPage",cPage);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	//제품 목록 ajax
	@RequestMapping("/product/productListAjax")
	public ModelAndView productListAjax(ModelAndView m,
			String category,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		int count;
		List<Product> newList;
		if(category.equals("할인제품")) {
			count=service.countSale();
			newList=service.selectNewCateList("전체제품");
			m.addObject("list",service.selectSaleList(cPage,numPerpage,sort,category));
		}else {
			count=service.productCount(category);
			newList=service.selectNewCateList(category);
			m.addObject("list",service.selectProductList(cPage,numPerpage,sort,category));
		}
		
		m.addObject("pageBar",ProAjaxPageBarFactory.getAjaxPageBar(count, cPage, numPerpage, "productListAjax",sort,category));
		m.addObject("cPage",cPage);
		m.addObject("category",category);
		m.addObject("sort",sort);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.setViewName("product/productListAjax");
		return m;
	
	}
	
	//식품 카테고리 페이지
	@RequestMapping("/product/food") 
	public ModelAndView foodProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="식품";
		int count=service.productCount(cate);
		List<Product> newList=service.selectNewCateList(cate);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort,cate));
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "food"));
		m.addObject("cPage",cPage);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	//잡화 카테고리 페이지
	@RequestMapping("/product/stuff") 
	public ModelAndView stuffProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="잡화";
		int count=service.productCount(cate);
		List<Product> newList=service.selectNewCateList(cate);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort,cate));
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "stuff"));
		m.addObject("cPage",cPage);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	//주방 카테고리 페이지
	@RequestMapping("/product/kitchen") 
	public ModelAndView kitchenProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		String cate="주방";
		int count=service.productCount(cate);
		List<Product> newList=service.selectNewCateList(cate);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort,cate));
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "kitchen"));
		m.addObject("cPage",cPage);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	
	//욕실 카테고리 페이지
	@RequestMapping("/product/bathroom") 
	public ModelAndView bathProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="욕실";
		int count=service.productCount(cate);
		List<Product> newList=service.selectNewCateList(cate);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort,cate));
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "bathroom"));
		m.addObject("cPage",cPage);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	//여성용품 카테고리  페이지
	@RequestMapping("/product/woman") 
	public ModelAndView womanProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="여성용품";
		int count=service.productCount(cate);
		List<Product> newList=service.selectNewCateList(cate);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort,cate));
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "woman"));
		m.addObject("cPage",cPage);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	//반려동물 카테고리 페이지
	@RequestMapping("/product/pet") 
	public ModelAndView petProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="반려동물";
		int count=service.productCount(cate);
		List<Product> newList=service.selectNewCateList(cate);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort,cate));
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "pet"));
		m.addObject("cPage",cPage);
		m.addObject("count",count);
		m.addObject("newList",newList);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	//할인제품 페이지
	@RequestMapping("/product/sale") 
	public ModelAndView saleProduct(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="등록일순") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		//전체 리스트 보내서 화면단에서 처리하기
		String cate="할인제품";
		int count=service.countSale();
		List<Product> newList=service.selectNewCateList("전체제품");
		m.addObject("pageBar",ProPageBarFactory.getPageBar(count, cPage, numPerpage, "sale"));
		m.addObject("cPage",cPage);
		m.addObject("list",service.selectSaleList(cPage,numPerpage,sort,cate));
		m.addObject("newList",newList);
		m.addObject("count",count);
		m.addObject("category",cate);
		m.setViewName("product/productList");
		return m;
	}
	

	//상품문의 카운트 - 상품상세 첫화면
	@RequestMapping("/product/productOne")
	public ModelAndView productOne(ModelAndView mv,
			@RequestParam("pdtNo") String pdtNo,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage
			,HttpSession session) {
		
		//상품불러오기
		Product product = service.selectProductOne(pdtNo);
		//상품옵션불러오기
		List<ProductOption> optionlist = service.selectpdtOption(pdtNo);
		
		//상품문의
		//로그인 세션에서 현재 사용자 id값 가져오기
		Member m = (Member)session.getAttribute("loginMember");
		List<Inquiry> list = service.inquiryList(pdtNo, cPage, numPerpage);
		for(Inquiry i : list) {
			//작성글이 비밀글일 경우
			if(i.getInqSecret().equals("Y")) {
				//비로그인 상태인 경우 작성자여도 비밀글로 처리 -> 모든 비밀글 비밀글로 보여주기 
				if(m==null) {
					i.setInqContent("비밀글입니다");
				}else {
					//게시글 작성자 저장
					String memNo = i.getMemNo();
					//로그인한 사용자가 게시물 작성자가 아닐거나 매니저가 아닐 경우 비밀글로 처리
					if(!m.getMemManagerYn().equals("Y")&&!m.getMemNo().equals(memNo)) {
						i.setInqContent("비밀글입니다");
					}
				}
			}
			//작성글에 답변이 안 달린경우
			if(i.getInqAnswerYn().equals("N")) {
				i.setInqAnswer("관리자의 답변을 기다려주세요");
			}
		}
		//상품문의 갯수
		int totalData = service.inquiryCount(pdtNo);
		
		//구매평
		List<Review> reviewlist = service.reviewList(pdtNo,cPage, numPerpage);
		//구매평 갯수
		int reviewCount = service.reviewCount(pdtNo);
		//구매평 별점평균
		String reviewAvg = service.reviewAvg(pdtNo);

		mv.addObject("product", product);
		mv.addObject("optionlist", optionlist);
		mv.addObject("list", list);
		mv.addObject("count", totalData);
		mv.addObject("reviewlist", reviewlist);
		mv.addObject("reviewCount", reviewCount);
		mv.addObject("reviewAvg", reviewAvg);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productOneAjax"));
		mv.setViewName("product/productOne");

		return mv;
	}
	
	//상품문의 페이징처리
	@RequestMapping("/product/productOneAjax") 
	@ResponseBody
	public ModelAndView productOneAjax(ModelAndView mv, 
			String pdtNo,
			int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage,
			HttpSession session) {
	  
		//로그인 세션에서 현재 사용자 id값 가져오기
		Member m = (Member)session.getAttribute("loginMember");
		List<Inquiry> list = service.inquiryList(pdtNo,cPage, numPerpage);
		for(Inquiry i : list) {
			if(i.getInqSecret().equals("Y")) {
				//비로그인 상태일 경우 비밀 댓글 처리
				if(m==null) {
					i.setInqContent("비밀글입니다");
				}else {
					//게시글 작성자 저장
					String memNo = i.getMemNo();
					//로그인한 사용자가 게시물 작성자가 아닐거나 매니저가 아닐 경우 비밀글로 처리
					if(!m.getMemManagerYn().equals("Y")&&!m.getMemNo().equals(memNo)) {
						i.setInqContent("비밀글입니다");
					}
				}
			}
			//작성글에 답변이 안 달린경우
			if(i.getInqAnswerYn().equals("N")) {
				i.setInqAnswer("관리자의 답변을 기다려주세요");
			}
		}
		
		mv.addObject("list", list);
		int totalData = service.inquiryCount(pdtNo);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar", AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productOneAjax"));
		mv.setViewName("product/productOneAjax");

		return mv; 
	 
	}
	
	
	
}

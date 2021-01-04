package com.kh.bom.product.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.AjaxPageBarFactory;
import com.kh.bom.common.page.ProAjaxPageBarFactory2;
import com.kh.bom.common.page.ProPageBarFactory;
import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.service.ProductService;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.review.model.vo.Review;
import com.kh.bom.zzim.model.service.ZzimService;
import com.kh.bom.zzim.model.vo.Zzim;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductController {

	@Autowired
	private ProductService service;
	
	@Autowired
	private ZzimService zzimservice;

	//전체제품 페이지
	@RequestMapping("/product/productAll") 
	public ModelAndView allProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="전체제품";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list=service.selectProductList(cPage,numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("list",list);
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "productAll"));
		m.addObject("cPage",cPage);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.addObject("count",totalCount);
		m.setViewName("product/productList");
		return m;
	}

	//제품 리스트 ajax
	@RequestMapping("/product/productListAjaxTest")
	@ResponseBody
	public ModelAndView productListTest(ModelAndView m,Product p,
			HttpServletRequest request,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="category", required = false) String[] category,
			@RequestParam(value="sort", defaultValue="등록일순") String sort,
			@RequestParam(value="soldout", required = false) String soldout,
			@RequestParam(value="price") String price,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		p.setPdtCategory(pdtCategory);

		//제품 슬라이더 가격
		int idx=0;
		if(price!=null) {
			idx=price.indexOf(";");
			if(idx!=-1) {
				p.setFromPrice(Integer.parseInt(price.substring(0, idx)));//시작값
				p.setToPrice(Integer.parseInt(price.substring(idx+1)));//끝값
			}else {
				p.setFromPrice(0);
				p.setToPrice(service.selectMaxPrice(pdtCategory));
			}
		}
		
		//ajax 페이징에서 넘어올 때 값이 비어있음. 다시 세팅
		if(p.getSort()==null) { 
			p.setCategory(category);
			p.setSoldout(soldout);
			p.setSort(sort);
		}
		
		List<Product> list=service.selectProductList(cPage,numPerpage,p);
		
		//검색 결과에 따른 제품 개수
		int totalCount=0;
		if(list.size()!=0) {
			totalCount=list.get(0).getTotCnt();//제품 개수
		}
		m.addObject("list",list);
		m.addObject("pageBar",ProAjaxPageBarFactory2.getAjaxPageBar(totalCount, cPage, numPerpage, "productListAjaxTest",price,pdtCategory,Arrays.toString(p.getCategory()),p.getSort(),p.getSoldout()));
		m.addObject("cPage",cPage);
		m.addObject("count",totalCount);
		m.setViewName("product/productListAjaxTest");
		return m;
	}
	
	//식품 카테고리 페이지
	@RequestMapping("/product/food") 
	public ModelAndView foodProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="식품";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list=service.selectProductList(cPage,numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("list",list);
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "food"));
		m.addObject("cPage",cPage);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.addObject("count",totalCount);
		m.setViewName("product/productList");
		return m;
	}
	
	//잡화 카테고리 페이지
	@RequestMapping("/product/stuff") 
	public ModelAndView stuffProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="잡화";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list=service.selectProductList(cPage,numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("list",list);
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "stuff"));
		m.addObject("cPage",cPage);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.addObject("count",totalCount);
		m.setViewName("product/productList");
		return m;
	}
	
	//주방 카테고리 페이지
	@RequestMapping("/product/kitchen") 
	public ModelAndView kitchenProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="주방";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list=service.selectProductList(cPage,numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("list",list);
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "kitchen"));
		m.addObject("cPage",cPage);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.addObject("count",totalCount);
		m.setViewName("product/productList");
		return m;
	}
	
	//욕실 카테고리 페이지
	@RequestMapping("/product/bathroom") 
	public ModelAndView bathProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="욕실";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list=service.selectProductList(cPage,numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("list",list);
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "bathroom"));
		m.addObject("cPage",cPage);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.addObject("count",totalCount);
		m.setViewName("product/productList");
		return m;
	}
	
	//여성용품 카테고리  페이지
	@RequestMapping("/product/woman") 
	public ModelAndView womanProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="여성용품";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list=service.selectProductList(cPage,numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("list",list);
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "woman"));
		m.addObject("cPage",cPage);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.addObject("count",totalCount);
		m.setViewName("product/productList");
		return m;
	}
	
	//반려동물 카테고리 페이지
	@RequestMapping("/product/pet") 
	public ModelAndView petProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {
		
		String cate="반려동물";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list= service.selectProductList(cPage,numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("list",list);
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "pet"));
		m.addObject("cPage",cPage);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.addObject("count",totalCount);
		m.setViewName("product/productList");
		return m;
	}
	
	//할인제품 페이지
	@RequestMapping("/product/sale") 
	public ModelAndView saleProduct(ModelAndView m,Product p,
			@RequestParam(value="pdtcategory", defaultValue="전체제품") String pdtCategory,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="8") int numPerpage) {

		String cate="할인제품";
		p.setPdtCategory(cate);
		int maxPrice=service.selectMaxPrice(cate);//가격 슬라이더 최대값 설정
		List<Product> list=service.selectProductList(cPage, numPerpage,p);
		int totalCount=list.get(0).getTotCnt();//제품 개수
		m.addObject("pageBar",ProPageBarFactory.getPageBar(totalCount, cPage, numPerpage, "sale"));
		m.addObject("cPage",cPage);
		m.addObject("list",list);
		m.addObject("count",totalCount);
		m.addObject("category",cate);
		m.addObject("maxPrice",maxPrice);
		m.setViewName("product/productList");
		return m;
	}
	

	//상품상세화면 첫화면
	@RequestMapping("/product/productOne")
	@ResponseBody
	public ModelAndView productOne(ModelAndView mv,
			@RequestParam("pdtNo") String pdtNo,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage
			,HttpSession session) {
		
		//상품불러오기
		Product product = service.selectProductOne(pdtNo);
		//상품옵션불러오기
		List<ProductOption> optionlist = service.selectpdtOption(pdtNo);
		
		//상품문의 카운트 
		int totalData = service.inquiryCount(pdtNo);
		//구매평 갯수
		int reviewCount = service.reviewCount(pdtNo);
		//구매평 별점평균
		String reviewAvg = service.reviewAvg(pdtNo);
		
		//상품 등록날짜
		Product deteResult = service.selectproductDate(pdtNo);
		System.out.println("상품등록날짜 : "+deteResult);
		
		//연관상품 슬라이드
		List<Product> slidelist = service.slidelist();
		
		//현재 찜리스트 불러오기
		Member m = (Member)session.getAttribute("loginMember");
		String msg = "";
		String loc = "";
		
		List<Zzim> zzimlist = null;
		
		//로그인 했을 때 찜리스트 불러오기
		if(m!=null) {
			zzimlist = zzimservice.selectZzimList(m.getMemNo());
	//		for(Zzim z : zzimlist) {
	//			System.out.println(z);
	//		}
			//찜리스트에 찜한상품 넣기
			for(Zzim z : zzimlist) {
				z.setFavlist(zzimservice.selectfavlist(z.getZzimNo()));
				//System.out.println(z);
			}
			
		//로그인 안 했을 경우 접근 X	
		}else {
			msg = "로그인을 먼저 해주세요";
			loc = "/product/productOne?pdtNo="+pdtNo;
		}
		
		mv.addObject("product", product);
		mv.addObject("optionlist", optionlist);
		mv.addObject("count", totalData);
		mv.addObject("reviewCount", reviewCount);
		mv.addObject("reviewAvg", reviewAvg);
		mv.addObject("dateResult", deteResult);
		mv.addObject("slidelist", slidelist);
		mv.addObject("zzimlist", zzimlist);
		mv.addObject("loc",loc);
		mv.addObject("common/msg");
		mv.setViewName("product/productOne");

		return mv;
	}
	
	//상품상세 눌렀을 때
	@RequestMapping("/product/productDetail")
	public ModelAndView productDetail(String pdtNo, ModelAndView mv) {
		
		//상품불러오기
		Product product = service.selectProductOne(pdtNo);
		
		mv.addObject("product", product);
		mv.setViewName("/product/productDetail");
		return mv;
	}
	
	
	//구매평 눌렀을 때
	@RequestMapping("/product/productReview")
	@ResponseBody
	public ModelAndView productReview(ModelAndView mv,
			@RequestParam("pdtNo") String pdtNo,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
		
		//구매평
		List<Review> reviewlist = service.reviewList(pdtNo,cPage, numPerpage);
		//구매평 갯수
		int totalData = service.reviewCount(pdtNo);
		
		mv.addObject("reviewlist", reviewlist);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar", AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productReviewAjax", pdtNo));
		mv.addObject("pdtNo", pdtNo);
		mv.setViewName("product/productReview");
		
		return mv;
	}
	
	//구매평 페이징
	@RequestMapping("/product/productReviewAjax")
	@ResponseBody
	public ModelAndView productReviewAjax(ModelAndView mv,
			String pdtNo,
			int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
		
		//구매평
		List<Review> reviewlist = service.reviewList(pdtNo,cPage, numPerpage);
		//구매평 갯수
		int totalData = service.reviewCount(pdtNo);
		
		mv.addObject("reviewlist", reviewlist);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar", AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productReviewAjax", pdtNo));
		mv.addObject("pdtNo", pdtNo);
		mv.setViewName("product/productReviewAjax");
		
		return mv;
	}
	
	//상품문의 눌렀을 때
	@RequestMapping("/product/productInquiry")
	@ResponseBody
	public ModelAndView productInquiry(ModelAndView mv,
			@RequestParam("pdtNo") String pdtNo, 
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage,
			HttpSession session) {
		
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
					//로그인한 사용자가 게시물 작성자가 아니거나 매니저가 아닐 경우 비밀글로 처리
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
		
		mv.addObject("list", list);
		mv.addObject("count", totalData);
		mv.addObject("pdtNo", pdtNo);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productInquiryAjax", pdtNo));
		mv.setViewName("product/productInquiry");
		
		return mv;
	}
	
	//상품문의 페이징처리
	@RequestMapping("/product/productInquiryAjax")
	@ResponseBody
	public ModelAndView ajaxInqiry(ModelAndView mv,
			String pdtNo, 
			int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage,
			HttpSession session) {
		
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
					//로그인한 사용자가 게시물 작성자가 아니거나 매니저가 아닐 경우 비밀글로 처리
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
		
		mv.addObject("list", list);
		mv.addObject("count", totalData);
		mv.addObject("pdtNo", pdtNo);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productInquiryAjax", pdtNo));
		mv.setViewName("product/productInquiryAjax");
		
		return mv;
	}
	
	
	

	
}

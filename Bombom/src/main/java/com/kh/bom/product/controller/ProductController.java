package com.kh.bom.product.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.controller.ProductAdminController;
import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.common.page.AjaxPageBarFactory;
import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.service.ProductService;
import com.kh.bom.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductController {

	@Autowired
	private ProductService service;
	@Autowired
	private AdminService adminService;
	
	//전체제품 페이지
	@RequestMapping("/product/productAll") 
	public ModelAndView allProduct(ModelAndView m) { 
		List<Product> list=adminService.selectProductList();
		int count=service.productAllCount();
		m.addObject("list",list);
		m.addObject("count",count);
		m.setViewName("product/allList");
		return m;
	}
	
	//욕실제품 페이지
	@RequestMapping("/product/bathroom") 
	public ModelAndView bathProduct(ModelAndView m) {
		String cate="욕실";
		List<Product> list=service.cateProductList(cate);
		int count=service.productCateCount(cate);
		m.addObject("list",list);
		m.addObject("count",count);
		m.setViewName("product/bathroomList");
		return m;
	}
		
	//상품문의 카운트 - 상품상세 첫화면
	@RequestMapping("/product/productOne")
	public ModelAndView productOne(ModelAndView mv,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage
			,HttpSession session) {
		
		//로그인 세션에서 현재 사용자 id값 가져오기
		Member m = (Member)session.getAttribute("loginMember");
		List<Inquiry> list = service.inquiryList(cPage, numPerpage);
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
		
		mv.addObject("list", list);
		int totalData = service.inquiryCount();
		mv.addObject("count", totalData);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productOneAjax"));
		mv.setViewName("product/productOne");

		return mv;
	}
	
	//상품문의 페이징처리
	@RequestMapping("/product/productOneAjax") 
	@ResponseBody
	public ModelAndView productOneAjax(ModelAndView mv, int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage,
			HttpSession session) {
	  
		//로그인 세션에서 현재 사용자 id값 가져오기
		Member m = (Member)session.getAttribute("loginMember");
		List<Inquiry> list = service.inquiryList(cPage, numPerpage);
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
		int totalData = service.inquiryCount();
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar", AjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "productOneAjax"));
		mv.setViewName("product/productOneAjax");

		return mv; 
	 
	}
	
	
	
}

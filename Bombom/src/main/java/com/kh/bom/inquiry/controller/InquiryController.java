package com.kh.bom.inquiry.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.inquiry.model.service.InquiryService;
import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;

@Controller
public class InquiryController {
	@Autowired
	private InquiryService service;
	@Autowired
	private MemberService memberservice;
	
	//상품문의 등록 
	@RequestMapping("/product/insertInquiry")
	public ModelAndView inquiry(Inquiry i, ModelAndView mv, HttpSession session) {

		Member m = (Member)session.getAttribute("loginMember");
		int result = service.insertInquiry(i);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			mv.addObject("loginMember", memberservice.selectMemberOne(m.getMemNick()));
			msg = "문의글이 등록되었습니다";
			loc = "/product/productOne";
			icon = "success";
		}else {
			msg = "문의글을 다시 등록해주세요";
			loc = "/product/productOne";
			icon = "warning";
		}
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
		
	}
	
	//상품문의 상세보기 팝업창
	@RequestMapping("/inquiry/inquiryView")
	public String inquiryView(String inqNo,String memNick,Model m) {
		Inquiry i = service.selectInquiryOne(inqNo);
		m.addAttribute("memNick",memNick);
		m.addAttribute("inquiry",i);
		return "product/inquiry/inquiryView";
	}
	
	
	
	
}

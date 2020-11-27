package com.kh.bom.inquiry.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.inquiry.model.service.InquiryService;
import com.kh.bom.inquiry.model.vo.Inquiry;

@Controller
public class InquiryController {
	@Autowired
	private InquiryService service;
	
	//상품문의 등록 
	@RequestMapping("/product/insertInquiry")
	public ModelAndView inquiry(Inquiry i, ModelAndView mv) {
		System.out.println(i.getInqSecret());
		int result = service.insertInquiry(i);
		String msg = "";
		String loc = "";
		String icon = "";
		if(result>0) {
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
	
	
	
}

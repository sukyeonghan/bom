package com.kh.bom.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class memberController {
    
	@RequestMapping("/mypage/orderStatus")
	public ModelAndView order(ModelAndView mv) {
		
		//주문내역
		
		mv.setViewName("mypage/orderStatus");
		return mv;
	}
}

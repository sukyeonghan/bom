package com.kh.bom.zzim.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.zzim.model.service.ZzimService;
@Controller
public class ZzimController {
	@Autowired
	private ZzimService service;
	
	@RequestMapping("/mypage/zzimList")
	public ModelAndView selectZzimList(ModelAndView mv) {
		
		mv.setViewName("mypage/zzimList");
		return mv;
	}
}

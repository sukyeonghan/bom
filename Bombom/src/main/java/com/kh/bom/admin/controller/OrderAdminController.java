package com.kh.bom.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;

@Controller
public class OrderAdminController {

	@Autowired
	private AdminService service;
	
	//회원들의 주문내역
	@RequestMapping("/admin/order")
	public ModelAndView orderList(ModelAndView mv) {
		
		mv.setViewName("admin/order/orderMng");
		
		return mv;
	}
	
	//주문내역 상세
	@RequestMapping("/admin/orderDetail")
	public ModelAndView order(ModelAndView mv) {
		
		mv.setViewName("admin/order/orderDetailMng");
		
		return mv;
	}
	
}

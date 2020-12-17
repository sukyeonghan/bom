package com.kh.bom.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.order.model.vo.Order;

@Controller
public class OrderAdminController {

	@Autowired
	private AdminService service;
	
	//회원들의 주문내역
	@RequestMapping("/admin/order")
	public ModelAndView orderList(ModelAndView mv,@RequestParam(value = "cPage", defaultValue = "0") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "5") int numPerpage) {
		
		Order order=new Order();
		mv.addObject("list", service.selectOrderList(cPage, numPerpage ));
		int totalData = service.selectOrderCount();
		
		mv.addObject("pageBar", PageBarFactory.getPageBar(totalData, cPage, numPerpage, "order"));
		mv.addObject("totalData", totalData);
		mv.setViewName("admin/order/orderMng");
		
		return mv;
	}
	
	//주문내역 상세
	@RequestMapping(value="/admin/orderDetail")
	public ModelAndView orderDetail(ModelAndView mv, String orderNo ) {
		
		System.out.println(orderNo);
		//상품명, 상품가격, 옵션명, 옵션가격, 수량, 썸네일 뽑아오는것 
		mv.addObject("product", service.selectOrderDetail(orderNo));
		//기본주문 정보 불러오기 
		mv.addObject("order", service.selectOrderOne(orderNo));
		mv.setViewName("admin/order/orderDetailMng");
		
		return mv;
	}
	
}

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
	
	//주문내역에서 배송상태 바꾸기
	@RequestMapping(value="/admin/orderShipUpdate")
	public ModelAndView orderShipUpdate(ModelAndView mv, 
			String ordStatus, String orderNo 
		) {
	
		Order o=new Order();
		o.setOrderNo(orderNo);
		o.setOrdStatus(ordStatus);

		int result = service.orderShipUpdate(o);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			msg = "배송상태가 수정되었습니다";
			loc = "/admin/order";
			icon = "success";
		}else {
			msg = "다시 시도해주세요";
			loc = "/admin/order";
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		
		return mv;
	
	}
	
}

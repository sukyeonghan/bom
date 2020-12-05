package com.kh.bom.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.service.OrderService;
import com.kh.bom.order.model.vo.Order;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;

	// 장바구니 화면으로 전환
	@RequestMapping("/order/basket")
	public ModelAndView goBasket(ModelAndView mv, String memNo) {
		System.out.println(memNo);
		//장바구니를 눌렀을때
		String basketNo = service.selectBasketOne(memNo);
		
		//상품담기를 눌렀을때
		
		mv.setViewName("order/basket");
		return mv;
	}

	// 결제화면으로 전환
	@RequestMapping("/order/doOrder")
	public String doOrder() {
		return "order/order";
	}

	// 결제하기
	@RequestMapping("/order/insertOrder")
	public ModelAndView insertOrder(Order order, ModelAndView mv) {
		System.out.println(order);

		// orderNo만들기
		String orderNo = "";
		String today = new SimpleDateFormat("yyyyMMdd").format(new Date());// 등록날짜가져오기
		int ran = (int) (Math.floor(Math.random() * 1000000) + 100000); // 6자리 랜덤숫자
		orderNo = today + "-" + ran;
		order.setOrderNo(orderNo);

		int result = service.insertOrder(order);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "주문이 완료되었습니다! 금방 배송해 드릴게요!";
			loc = "redirect:/mypage/orderStatus";
			icon="success";
		} else {
			msg = "결제에 실패했어요ㅠㅠ";
			loc = "/";
			icon="warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");

		return mv;
	}

}

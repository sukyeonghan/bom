package com.kh.bom.order.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderController {

	
	//장바구니 화면으로 전환
	@RequestMapping("/order/basket")
	public String goBasket() {
		return "order/basket";
	}
}

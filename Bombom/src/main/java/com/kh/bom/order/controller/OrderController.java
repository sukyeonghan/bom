package com.kh.bom.order.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.order.model.service.OrderService;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.Product;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;
	@Autowired
	private AdminService pService;

	// 헤더에서 장바구니 화면으로 전환
	@RequestMapping("/order/basket")
	public ModelAndView goBasket(ModelAndView mv, String memNo) {
		System.out.println(memNo);
		
		String basketNo = service.selectBasketOne(memNo);
		List<Inbasket> list = service.selectInbasket(basketNo);
		
		mv.addObject("list",list);
		mv.setViewName("order/basket");
		return mv;
	}
	
	//상품상세페이지에서 장바구니 화면으로 전환
	@RequestMapping("order/productBasket")
	public ModelAndView goBasketWithProduct(ModelAndView mv, String memNo, String pdtNo) {
		//상품번호랑 갯수 가져와서 insert하기
		int result = service.insertInbasket(pdtNo);
		
		
		//멤버에 해당하는 장바구니 불러오기
		String basketNo = service.selectBasketOne(memNo);
		//장바구니 안에 담긴 상품 불러오기
		List<Inbasket> list = service.selectInbasket(basketNo);
		//각 pdtNo에 해당하는 상품을 출력하기 위한 리스트 가져오기
		List<Product> plist = pService.selectProductList();
		
		mv.addObject("list",list);
		mv.addObject("plist",plist);
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

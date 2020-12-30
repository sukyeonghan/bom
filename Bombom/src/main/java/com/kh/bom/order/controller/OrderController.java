package com.kh.bom.order.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.service.OrderService;
import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.vo.Point;
import com.kh.bom.product.model.service.ProductService;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.ship.model.Service.ShipService;
import com.kh.bom.ship.model.vo.Ship;

@Controller
public class OrderController {

	@Autowired
	private OrderService service;
	@Autowired
	private AdminService pService;
	@Autowired
	private MemberService mService;
	@Autowired
	private ShipService shipService;
	@Autowired
	private ProductService productService;

	// 헤더에서 장바구니 화면으로 전환
	@RequestMapping("/order/basket")
	public ModelAndView goBasket(ModelAndView mv, String memNo, HttpSession session) {
		System.out.println(memNo);
		Member login = (Member)mService.selectMemberOne(memNo);
		System.out.println("장바구니 연결 - 회원 : "+login);
		// 회원이 갖고있는 장바구니 불러오기
		List<Basket> list = service.selectBasket(memNo);
		//회원정보 보내주기
		mv.addObject("loginMember", login);
		//회원의 배송지 가져오기
		Ship s = shipService.selectShipOneY(login.getMemNo());
		if(s != null) {
			mv.addObject("ship", s);
		}
		mv.addObject("list", list);
		mv.setViewName("order/basket");
		return mv;
	}

	// 상품상세페이지에서 장바구니 화면으로 전환
	@RequestMapping("order/productBasket")
	public ModelAndView goBasketWithProduct(ModelAndView mv, String memNo, String pdtNo) {
		// 상품번호랑 갯수 가져와서 insert하기
		// 멤버에 해당하는 장바구니 불러오기
		// 장바구니 안에 담긴 상품 불러오기
		// 각 pdtNo에 해당하는 상품을 출력하기 위한 리스트 가져오기
		List<Product> plist = pService.selectProductList();

		mv.addObject("plist", plist);
		mv.setViewName("order/basket");
		return mv;
	}

	// 장바구니에서 상품 하나 삭제하기
	@RequestMapping("order/deleteBasketOne")
	public ModelAndView deleteBasketOne(ModelAndView m, String pdtNo, String basketNo, String memNo) {
		System.out.println(pdtNo);
		System.out.println(basketNo);
		
		int result = service
				.deleteBasketOne(Basket.builder().pdtNo(pdtNo).basketNo(basketNo).build());
		List<Basket> list = new ArrayList<Basket>();
		// 삭제가 성공하면 삭제된 이후 리스트 넘겨주기
		if (result > 0) {
			System.out.println("삭제성공!");
			list = service.selectBasket(memNo);
			m.addObject("list", list);
			m.setViewName("order/basket");
		}else {
			m.addObject("msg", "서버에러");
			m.addObject("loc","/order/basket");
			m.addObject("icon","error");
			m.setViewName("common/msg");
		}
		return m;
	}

	// 결제화면으로 전환
	@RequestMapping("/order/doOrder")
	public ModelAndView doOrder(ModelAndView mv, Basket b, HttpSession session) {
		System.out.println(b);
		//basketNo, productNo, inbasQty만 넘어옴.
		Member m = (Member)session.getAttribute("loginMember");
		System.out.println("결제하기 - 회원 : "+m);
		
		List<Inbasket> qtyList = new ArrayList<Inbasket>();
		//int[] qty = b.getInbasQty();
		
		
		List<Product> list = new ArrayList<Product>();
		String[] productNo = b.getPdtNo().split(",");
		for(String no : productNo) {
			Product p = productService.selectProductOne(no);
			list.add(p);
		}

		mv.addObject("loginMember",m);
		mv.addObject("list", list);
		mv.setViewName("order/order");
		return mv;
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
			icon = "success";
		} else {
			msg = "결제에 실패했어요ㅠㅠ";
			loc = "/";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");

		return mv;
	}
	//나의 주문내역 
	@RequestMapping("/mypage/orderStatus")
	public ModelAndView order(ModelAndView mv, HttpSession session,
			@RequestParam(value="cPage", defaultValue="0") int cPage,
			@RequestParam(value="numPerpage", defaultValue="5") int numPerpage) {
		
		Member login= (Member) session.getAttribute("loginMember");
		String memNo=login.getMemNo();
		
		mv.addObject("list",service.selectOrderList(memNo,cPage,numPerpage));
		int totalData=service.selectOrderCount(memNo);
		//주문대기
		int ordWait=service.ordWaitCount(memNo);
		//주문완료
		int ordEnd=service.ordEndCount(memNo);
		//배송준비
		int shipReady=service.shipReadyCount(memNo);
		//배송중
		int shipping=service.shippingCount(memNo);
		//배송완료
		int shipEnd=service.shipEndCount(memNo);
		//주문취소(요청)
		int ordCancel=service.buyEndCount(memNo);
		//취소완료
		int cancelEnd=service.cancelEndCount(memNo);
		//반품요청
		int returnWait=service.returnWaitCount(memNo);
		//반품완료
		int returnEnd=service.returnEndCount(memNo);
		
		mv.addObject("loginMember", login);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "orderStatus"));
		mv.addObject("totalData", totalData);
		mv.addObject("shipReady", shipReady);
		mv.addObject("ordWait", ordWait);
		mv.addObject("ordEnd", ordEnd);
		mv.addObject("shipping", shipping);
		mv.addObject("shipEnd", shipEnd);
		mv.addObject("ordCancel", ordCancel);
		mv.addObject("cancelEnd", cancelEnd);
		mv.addObject("returnWait", returnWait);
		mv.addObject("returnEnd", returnEnd);

		mv.setViewName("mypage/orderStatus");
		return mv;
	}
	
	//상세주문내역 
	@RequestMapping("/mypage/orderDetail")
	public ModelAndView orderDetail(ModelAndView mv, String orderNo ) {
		
		System.out.println(orderNo);
		//상품명, 상품가격, 옵션명, 옵션가격, 수량, 썸네일 뽑아오는것 
		mv.addObject("product", service.selectOrderDetail(orderNo));
		//기본주문 정보 불러오기 
		mv.addObject("order", service.selectOrderOne(orderNo));
		mv.setViewName("mypage/ordDetail");
		
		return mv;
	}
	
	//반품요청
	@RequestMapping("/mypage/returnRequest")
	public ModelAndView returnRequest(HttpSession session, ModelAndView mv, String orderNo, String cancel, int ordUsePoint) {
		Member login= (Member) session.getAttribute("loginMember");
		String memNo=login.getMemNo();
		
		Order o=new Order();
		o.setOrderNo(orderNo);
		o.setOrdCancel(cancel);
		Point p=new Point();
		p.setMemNo(memNo);
		p.setPointContent("주문취소 (주문번호:"+orderNo+")");
		p.setPointChange(ordUsePoint);
		
		int result = service.returnRequest(o,p);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "반품 요청하였습니다.";
			loc = "/mypage/orderStatus";
			icon = "success";
		} else {
			msg = "실패하였습니다. 다시 시도해주세요.";
			loc = "/mypage/orderStatus";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");		
		return mv;		
	}
	
	//구매확정
	@RequestMapping("/mypage/buyConfirm")
	public ModelAndView orderCancel(HttpSession session, ModelAndView mv, String orderNo, int ordAmount) {
		Member login= (Member) session.getAttribute("loginMember");
		String memNo=login.getMemNo();
		
		Point p=new Point();
		p.setMemNo(memNo);
		p.setPointContent("구매확정 (주문번호:"+orderNo+")");
		int point=(int)(ordAmount*0.05);
		p.setPointChange(point);
		int result = service.buyConfirm(orderNo, p);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "적립금"+point+"가 적립되었습니다.";
			loc = "/mypage/orderStatus";
			icon = "success";
		} else {
			msg = "다시 시도해주세요.";
			loc = "/mypage/orderStatus";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");		
		return mv;		
	}
	
	//주문취소(요청)
	@RequestMapping("/mypage/orderCancel")
	public ModelAndView orderCancel(HttpSession session, ModelAndView mv, String orderNo, String cancel, int ordUsePoint) {
		Member login= (Member) session.getAttribute("loginMember");
		String memNo=login.getMemNo();
		
		Order o=new Order();
		o.setOrderNo(orderNo);
		o.setOrdCancel(cancel);
		Point p=new Point();
		p.setMemNo(memNo);
		p.setPointContent("주문취소 (주문번호:"+orderNo+")");
		p.setPointChange(ordUsePoint);
		
		int result = service.cancelOrder(o,p);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "주문을 취소하였습니다.";
			loc = "/mypage/orderStatus";
			icon = "success";
		} else {
			msg = "주문취소 실패하였습니다. 다시 시도해주세요.";
			loc = "/mypage/orderStatus";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");		
		return mv;		
	}
	
}

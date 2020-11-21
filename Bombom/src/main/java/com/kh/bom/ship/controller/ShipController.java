package com.kh.bom.ship.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.ship.model.Service.ShipService;
import com.kh.bom.ship.model.vo.Ship;

@Controller
public class ShipController {

	@Autowired
	ShipService service;
	
	@RequestMapping("/mypage/shipList")
	public ModelAndView shipList(ModelAndView mv,String memNo ) {
		memNo="M1000";//더미
		
		List<Ship> list=service.selectShipList(memNo);
		mv.addObject("list",list);
		mv.setViewName("mypage/shipList");
		return mv;
	}
	
	@RequestMapping("/ship/insertShip")
	public String insertShipView(String memNo,Model m) {
		m.addAttribute("memNo",memNo);
		return "mypage/insertShip";
	}
	
	@RequestMapping("/ship/insertShipEnd")
	public ModelAndView insertShipEnd(Ship s,
			@RequestParam(value="shipYn", defaultValue="N") String shipYn, ModelAndView mv) {
		s.setShipYn(shipYn);
		int result=service.insertShip(s);
		String loc="";
		String icon="";
		String msg="";
		if(result>0) {
			msg="배송지 등록이 되었습니다.";
			loc="/mypage/shipList";
			icon="success";
		}else {
			msg="배송지 등록실패.다시 입력해주세요";
			loc="/ship/insertShipEnd";
			icon="warning";
		}
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.addObject("msg", msg);
		mv.setViewName("common/msg");
		return mv;
	}
}

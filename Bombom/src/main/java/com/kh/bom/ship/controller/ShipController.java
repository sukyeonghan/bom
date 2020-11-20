package com.kh.bom.ship.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.ship.model.Service.ShipService;
import com.kh.bom.ship.model.vo.Ship;

@Controller
public class ShipController {

	@Autowired
	ShipService service;
	
	@RequestMapping("/mypage/shipList")
	public ModelAndView shipList(ModelAndView mv,String memNo ) {
		memNo="M1000";
		List<Ship> list=service.selectShipList(memNo);
		mv.addObject("list",list);
		mv.setViewName("mypage/shipList");
		return mv;
	}
	
	@RequestMapping("/ship/insertShip")
	public String insertShip() {
		return "mypage/insertShip";
	}
	
}

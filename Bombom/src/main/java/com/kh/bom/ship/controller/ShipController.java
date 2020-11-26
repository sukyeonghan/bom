package com.kh.bom.ship.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.ship.model.Service.ShipService;
import com.kh.bom.ship.model.vo.Ship;

@Controller
public class ShipController {

	@Autowired
	ShipService service;
	
	@RequestMapping("/mypage/shipList")
	public ModelAndView shipList(ModelAndView mv,HttpSession session) {
		Member m=(Member)session.getAttribute("loginMember");
		List<Ship> list=service.selectShipList(m.getMemNo());
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
		String script="";
		String opener="";
		if(result>0) {
			msg="배송지 등록이 되었습니다.";
			loc="/mypage/shipList";
			icon="success";
			script="self.close()"; 
			opener="window.opener.location.reload()";
			
		}else {
			msg="배송지 등록실패.다시 입력해주세요";
			loc="/ship/insertShipEnd";
			icon="warning";
		}
		
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.addObject("msg", msg);
		mv.addObject("script", script);
		mv.addObject("opener", opener);
		mv.setViewName("common/msg");
		return mv;
	}
}

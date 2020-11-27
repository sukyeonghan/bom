package com.kh.bom.ship.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.ship.model.Service.ShipService;
import com.kh.bom.ship.model.vo.Ship;

@Controller
public class ShipController {

	@Autowired
	ShipService service;
	
	//배송지목록가져오기
	@RequestMapping("/mypage/shipList")
	public ModelAndView shipList(ModelAndView mv,HttpSession session) {
		Member m=(Member)session.getAttribute("loginMember");

		List<Ship> list=service.selectShipList(m.getMemNo());
		mv.addObject("list",list);
		mv.setViewName("mypage/shipList");
		return mv;
	}
	
	//배송지 등록창열기
	@RequestMapping("/ship/insertShip")
	public String insertShipView(String memNo,Model m) {
		m.addAttribute("memNo",memNo);
		return "mypage/ship";
	}
	
	//배송지 등록하기
	@RequestMapping("/ship/insertShipEnd")
	public ModelAndView insertShipEnd(Ship s,ModelAndView mv) {

		int result=service.insertShip(s);
		String loc="";
		String icon="";
		String msg="";
		String script="";//팝업창닫기위한
		String opener="";//opener 리로드
		if(result>0) {
			msg="배송지 등록이 되었습니다.";
			loc="/mypage/shipList";
			icon="success";
			script="self.close()"; 
			opener="window.opener.location.reload()";
			
		}else {
			msg="배송지 등록실패.다시 입력해주세요";
			loc="/ship/insertShip?memNo="+s.getMemNo();
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
	
	//배송지삭제
	@RequestMapping("/ship/deleteShip")
	public ModelAndView deleteShip(String shipNo,ModelAndView mv) {
		int result=service.deleteShip(shipNo);
		
		mv.addObject("msg",result>0?"삭제성공":"삭제실패");
		mv.addObject("loc","/mypage/shipList");
		mv.setViewName("common/msg");
		return mv;
	}
	
	//배송지수정페이지 열기
	@RequestMapping("/ship/updateShip")
	public String updateShip(String shipNo,Model m) {
		Ship s=service.selectShipOne(shipNo);
		m.addAttribute("ship",s);
		return "mypage/ship";
	}
	
	//배송지수정
	@RequestMapping("/ship/updateShipEnd")
	public ModelAndView updateShipEnd(Ship s,ModelAndView mv) {
		int result=service.updateShip(s);
		String loc="";
		String icon="";
		String msg="";
		String script="";
		String opener="";
		if(result>0) {
			loc="/mypage/shipList";
			icon="success";
			msg="배송지정보를 수정했습니다.";
			script="self.close()"; 
			opener="window.opener.location.reload()";
			
		}else {
			loc="/ship/updateShip?shipNo="+s.getShipNo();
			icon="warning";
			msg="배송지정보를 수정되지 못했습니다. 반복될경우 관리자에게 문의주세요.";
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

package com.kh.bom.point.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.service.PointService;
import com.kh.bom.point.model.vo.Point;

@Controller
public class PointController {
	
	private PointService service;
	
	//스탬프 10개 달성시
	@RequestMapping("/mypage/stamp10")
	public ModelAndView stamp10(ModelAndView mv,@RequestParam Map param) {
		int result=service.stamp10(param);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg=param.get("changePoint")+"봄이 지급되었습니다. 적립금을확인해보세요! ";
			loc="/mypage/myPointList";
			icon="success";
		}else {
			msg="적립금 지급 : error 관리자에게 문의해주세요.";
			loc="/mypage/stamp";
			icon="error";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");
		return mv;
	}
	//포인트 내역 가져오기
	@RequestMapping("/mypage/myPointList")
	public ModelAndView selectPointList(ModelAndView mv,@SessionAttribute("loginMember") Member m) {
		List<Point> list=service.selectPointList(m.getMemNo());
		mv.addObject("list",list);
		mv.setViewName("mypage/myPointList");
		return mv;
	}
	
}

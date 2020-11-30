package com.kh.bom.point.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.service.PointService;
import com.kh.bom.point.model.vo.Point;

@Controller
public class PointController {
	@Autowired
	private PointService service;
	@Autowired
	private MemberService memberService;
	//스탬프 10개 달성시
	@RequestMapping("/mypage/stamp10")
	public ModelAndView stamp10(ModelAndView mv,Point p,HttpSession session) {
		p.setPointContent("엣헴이 스탬프 10개달성 보상");
		int result=service.stampInsertPoint(p);
		String msg="";
		String loc="";
		String icon="";
		if(result>0) {
			msg=p.getPointChange()+"봄이 지급되었습니다. 적립금을확인해보세요! ";
			loc="/mypage/myPointList";
			icon="success";
			mv.addObject("loginMember",memberService.selectMemberOne(p.getMemNo()));   
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
	public ModelAndView selectPointList(ModelAndView mv,HttpSession session) {
		Member m=(Member)session.getAttribute("loginMember");
		String memNo=m.getMemNo();
		List<Point> list=service.selectPointList(memNo);
		mv.addObject("loginMember",m);
		mv.addObject("list",list);
		mv.setViewName("mypage/myPointList");
		return mv;
	}
	
}

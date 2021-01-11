package com.kh.bom.point.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.PointAjaxPageBarFactory;
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
	public ModelAndView stamp10(ModelAndView mv,Point p,HttpSession session) throws Exception {
		p.setPointContent("엣헴이 스탬프 10개달성 보상");
		int result=service.insertStampPoint(p);
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
		mv.setViewName("common/msg");
		mv.addObject("msg",msg);
		mv.addObject("loc",loc);
		mv.addObject("icon",icon);
		return mv;
	}
	
	//포인트 내역 가져오기
	@RequestMapping("/mypage/myPointList")
	public ModelAndView selectPointList(ModelAndView mv,HttpSession session,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage) {
		Member m=(Member)session.getAttribute("loginMember");
		String memNo=m.getMemNo();
		
		String start="";
		String end="";
		String filter="";
		
		Map<String, String> map = new HashMap();
		map.put("memNo", memNo);
		map.put("start", start);
		map.put("end", end);
		map.put("filter", filter);		
		List<Point> list=service.selectPointList(map,cPage,numPerpage);
		int totalData=service.selectCount(map);
		int totalPoint=service.selectTotalPoint(memNo);
		mv.addObject("totalPoint",totalPoint);
		mv.addObject("list",list);
		mv.addObject("start",start);
		mv.addObject("end",end);
		mv.addObject("filter",filter);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",PointAjaxPageBarFactory.getPageBar(totalData, cPage, numPerpage, "myPointListAjax",start,end,filter));
		mv.setViewName("mypage/myPointList");
		return mv;
	}
	
	//포인트 내역 가져오기
	@RequestMapping("/mypage/myPointListAjax")
	@ResponseBody
	public ModelAndView selectPointListAjax(ModelAndView mv,HttpSession session,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="5") int numPerpage,
			@RequestParam(value="start") String start,
			@RequestParam(value="end") String end,
			@RequestParam(value="filter",defaultValue="all") String filter) {
		Member m=(Member)session.getAttribute("loginMember");
		String memNo=m.getMemNo();
		Map<String, String> map = new HashMap();
		map.put("memNo", memNo);
		map.put("start", start);
		map.put("end", end);
		map.put("filter", filter);		
		List<Point> list=service.selectPointList(map,cPage,numPerpage);
		int totalData=service.selectCount(map);
		int totalPoint=service.selectTotalPoint(memNo);
		mv.addObject("totalPoint",totalPoint);
		mv.addObject("list",list);
		mv.addObject("start",start);
		mv.addObject("end",end);
		mv.addObject("filter",filter);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",PointAjaxPageBarFactory.getPageBar(totalData, cPage, numPerpage, "myPointListAjax",start,end,filter));
		mv.setViewName("mypage/myPointListAjax");
		return mv;
	}
	
}

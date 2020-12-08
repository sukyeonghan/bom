package com.kh.bom.admin.controller;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	@RequestMapping("/admin/moveEvent")
	public ModelAndView moveEventList(ModelAndView m) {
		List<Event> list = service.selectEvent();
		m.addObject("list", service.selectEvent());
		m.setViewName("admin/event/eventList");
		
		return m;
	}
	
	//이벤트 한개row삭제
	@RequestMapping("/admin/eventDelete")
	public ModelAndView eventDelete(ModelAndView mv,String eventNo) {
		int result = service.eventDelete(eventNo);
		String msg = "";
		String loc = "";
		String icon = "";
		if(result>0) {
			msg = "삭제가 완료되었습니다!";
			loc = "/admin/moveEvent";
			icon = "success";
		}else {
			msg = "삭제가 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//이벤트등록페이지로 이동
	@RequestMapping("/admin/moveInsertEvent")
	public String moveEventWriteForm() {
		return "admin/event/eventWrite";
	}
	
	@RequestMapping("/admin/insertEvent")
	public ModelAndView insertEvent(ModelAndView mv, String eventTitle, 
			@DateTimeFormat(pattern = "yyyyMMdd") String eventStartDate,
			@DateTimeFormat(pattern = "yyyyMMdd") String eventEndDate,
			String eventCategory, int eventSalePer) throws ParseException {	
		
		System.out.println(eventStartDate); //2020-11-11
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = (Date) sf.parse(eventStartDate);
		Date d2 = (Date) sf.parse(eventEndDate);
		
		Event e = new Event();
		e.setEventTitle(eventTitle);
		e.setEventStartDate(d);
		e.setEventEndDate(d2);
		e.setEventCategory(eventCategory);
		e.setEventSalePer(eventSalePer);
		int result = service.insertEvent(e);
		
		String msg = "";
		String loc = "";
		String icon = "";
		if(result>0) {
			msg = "이벤트가 생성되었습니다!:)";
			loc = "/admin/moveEvent";
			icon = "success";
		}else {
			msg = "생성이 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}
	//이벤트 수정
	@RequestMapping("admin/moveEventUpdate")
	public ModelAndView moveUpdateEvent(ModelAndView mv, String eventNo) {
		Event e = service.selectEvent(eventNo);
		mv.addObject("e", e);
		mv.setViewName("admin/event/eventUpdate");
		return mv;
	}
	@RequestMapping("/admin/eventUpdate")
	public ModelAndView updateEvent(ModelAndView mv,String eventNo, String eventTitle, 
			@DateTimeFormat(pattern = "yyyyMMdd") String eventStartDate,
			@DateTimeFormat(pattern = "yyyyMMdd") String eventEndDate,
			String eventCategory, int eventSalePer) throws ParseException {	
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = (Date) sf.parse(eventStartDate);
		Date d2 = (Date) sf.parse(eventEndDate);
		Event e = new Event();
		e.setEventNo(eventNo);
		e.setEventTitle(eventTitle);
		e.setEventStartDate(d);
		e.setEventEndDate(d2);
		e.setEventCategory(eventCategory);
		e.setEventSalePer(eventSalePer);
		int result = service.updateEvent(e);
		
		String msg = "";
		String loc = "";
		String icon = "";
		if(result>0) {
			msg = "이벤트가 수정되었습니다!:)";
			loc = "/admin/moveEvent";
			icon = "success";
		}else {
			msg = "수정이 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		
		return mv;
	}
	
	//회원관리
	@RequestMapping("/admin/memberList")
	public ModelAndView memberList(ModelAndView mv,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
		List<Member> list=service.selectMemberList(cPage, numPerpage);
		int totalData=service.selectMemberCount();
		mv.addObject("list",list);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "memberList"));
		mv.setViewName("admin/member/memberList");
		return mv;
	}
	//관리지 권한 변경	
	@RequestMapping("/admin/updateManagerYn")
	@ResponseBody
	public boolean updateManagerYn(Member m) {
		int result=service.updateManagerYn(m);
		return result>0?true:false;		
	}
	//회원검색기능
	@RequestMapping("/adimin/selectMemberSearch")
	public ModelAndView selectMemberSearch(ModelAndView mv,
			@RequestParam(value="searchType") String searchType,
			@RequestParam(value="keyword") String keyword,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
		Map<String,String> map=new HashMap();
		map.put("searchType", searchType);
		map.put("keyword", keyword);
		List<Member>list =service.selectMemberSearch(cPage, numPerpage,map);
		int totalData=service.selectMemberCount(map);
		mv.addObject("list",list);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage,"selectMemberSearch",searchType, keyword));
		mv.setViewName("admin/member/memberList");
		return mv;
	}
	//회원검색자동완성
	@RequestMapping("/admin/memberAutoComplete")
	@ResponseBody
	public List<Member> memberAutoComplete(
			@RequestParam(value="type", defaultValue="all")String type,
			@RequestParam(value="key") String key) {
		Map<String,String> map=new HashMap();
		map.put("type", type);
		map.put("key", key);
		List<Member> list=service.memberAutoComplete(map);
		return list;
	}
	
	
	
	//1:1문의 
	//qna(1:1) 목록 가져오기
		@RequestMapping("/admin/qnaList")
		public ModelAndView qnaList(ModelAndView mv,
				@RequestParam(value="cPage", defaultValue="0") int cPage,
				@RequestParam(value="numPerpage", defaultValue="5") int numPerpage) {
			
			mv.addObject("list",service.selectQnaList(cPage,numPerpage));
			int totalData=service.selectQnaCount();
			
			mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "qnaList"));
			mv.addObject("totalData", totalData);
			mv.setViewName("admin/qna/qnaList");
			
			return mv;
		}
		

}

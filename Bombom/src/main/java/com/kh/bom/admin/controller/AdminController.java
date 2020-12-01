package com.kh.bom.admin.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.member.model.vo.Member;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;

	//제품 관리페이지
	@RequestMapping("/admin/moveProduct")
	public String moveProductListPage() {
		return "admin/product/productList";
	}
	//제품 등록 페이지
	@RequestMapping("/admin/productInsert")
	public ModelAndView moveProductinsertPage(ModelAndView m) {
		List<Event> selectEvent =service.selectEvent();
		m.addObject("list",selectEvent );
		m.setViewName("admin/product/insertProduct");
		return m;
	}
	//제품 수정 및 삭제 페이지
	@RequestMapping("/admin/productUpdate")
	public String moveProductUpdatePage() {
		return "admin/product/updateProduct";
	}
	
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
		System.out.println(eventNo);
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
	//회원관리
	@RequestMapping("/admin/memberList")
	public ModelAndView memberList(ModelAndView mv,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
		List<Member> list=service.selectMemberList();
		int totalData=service.selectMemberCount();
		mv.addObject("list",list);
		mv.addObject("pagebar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "memberList"));
		mv.setViewName("admin/member/memberList");
		return mv;
	}
}

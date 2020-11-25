package com.kh.bom.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.Event;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;

	@RequestMapping("/admin/moveProduct")
	public String moveProductListPage() {
		return "admin/productList";
	}
	
	@RequestMapping("/admin/productInsert")
	public String moveProductinsertPage() {
		return "admin/insertProduct";
	}
	
	@RequestMapping("/admin/productUpdate")
	public String moveProductUpdatePage() {
		return "admin/updateProduct";
	}
	
	@RequestMapping("/admin/moveEvent")
	public ModelAndView moveEventList(ModelAndView m) {
		List<Event> list = service.selectEvent();
		System.out.println(list);
		m.addObject("list", service.selectEvent());
		m.setViewName("admin/eventList");
		
		return m;
	}
}

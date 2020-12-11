package com.kh.bom.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.MainBanner;
import com.kh.bom.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BannerController {
	@Autowired
	private AdminService service;
	
	//배너 불러오기
	@RequestMapping("/admin/moveMainBanners")
	public ModelAndView moveBanner(ModelAndView mv) {
		List<MainBanner> list = service.selectBannerList();
		
		mv.addObject("list",list);
		mv.setViewName("admin/main/banner");
		return mv;
	}
	
	//배너등록하기
	@RequestMapping("/admin/moveInsertBanner")
	public String moveInsertBanner(Model m) {
		List<Product> list = service.selectProductList();
		m.addAttribute("list", list);
		return "admin/main/BannerWrite";
	}
	@RequestMapping("/admin/insertBanner")
	public ModelAndView insertBanner(MainBanner mb, ModelAndView mv,
			@RequestParam(value="bannerThumb", required = false) MultipartFile bannerThumb, HttpSession session) {
		System.out.println(mb);
		//upload실제 경로 가져오기
		String path = session.getServletContext().getRealPath("resources/images/main/banner");
		
		return mv;
	}
}

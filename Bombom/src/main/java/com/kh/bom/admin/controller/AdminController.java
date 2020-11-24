package com.kh.bom.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

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
	
}

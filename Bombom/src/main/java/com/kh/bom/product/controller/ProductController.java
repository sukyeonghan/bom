package com.kh.bom.product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.bom.product.model.service.ProductService;

@Controller
public class ProductController {

	@Autowired
	private ProductService service;
	
	
	@RequestMapping("/product/productAll") 
	public String allProduct() { 
		
		return "product/productList/AllList";
	}
	 
	
}

package com.kh.bom.intro.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class introController {
	
	@RequestMapping("/intro/moveIntro")
	public String moveIntro() {
		return "intro/intro";
	}

}

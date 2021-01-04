package com.kh.bom.agreement.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class agreementController {
	@RequestMapping("/agreement/view")
	public String moveIntro() {
		return "common/agreement";
	}
}

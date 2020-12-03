package com.kh.bom.zzim.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.zzim.model.service.ZzimService;
import com.kh.bom.zzim.model.vo.Zzim;
@Controller
public class ZzimController {
	@Autowired
	private ZzimService service;
	
	@RequestMapping("/mypage/zzimList")
	public ModelAndView selectZzimList(ModelAndView mv,HttpSession session) {
		Member m=(Member)session.getAttribute("loginMember");
		List<Zzim> zzimList=service.selectZzimList(m.getMemNo());
		mv.addObject(zzimList);
		mv.setViewName("mypage/zzimList");
		return mv;
	}
	
	@RequestMapping("/zzim/insertZzim")
	public ModelAndView insertZzim(ModelAndView mv,Zzim z) {
		int result =service.insertZzim(z);
		if(result>0) {
			mv.addObject("zzim",z);
		}else {
			mv.addObject("msg","폴더생성실패, 반복될 경우 관리자에게 문의해주세요");
			mv.setViewName("common/msg");
		}
		return mv;
	}
}

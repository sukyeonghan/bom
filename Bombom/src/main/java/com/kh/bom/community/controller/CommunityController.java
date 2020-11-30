package com.kh.bom.community.controller;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.community.model.vo.Community;
import com.kh.bom.community.model.service.CommunityService;

@Controller
public class CommunityController {

	@Autowired
	private CommunityService service;

	// communityList
	@RequestMapping("/community/communityList")
	public ModelAndView selectCommunityList(ModelAndView mv) {
		mv.addObject("list", service.selectCommunityList());
		mv.setViewName("/community/communityList");

		return mv;
	}

	// community 수정/등록 창으로 전환
	@RequestMapping("/community/communityForm")
	public String community() {
		return "/community/communityForm";
		
		
	}

	// community 등록

	@RequestMapping("/community/insertCommunity")
	public ModelAndView insertCommunity(Community community, ModelAndView mv) {
		int result = service.insertCommunity(community);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "게시글 등록 성공";
			loc = "/community/communityList";
			icon = "success"; // icon 종류 : success,error,warning
		} else {
			msg = "게시글 질문 등록 실패";
			loc = "/community/communityForm";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;

	}

	// 게시글 상세보기
	@RequestMapping("/community/communityView.do")
	public ModelAndView commmunityView(String cmNo, ModelAndView mv) {
		mv.addObject("community", service.communityView(cmNo));
		mv.addObject("community", service.selectCommunityOne(cmNo));
		mv.setViewName("community/communityView");
		
		return mv;
	}

	// 커뮤니티 삭제
	@RequestMapping("/community/deleteCommunity")
	public ModelAndView deleteCommunity(String cmNo, ModelAndView mv) {
		int result = service.deleteCommunity(cmNo);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "글 삭제 성공";
			loc = "/community/communityList";
		} else {
			msg = " 삭제 실패";
			loc = "/community/communityForm";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}

	// 커뮤니티 수정
	@RequestMapping("/community/updateCommunity")
	public ModelAndView selectCommunityOne(String cmNo, ModelAndView mv) {
		Community community = service.selectCommunityOne(cmNo);
		mv.addObject("community", community);
		mv.setViewName("/community/communityForm");
		return mv;
	}

	@RequestMapping("/community/updateCommunityEnd")
	public ModelAndView updateCommunity(Community community, ModelAndView mv) {
		int result = service.updateCommunity(community);
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "글 수정 성공";
			loc = "/community/communityList";
		} else {
			msg = "글 수정 실패";
			loc = "/community/updateCommunity?cmNo=" + community.getCmNo();
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;

	}

}
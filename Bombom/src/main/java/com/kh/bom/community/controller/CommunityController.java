package com.kh.bom.community.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.community.model.vo.Community;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.community.model.service.CommunityService;

@Controller
public class CommunityController {

	@Autowired
	private CommunityService service;

	// communityList, 로그인 후 접근 가능
	@RequestMapping("/community/communityList")
	public ModelAndView selectCommunityList(ModelAndView mv,
			@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "6") int numPerpage) {

		mv.addObject("list", service.selectCommunityList(cPage, numPerpage));
		int totalData = service.selectCount();

		mv.addObject("pageBar", PageBarFactory.getPageBar(totalData, cPage, numPerpage, "communityList"));
		mv.addObject("totalData", totalData);

		mv.setViewName("/community/communityList");

		return mv;
	}

	// community 수정/등록 창으로 전환
	@RequestMapping("/community/communityForm")
	public String community() {
		return "/community/communityForm";

	}

	// community 등록
	// 클라이언트가 보낸 파일 받기!
	@RequestMapping("/community/insertCommunity")
	public ModelAndView insertCommunity(Community community, ModelAndView mv,
			@RequestParam(value = "upFile", required = false) MultipartFile upFile, HttpSession session) {

		System.out.println(community);
		System.out.println(upFile);
		
		String on = upFile.getOriginalFilename(); //원본 파일 명
		
		System.out.println(on);
		
		
		// 클라이언트가 바이너리파일로 보낸 데이터를 MultipartFile 객체로 대입됨.
		// getName(), getOriginalFilename(), getSize(), transferTo()

		// upload실제 경로를 가져와야함.
		String path = session.getServletContext().getRealPath("/resources/upload/community");

		File dir = new File(path);
		if (!dir.exists())
			dir.mkdirs();// 폴더를 생성

		if (upFile != null) {
			try {
				upFile.transferTo(new File(path + "/" + on));
			} catch (IOException e) {
				e.printStackTrace();
			}
              community.setCmThumbnail(on);
		}

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
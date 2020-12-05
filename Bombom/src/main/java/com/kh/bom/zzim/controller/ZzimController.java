package com.kh.bom.zzim.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.zzim.model.service.ZzimService;
import com.kh.bom.zzim.model.vo.Zzim;
import com.kh.bom.zzim.model.vo.ZzimContent;
@Controller
public class ZzimController {
	@Autowired
	private ZzimService service;
	/*마이페이지 찜목록 리스트*/
	@RequestMapping("/mypage/zzimList")
	public ModelAndView selectZzimList(ModelAndView mv,HttpSession session) {
		Member m=(Member)session.getAttribute("loginMember");
		List<Zzim> zzimList=service.selectZzimList(m.getMemNo());
		mv.addObject("zzimList",zzimList);
		mv.setViewName("mypage/zzimList");
		return mv;
	}
	
	/*찜 폴더 생성*/
	@RequestMapping("/zzim/insertZzim")
	public ModelAndView insertZzim(ModelAndView mv,Zzim z) {
		int result =service.insertZzim(z);
		if(result>0) {
			z.setZzimNo(service.selectSeqZzimNo());	
			mv.addObject("zzim",z);
			mv.setViewName("mypage/addZzimFolder");
		}
		return mv;
	}
	
	@RequestMapping("/zzim/selectZzimContent")
	public ModelAndView selectZzimContentList(ModelAndView mv,String zzimNo,String zzimName) {
		List<ZzimContent> list =service.selectZzimContentList(zzimNo);
		mv.addObject("zcList",list);
		mv.addObject("zzimFolderName",zzimName);
		mv.setViewName("mypage/zzimContentList");
		return mv;
	}
	
	@RequestMapping("/zzim/deleteZzim")
	public ModelAndView deleteZzim(ModelAndView mv,@RequestParam(value="delZzimNo")List<String> zzimNoList) {
		System.out.println(zzimNoList);
		int result=service.deleteZzim(zzimNoList);
		String msg="";
		String icon="";
		String loc="";
		if(result>0) {
			msg="선택하신 폴더가 삭제되었습니다.";
		}else {
			msg="삭제실패; 반복될 경우 관리자에게 문의해주세요";
		}
		mv.addObject("msg",msg);
		mv.addObject("icon",icon);
		mv.addObject("loc","/mypage/zzimList");
		mv.setViewName("common/msg");
		return mv;
	}
}

package com.kh.bom.zzim.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	//찜폴더 내 찜콘텐츠리스트
	@RequestMapping("/zzim/selectZzimContent")
	public ModelAndView selectZzimContentList(ModelAndView mv,String zzimNo,String zzimName) {
		List<ZzimContent> list =service.selectZzimContentList(zzimNo);
		mv.addObject("zcList",list);
		mv.addObject("zzimFolderName",zzimName);
		mv.addObject("zzimNo",zzimNo);
		mv.setViewName("mypage/zzimContentList");
		return mv;
	}
	//다중 찜폴더 삭제
	@RequestMapping("/zzim/deleteZzim")
	public ModelAndView deleteZzim(ModelAndView mv,@RequestParam(value="delZzimNo")List<String> zzimNoList) {
		System.out.println(zzimNoList);
		int result=service.deleteZzim(zzimNoList);
		String msg="";
		String icon="";
		if(result>0) {
			msg="선택하신 폴더가 삭제되었습니다.";
			icon="success";
		}else {
			msg="삭제실패; 반복될 경우 관리자에게 문의해주세요";
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("icon",icon);
		mv.addObject("loc","/mypage/zzimList");
		mv.setViewName("common/msg");
		return mv;
	}

	//찜 콘텐츠리스트 내에서 찜 폴더 이름 변경시 
	@RequestMapping("/zzim/updateZzimName")
	@ResponseBody
	public boolean updateZzimName(Zzim zzim) throws IOException  {
		int result=service.updateZzimName(zzim);
		return result>0?true:false;
	}
	
	//찜 콘텐츠리스트 내에서 찜 폴더 한개 삭제
	@RequestMapping("/zzim/deleteZzimOne")
	public ModelAndView deleteZzimOne(ModelAndView mv,String zzimNo) {
		int result=service.deleteZzimOne(zzimNo);
		String msg="";
		String icon="";
		if(result>0) {
			msg="폴더가 삭제되었습니다.";
			icon="success";
		}else {
			msg="삭제실패; 반복될 경우 관리자에게 문의해주세요";
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("icon",icon);
		mv.addObject("loc","/mypage/zzimList");
		mv.setViewName("common/msg");
		return mv;
	}
	//찜 상품삭제
	@RequestMapping("/zzim/deleteZzimContent")
	public ModelAndView deleteZzimContent(ModelAndView mv,
		@RequestParam(value="pdtNoCkBox") List<String> pdtNoList,Zzim z) {
		int result=service.deleteZzimContent(pdtNoList);
		String msg="";
		String icon="";
		if(result>0) {
			msg="선택하신 상품이 삭제되었습니다.";
			icon="success";
		}else {
			msg="삭제실패; 반복될 경우 관리자에게 문의해주세요";
			icon="warning";
		}
		mv.addObject("msg",msg);
		mv.addObject("icon",icon);
		mv.addObject("loc","/zzim/selectZzimContent?zzimNo="+z.getZzimNo()+"&zzimName="+z.getZzimName());
		mv.setViewName("common/msg");
		return mv;
	}
}

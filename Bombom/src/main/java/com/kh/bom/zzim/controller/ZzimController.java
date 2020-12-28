package com.kh.bom.zzim.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		Zzim zzim = new Zzim();
		if(result>0) {
			String zzimNo=service.selectSeqZzimNo();	
			zzim=service.selectZzimOne(zzimNo);
			mv.addObject("zzim",zzim);
			mv.setViewName("mypage/addZzimFolder");
		}
		return mv;
	}
	//폴더이동 모달 내 찜폴더추가
	@RequestMapping("/zzim/insertZzim2")
	@ResponseBody
	public Zzim insertZzim(Zzim z) {
		int result =service.insertZzim(z);
		Zzim zzim=new Zzim();
		if(result>0) {
			String zzimNo=service.selectSeqZzimNo();
			zzim=service.selectZzimOne(zzimNo);
		}
		return zzim;
	}
	//찜폴더 내 찜콘텐츠리스트
	@RequestMapping("/zzim/selectZzimContent")
	public ModelAndView selectZzimContentList(ModelAndView mv,String zzimNo,String zzimName) {
		List<ZzimContent> list =service.selectZzimContentList(zzimNo);
		Zzim z=service.selectZzimOne(zzimNo);
		mv.addObject("zcList",list);
		mv.addObject("zzimName",z.getZzimName());
		mv.addObject("zzimNo",zzimNo);
		mv.setViewName("mypage/zzimContentList");
		return mv;
	}
	//다중 찜폴더 삭제
	@RequestMapping("/zzim/deleteZzim")
	public ModelAndView deleteZzim(ModelAndView mv,@RequestParam(value="delZzimNo")List<String> zzimNoList) {
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
		@RequestParam(value="zzimContentNoCkBox") List<String> zzimContentNoList,Zzim z) {
		
		int result=service.deleteZzimContent(zzimContentNoList);
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
		mv.addObject("loc","/zzim/selectZzimContent?zzimNo="+z.getZzimNo());
		mv.setViewName("common/msg");
		return mv;
	}
	//찜 폴더 리스트 모달열기
	@RequestMapping("/zzim/zzimListModal")
	public ModelAndView zzimListModal(ModelAndView mv,
			@RequestParam(value="zzimContentNoList[]") List<String>zcNoList,
			HttpSession session) {
		Member m=(Member)session.getAttribute("loginMember");
		List<Zzim> zzimList=service.selectZzimList(m.getMemNo());
		System.out.println(zcNoList);
		mv.addObject("zcNoList",zcNoList);
		mv.addObject("zzimList",zzimList);
		mv.setViewName("mypage/zzimListModal");
		return mv; 
	}
	//찜상품 폴더이동
	@RequestMapping("/zzim/updateZzimNo")
	public ModelAndView updateZzimNo(ModelAndView mv,
			@RequestParam(value="zcNo") List<String> zcNoList,
			@RequestParam(value="updateZzimNo") String zzimNo) {
		System.out.println(zcNoList);
		System.out.println(zzimNo);
		Map map=new HashMap();
		map.put("zcNoList", zcNoList);
		map.put("zzimNo",zzimNo);
		System.out.println(map);
		String msg="";
		int result=service.updateZzimNo(map);
		if(result>0) {
			msg="폴더가 이동되었습니다.";
		}else {
			msg="폴더이동실패";
		}
		mv.addObject("msg",msg);
		mv.addObject("loc","/mypage/zzimList");
		mv.setViewName("common/msg");
		return mv;
	}
	
	
	//상품페이지 - 찜하기 폴더 추가
	@RequestMapping("/zzim/proInsertZzim")
	public ModelAndView proInsertZzim(String pdtNo, Zzim z, ModelAndView mv, HttpSession session) {
		
		//폴더생성
		int result = service.proInsertZzim(z);
		String msg = "";
		String loc = "/product/productOne?pdtNo="+pdtNo;

		if(result>0) {
			//생성된 폴더에 해당 제품 추가
			String zzimNo = service.selectSeqZzimNo();
			Map map = new HashMap();
			map.put("pdtNo",pdtNo);
			map.put("zzimNo", zzimNo);
			int result2 = service.proInsertZzimContent(map);
			msg = "해당폴더에 찜추가가 완료되었습니다";
		}else {
			msg = "폴더생성에 실패했습니다. 다시 시도해주세요";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//상품페이지 - 찜하기 추가
	@RequestMapping("/zzim/proInsertZzim2")
	@ResponseBody
	public boolean proInsertZzim2(Zzim z) {
		
		int result = service.proInsertZzim2(z);
		return result>0?true:false;
	}
	
	
	
	
	
	
	
}

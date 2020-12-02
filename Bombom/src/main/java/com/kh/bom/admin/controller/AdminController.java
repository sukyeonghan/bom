package com.kh.bom.admin.controller;


import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductThumb;



@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;

	//by수경-제품 관리페이지 전환
	@RequestMapping("/admin/moveProduct")
	public String moveProductListPage() {
		return "admin/product/productList";
	}
	//by수경-제품 등록 페이지 전환
	@RequestMapping("/admin/productInsert")
	public ModelAndView moveProductinsertPage(ModelAndView m) {
		List<Event> selectEvent =service.selectEvent();
		m.addObject("list",selectEvent );
		m.setViewName("admin/product/insertProduct");
		return m;
	}
	//by수경-제품 등록-201202수정
	@RequestMapping("/admin/productInsertEnd")
	public ModelAndView insertProduct(Product p,ModelAndView m,
			@RequestParam(value="pdtOptionAddprice", required = false,defaultValue="0") int addPrice, 
			@RequestParam(value="thumbImgs",required=false) MultipartFile[] thumbImgs,
			@RequestParam(value="detailImg",required=false) MultipartFile[] detailImg,
			HttpSession session) {
		
		String path=session.getServletContext().getRealPath("/resources/upload/product");
		File dir=new File(path);
		
		if(!dir.exists()) dir.mkdirs();
		List<ProductThumb> files=new ArrayList();
		//썸네일 이미지 저장하기
		for(MultipartFile f : thumbImgs) {
			if(!f.isEmpty()) {
				//본래 파일이름 가져오기
				String originalName=f.getOriginalFilename();
				//확장자 분리
				String ext=originalName.substring(originalName.lastIndexOf(".")+1);
				//리네임양식정하기
				SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				int rndValue=(int)(Math.random()*1000);
				String reName="thm"+sdf.format(System.currentTimeMillis())+"_"+rndValue+"."+ext;
				try {
					f.transferTo(new File(path+"/"+reName));
				}catch(IOException e) {
					e.printStackTrace();
				}
				ProductThumb thm =  ProductThumb.builder().originalFileName(originalName)
						.renamedFileName(reName).build();
				files.add(thm);
			}
		}
		//상세 이미지 저장하기
		for(MultipartFile ff:detailImg) {
			String originalName=ff.getOriginalFilename();
			//확장자 분리
			String ext=originalName.substring(originalName.lastIndexOf(".")+1);
			//리네임양식정하기
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			int rndValue=(int)(Math.random()*1000);
			String reName="det"+sdf.format(System.currentTimeMillis())+"_"+rndValue+"."+ext;
			try {
				ff.transferTo(new File(path+"/"+reName));
			}catch(IOException e) {
				e.printStackTrace();
			}
			p.setPdtDetailImage(reName);
		}
		int result=service.insertProduct(p,files);
		String msg="";
		String icon = "";
		if(result>0) {
			msg="제품 등록이 완료되었습니다.";
			icon = "success";
		}else {
			msg="제품 등록에 실패하였습니다.";
			icon = "error";
		}
		m.addObject("msg", msg);
		m.addObject("loc","/admin/moveProduct");
		m.addObject("icon", icon);
		m.setViewName("common/msg");
		return m;
	}
	
	//by수경-제품 수정 및 삭제 페이지 전환
	@RequestMapping("/admin/productUpdate")
	public String moveProductUpdatePage() {
		return "admin/product/updateProduct";
	}
	
	@RequestMapping("/admin/moveEvent")
	public ModelAndView moveEventList(ModelAndView m) {
		List<Event> list = service.selectEvent();
		m.addObject("list", service.selectEvent());
		m.setViewName("admin/event/eventList");
		
		return m;
	}
	
	//이벤트 한개row삭제
	@RequestMapping("/admin/eventDelete")
	public ModelAndView eventDelete(ModelAndView mv,String eventNo) {
		System.out.println(eventNo);
		int result = service.eventDelete(eventNo);
		String msg = "";
		String loc = "";
		String icon = "";
		if(result>0) {
			msg = "삭제가 완료되었습니다!";
			loc = "/admin/moveEvent";
			icon = "success";
		}else {
			msg = "삭제가 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}
	
	//이벤트등록페이지로 이동
	@RequestMapping("/admin/moveInsertEvent")
	public String moveEventWriteForm() {
		return "admin/event/eventWrite";
	}
	
	@RequestMapping("/admin/insertEvent")
	public ModelAndView insertEvent(ModelAndView mv, String eventTitle, 
			@DateTimeFormat(pattern = "yyyyMMdd") String eventStartDate,
			@DateTimeFormat(pattern = "yyyyMMdd") String eventEndDate,
			String eventCategory, int eventSalePer) throws ParseException {	
		
		System.out.println(eventStartDate); //2020-11-11
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = (Date) sf.parse(eventStartDate);
		Date d2 = (Date) sf.parse(eventEndDate);
		
		Event e = new Event();
		e.setEventTitle(eventTitle);
		e.setEventStartDate(d);
		e.setEventEndDate(d2);
		e.setEventCategory(eventCategory);
		e.setEventSalePer(eventSalePer);
		int result = service.insertEvent(e);
		
		String msg = "";
		String loc = "";
		String icon = "";
		if(result>0) {
			msg = "이벤트가 생성되었습니다!:)";
			loc = "/admin/moveEvent";
			icon = "success";
		}else {
			msg = "생성이 실패했어요:(";
			loc = "/admin/moveEvent";
			icon = "error";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		return mv;
	}
	//회원관리
	@RequestMapping("/admin/memberList")
	public ModelAndView memberList(ModelAndView mv,
			@RequestParam(value="cPage",defaultValue="1") int cPage,
			@RequestParam(value="numPerpage",defaultValue="10") int numPerpage) {
		List<Member> list=service.selectMemberList(cPage, numPerpage);
		int totalData=service.selectMemberCount();
		mv.addObject("list",list);
		mv.addObject("cPage", cPage);
		mv.addObject("pageBar",PageBarFactory.getPageBar(totalData, cPage, numPerpage, "memberList"));
		mv.setViewName("admin/member/memberList");
		return mv;
	}
}

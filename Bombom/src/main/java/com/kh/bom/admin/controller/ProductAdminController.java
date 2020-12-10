package com.kh.bom.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.product.model.service.ProductService;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ProductAdminController {
	
	@Autowired
	private AdminService service;
	@Autowired
	private ProductService proService;

	//by수경-제품 관리페이지 전환
	@RequestMapping("/admin/moveProduct")
	public ModelAndView moveProductListPage(ModelAndView m) {
		List<Product> list=service.selectProductList();
		int count=proService.productAllCount();
		m.addObject("list",list);
		m.addObject("count",count);
		m.setViewName("admin/product/productList");
		return m;
	}
	
	//by수경-제품 목록페이지에서 선택 삭제
	 @RequestMapping("/admin/deleteSelect") 
	 public ModelAndView deleteSelectProduct(
			 @RequestParam List<String> pdtNo,ModelAndView m) { 
		 int result=service.deleteSelectProduct(pdtNo); 
		 String msg="";
		 String icon="";
		 if(result>0) {
			msg="삭제에 성공하였습니다.";
			icon="success";
		 }else {
			msg="삭제에 실패하였습니다.";
			icon = "error";
		 }
		 m.addObject("msg", msg);
		 m.addObject("loc","/admin/moveProduct");
		 m.addObject("icon", icon);
		 m.setViewName("common/msg");
		 return m; 
	}
	//제품 목록 페이지에서 ajax
	@RequestMapping("/admin/productListAjax")
	public ModelAndView productListAjax(ModelAndView m,
			@RequestParam(value = "sort") String sort) {
		List<Product> list;
		int count;
		if(sort.equals("전체")) {
			list=service.selectProductList();
			count=proService.productAllCount();
		
		}else {
			list=service.cateProductList(sort);
			count=proService.productCateCount(sort);
		}
		m.addObject("list",list);
		m.addObject("sort",sort);
		m.addObject("count",count);
		m.setViewName("admin/product/productListAjax");
		return m;
	}
	
	//by수경-제품 등록 페이지 전환
	@RequestMapping("/admin/productInsert")
	public ModelAndView moveProductinsertPage(ModelAndView m) {
		List<Event> selectEvent =service.selectEvent();
		m.addObject("list",selectEvent );
		m.setViewName("admin/product/insertProduct");
		return m;
	}
	//by수경-제품 등록-201204수정
	@RequestMapping("/admin/productInsertEnd")
	public ModelAndView insertProduct(Product p,ProductOption o,ModelAndView m,
			@RequestParam(value="test",required = false) String options,
			@RequestParam(value="thumbImgs",required=false) MultipartFile[] thumbImgs,
			@RequestParam(value="detailImg",required=false) MultipartFile[] detailImg,
			HttpSession session) {
		//옵션 등록
		ObjectMapper mapper=new ObjectMapper();
		List<Map<Object, Object>> optionMap=null;
		try {
			optionMap = mapper.readValue(options, ArrayList.class);
		} catch (JsonMappingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (JsonProcessingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

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
		int result=service.insertProduct(p,o,optionMap,files);
		
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
	public ModelAndView moveProductUpdatePage(String pdtNo,ModelAndView m) {
		Product p=service.selectOneProduct(pdtNo);
		List<ProductOption> o=service.selectOption(pdtNo);
		List<ProductThumb> th=service.selectThumb(pdtNo);
		List<Event> event =service.selectEvent();
		Event e=new Event();
		if(p.getEventNoRef()!=null) {
			e=service.selectEvent(p.getEventNoRef());
		}
		
		m.addObject("product",p);
		m.addObject("option",o);
		m.addObject("thumb",th);
		m.addObject("eventList",event);
		m.addObject("event",e);
		m.setViewName("admin/product/updateProduct");
		return m;
	}
	//제품 수정
	@RequestMapping("/admin/updateProductEnd")
	public ModelAndView updateProduct(Product p,ProductOption o,ModelAndView m,
			@RequestParam(value="pdtNo") String pdtNo,
			@RequestParam(value="test",required = false) String options,
			@RequestParam(value="thumbImgs",required=false) MultipartFile[] thumbImgs,
			@RequestParam(value="detailImg",required=false) MultipartFile[] detailImg,
			HttpSession session
			) {

		//옵션 
		ObjectMapper mapper=new ObjectMapper();
		List<Map<Object, Object>> optionMap=null;
		try {
			optionMap = mapper.readValue(options, ArrayList.class);
		} catch (JsonMappingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (JsonProcessingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		System.out.println("컨트롤러에서"+optionMap);
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
		
		int result=service.updateProduct(p,o,optionMap,files);
		String msg="";
		String icon = "";
		if(result>0) {
			msg="제품 수정이 완료되었습니다.";
			icon = "success";
		}else {
			msg="제품 수정에 실패하였습니다.";
			icon = "error";
		}
		m.addObject("msg", msg);
		m.addObject("loc","/admin/moveProduct");
		m.addObject("icon", icon);
		m.setViewName("common/msg");
		return m;
	}
	
	//by수경-제품 삭제
	@RequestMapping("admin/deleteProduct")
	public ModelAndView deleteProduct(String pdtNo,ModelAndView m) {
		int result=service.deleteOneProduct(pdtNo);
		String msg="";
		String icon = "";
		if(result>0) {
			msg="삭제가 완료되었습니다.";
			icon = "success";
		}else {
			msg="삭제 실패하였습니다.";
			icon = "error";
		}
		m.addObject("msg", msg);
		m.addObject("loc","/admin/moveProduct");
		m.addObject("icon", icon);
		m.setViewName("common/msg");
	
		return m;
	}
}

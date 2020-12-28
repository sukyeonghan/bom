package com.kh.bom.admin.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.bom.admin.model.service.AdminService;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.common.page.AdminProAjaxPageBarFactory;
import com.kh.bom.common.page.AdminProSearchAjaxPageBarFactory;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSON;

@Slf4j
@Controller
public class ProductAdminController {
	
	@Autowired
	private AdminService service;

	//by수경-제품 관리페이지 전환 , 
	@RequestMapping("/admin/moveProduct")
	public ModelAndView moveProductListPage(ModelAndView m,
			@RequestParam(value = "sort",defaultValue="전체") String sort,//위에 있는 필터
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="10") int numPerpage) {

		int count=service.countProduct(sort); //전체 상품의 갯수 
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort));
		m.addObject("cPage",cPage);
		m.addObject("pageBar",PageBarFactory.getPageBar(count, cPage, numPerpage, "moveProduct"));
		m.addObject("count",count);
		m.setViewName("admin/product/adminProductList");
		return m;
	}
	
	//by수경-제품 목록페이지에서 선택 삭제
	 @RequestMapping("/admin/deleteSelect") 
	 public ModelAndView deleteSelectProduct(HttpSession session,
			 @RequestParam List<String> pdtNo,ModelAndView m) {
		 
		 String path=session.getServletContext().getRealPath("/resources/upload/product");

		 int result=service.deleteSelectProduct(pdtNo,path); 
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
			@RequestParam(value = "sort",defaultValue="전체") String sort,
			@RequestParam(value="cPage", defaultValue="1") int cPage, 
			@RequestParam(value="numPerpage", defaultValue="10") int numPerpage) {
	
		int count=service.countProduct(sort);
		m.addObject("list",service.selectProductList(cPage,numPerpage,sort));
		m.addObject("pageBar",AdminProAjaxPageBarFactory.getAjaxPageBar(count, cPage, numPerpage, "productListAjax",sort));
		m.addObject("cPage",cPage);
		m.addObject("sort",sort);
		m.addObject("count",count);
		m.setViewName("admin/product/adminProductListAjax");
		return m;
	}
	//제품 목록에서 검색
	@RequestMapping("/admin/productSearchAjax")
	public ModelAndView productSearchAjax(ModelAndView m,
			@RequestParam(value = "searchType", defaultValue = "") String searchType,
			@RequestParam(value = "keyword", defaultValue = "") String keyword,
			@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "10") int numPerpage,
			@RequestParam(value = "sort", defaultValue = "전체") String sort) { //분류했을때 리스트가 
		
		Map<String, String> map = new HashMap();
		
		map.put("searchType", searchType);//검색분류
		map.put("keyword", keyword); //검색한 키워드(글자) 
		map.put("sort", sort);//필터분류

		int count=service.countProduct(map);
		m.addObject("list", service.selectSearchList(cPage, numPerpage, map));
		m.addObject("pageBar", AdminProSearchAjaxPageBarFactory.getAjaxPageBar(count, cPage, numPerpage,
				"productSearchAjax", searchType, keyword, sort));
		m.addObject("cPage", cPage);
		m.addObject("count",count);
		m.addObject("sort", sort);
		m.addObject("searchType", searchType);
		m.addObject("keyword", keyword);
		m.setViewName("admin/product/adminProductListAjax");
		
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
			@RequestParam(value="detailImg",required=false) MultipartFile detailImg,
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
		
		//for(MultipartFile ff:detailImg) {
			String originalName=detailImg.getOriginalFilename();
			//확장자 분리
			String ext=originalName.substring(originalName.lastIndexOf(".")+1);
			//리네임양식정하기
			SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
			//int rndValue=(int)(Math.random()*1000);
			String reName="det"+sdf.format(System.currentTimeMillis())+"_"+originalName;
			try {
				detailImg.transferTo(new File(path+"/"+reName));
				p.setPdtDetailImage(reName);
			}catch(IOException e) {
				e.printStackTrace();
			}
			
		//}
		
		//옵션 등록
		ObjectMapper mapper=new ObjectMapper();
		List<Map<Object, Object>> optionMap=null;
		try {
			if(options!=null) {
				optionMap = mapper.readValue(options, ArrayList.class);
			}
		} catch (JsonMappingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (JsonProcessingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
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
	//제품명 중복검사
	@ResponseBody
	@RequestMapping("/admin/checkPdtName")
	public int checkProductName(@RequestParam("pdtName") String pdtName) {
		return service.selectPdtName(pdtName);
		
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
	//제품명 중복검사(수정페이지)
	@ResponseBody
	@RequestMapping("/admin/updateCheckPdtName")
	public int updateCheckPdtName(
			@RequestParam(value="pdtName") String pdtName,
			@RequestParam(value="pdtNo") String pdtNo) {
		return service.selectPdtName(pdtName,pdtNo);
		
	}
	
	//옵션 삭제
	@RequestMapping("/admin/deleteOption")
	public Model deleteOption(Model m,
			@RequestParam("pdtNo") String pdtNo) {
		int result= service.deleteOption(pdtNo);
		m.addAttribute("result",result);
		return m;
	}
	//옵션 상태 변경
	@ResponseBody
	@RequestMapping("/admin/optionStatus")
	public boolean changeStatus(
			@RequestParam("status") String status,
			@RequestParam("optNo") String optNo){
		
		int result=service.updateOptStatus(status,optNo);
		return result > 0?true:false;
	}
	
	//제품 수정
	@RequestMapping("/admin/updateProductEnd")
	public ModelAndView updateProduct(Product p,ProductOption o,ModelAndView m,
			@RequestParam(value="pdtNo") String pdtNo,
			@RequestParam(value="test",required = false) String options,
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
		//옵션 
		ObjectMapper mapper=new ObjectMapper();
		List<Map<Object, Object>> optionMap=null;
		try {
			if(options!=null) {
				optionMap = mapper.readValue(options, ArrayList.class);
			}
		} catch (JsonMappingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (JsonProcessingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
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
	public ModelAndView deleteProduct(HttpSession session,
			@RequestParam("pdtNo") String pdtNo,ModelAndView m) {

		String msg="";
		String icon = "";
		String path=session.getServletContext().getRealPath("/resources/upload/product");
		System.out.println(path);
		int result=service.deleteOneProduct(pdtNo,path);
		
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

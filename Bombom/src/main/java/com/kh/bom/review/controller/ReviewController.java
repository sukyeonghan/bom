 package com.kh.bom.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.review.model.service.ReviewService;
import com.kh.bom.review.model.vo.Review;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	
	//구매평 등록
	@RequestMapping("/review/insertReview")
	public ModelAndView insertReview(String pdtNo, Review r, ModelAndView mv,
			@RequestParam(value="upload1", required=false) MultipartFile[] upFile,
			HttpSession session) throws Exception {
		
		//upload 파일경로
		String path = session.getServletContext().getRealPath("/resources/upload/review");
		File dir = new File(path);
		//폴더 없을 경우 폴더생성
		if(!dir.exists()) dir.mkdirs();
		
		for(MultipartFile f : upFile) {
			if(!f.isEmpty()) {
				//본래파일명
				String originalName = f.getOriginalFilename();
				//확장자 버리기
				String ext = originalName.substring(originalName.lastIndexOf(".")+1);
				//리네임
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
				
				int rndValue = (int)(Math.random()*1000);
				String reName = "rev"+sdf.format(System.currentTimeMillis())+"_"+rndValue+"."+ext;
				
				//파일 입출력
				try {
					f.transferTo(new File(path+"/"+reName));
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				//리네임한 파일이름 review에 넣기
				r.setRevImage(reName);
			}
			
		}
		
		//로그인 세션에서 현재 사용자 id값 가져오기
		Member m = (Member)session.getAttribute("loginMember");
		//로그인 한 사람이 상품을 구매한 경우에만 상품평 작성 가능
		Map map = new HashMap();
		map.put("pdtNo",pdtNo);
		map.put("memNo",m.getMemNo());
		Order order = service.selectOneOrder(map); 
		String msg = "";
		String loc = "/product/productOne?pdtNo="+pdtNo;
		String icon = "";
		System.out.println("주문확인"+order);
		
		
		//상품을 구매한 경우에만 구매평 작성 가능
		if(order!=null) {
			int result2 = service.insertReview(r);
			
			if(result2>0) {
				msg = "상품평이 등록되었습니다. 적립금을 확인해주세요";
				icon = "success";
			}else {
				msg = "상품평을 다시 등록해주세요";
				icon = "warning";
			}
		//상품 구매하지 않은 경우 경고창	
		}else {
			msg = "상품평은 구매한 경우에만 작성하실 수 있습니다";
			icon = "warning";
		}
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		
		return mv;
	}

	
	//구매평삭제
	@RequestMapping("/review/deleteReview")
	public ModelAndView deleteReview(String pdtNo, String revNo, ModelAndView mv) {
		
		int result = service.deleteRevivew(revNo);
		String msg = "";
		String loc = "/product/productOne?pdtNo="+pdtNo;
		String icon = "";
		
		if(result>0) {
			msg = "구매평이 삭제되었습니다";
			icon = "success";
		}else {
			msg = "구매평을 다시 삭제해주세요";
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");		
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
}

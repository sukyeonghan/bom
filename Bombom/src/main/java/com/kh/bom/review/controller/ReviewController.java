package com.kh.bom.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.kh.bom.review.model.service.ReviewService;
import com.kh.bom.review.model.vo.Review;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	
	//구매평 등록
	@RequestMapping("/review/insertReview")
	public ModelAndView insertReview(Review r, ModelAndView mv,
			@RequestParam(value="upload", required=false) MultipartFile[] upFile,
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
		
		
		int result = service.insertReview(r);
		String msg = "";
		String loc = "/product/productOne";
		String icon = "";
		
		if(result>0) {
			msg = "상품평이 등록되었습니다. 적립금을 확인해주세요";
			icon = "success";
		}else {
			msg = "상품평을 다시 등록해주세요";
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
	public ModelAndView deleteReview(String revNo, ModelAndView mv) {
		
		int result = service.deleteRevivew(revNo);
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			msg = "구매평이 삭제되었습니다";
			loc = "/product/productOne";
			icon = "success";
		}else {
			msg = "구매평을 다시 삭제해주세요";
			loc = "/product/productOne";
			icon = "warning";
		}

		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon",icon);
		mv.setViewName("common/msg");		
		return mv;
	}
	
	
	
	
	
	
	
	
	
	
	
}

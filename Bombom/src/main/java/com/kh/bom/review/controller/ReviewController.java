 package com.kh.bom.review.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.review.model.service.ReviewService;
import com.kh.bom.review.model.vo.Review;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;
	
	//구매평 등록 전 상품구입 확인
	@RequestMapping("/review/selectOrder")
	@ResponseBody //Ajax로 json이나 text로 받을 경우 사용한다
	public List<Order> selectOrder(String pdtNo, String memNo, HttpSession session) throws JSONException, JsonProcessingException {
	
		Map map = new HashMap();
		map.put("pdtNo", pdtNo);
		map.put("memNo", memNo);
		
		Member m = (Member)session.getAttribute("loginMember");
		List<Order> orderList = service.selectOrder(map);
		//JSONObject obj = new JSONObject();
		//ObjectMapper mapper=new ObjectMapper();
		//System.out.println("확인 : "+mapper.writeValueAsString(orderList));
		return orderList;
		
//		JSONArray jArray = new JSONArray();
//		try {
//			for(int i=0; i<orderList.size(); i++) {
//				JSONObject sobj = new JSONObject();
//				
//				sobj.put("orderNo", orderList.get(i).getOrderNo());
//				sobj.put("pdtNo", orderList.get(i).getPdtNo());
//				sobj.put("pdtOptionNo", orderList.get(i).getPdtOptionNo());
//				sobj.put("qty", orderList.get(i).getInorderQty());
//				sobj.put("orderDate", orderList.get(i).getOrdDate());
//				sobj.put("revYn", orderList.get(i).getRevYn());
//				jArray.add(sobj);
//			}
//			//obj.put("list",jArray);
//			System.out.println("jArray확인 : "+jArray.toString());
//		} catch (JSONException e) {
//			e.printStackTrace();
//		}
//		
//		//return order!=null?order.getOrderNo():"";
//		return jArray;
	}
	
	
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
		System.out.println("구매평입력 : "+r);
		int result = service.insertReview(r);
		
		String msg = "";
		String loc = "/product/productOne?pdtNo="+pdtNo;
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
	
	
	//구매평수정
	@RequestMapping("/review/updateReview")
	public ModelAndView updateReview(String pdtNo, Review r, ModelAndView mv,
			@RequestParam(value="upload2", required=false) MultipartFile[] upFile,
			HttpSession session) throws Exception {
		
		//upload 파일경로
		String path = session.getServletContext().getRealPath("/resources/upload/review");
		File dir = new File(path);
		// 폴더 없을 경우 폴더생성
		if (!dir.exists())
			dir.mkdirs();

		for (MultipartFile f : upFile) {
			if(!f.isEmpty()) {
				// 본래파일명
				String originalName = f.getOriginalFilename();
				// 확장자 버리기
				String ext = originalName.substring(originalName.lastIndexOf(".") + 1);
				// 리네임
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");

				int rndValue = (int) (Math.random() * 1000);
				String reName = "rev" + sdf.format(System.currentTimeMillis()) + "_" + rndValue + "." + ext;

				// 파일 입출력
				try {
					f.transferTo(new File(path + "/" + reName));
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				// 리네임한 파일이름 review에 넣기
				r.setRevImage(reName);
			}	
		}
		
		System.out.println("구매평수정 : "+r);
		int result = service.updateReview(r);
		
		String msg = "";
		String loc = "/product/productOne?pdtNo="+pdtNo;
		String icon = "";
		
		if(result>0) {
			msg = "상품평이 수정되었습니다. 적립금을 확인해주세요";
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

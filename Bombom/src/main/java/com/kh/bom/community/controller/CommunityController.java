package com.kh.bom.community.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.community.model.service.CommunityService;
import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.vo.Member;

import net.sf.json.JSON;
import net.sf.json.JSONObject;

@Controller
public class CommunityController {

	@Autowired
	private CommunityService service;

	
	//communityList 화면 전환
	@RequestMapping("/community/communityList")
	public String selectCommunityList() {
		
		
		return "/community/communityList";
	}
	
	// communityList, 로그인 후 접근 가능
	@RequestMapping(value="/community/communityListAjax", produces="text/plain; charset=UTF-8")
	@ResponseBody //ajax 반환용
	public ModelAndView selectCommunityList(String order, ModelAndView mv,
			@RequestParam(value = "cPage", defaultValue = "1") int cPage,
			@RequestParam(value = "numPerpage", defaultValue = "6") int numPerpage,
	        HttpSession session)
	       {
		System.out.println("순서 :"+order);
		
		Map m = new HashMap();
		m.put("order",order); //string 오류를 고쳐준 것. 
		
	     Member loginMember = (Member)session.getAttribute("loginMember");
	     System.out.println(loginMember.getMemWarnCount());
		
		mv.addObject("list", service.selectCommunityList(cPage, numPerpage, m));
		int totalData = service.selectCount();

		mv.addObject("pageBar", PageBarFactory.getPageBar(totalData, cPage, numPerpage, "communityList"));
		mv.addObject("totalData", totalData);

		mv.setViewName("/community/communityListAjax");

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
	public ModelAndView insertCommunity(Community community, ModelAndView mv, MultipartFile upFile,
			HttpSession session) {

		System.out.println(community);
		System.out.println(upFile);

		String on = upFile.getOriginalFilename(); // 원본 파일
		String ext = on.substring(on.lastIndexOf(".") + 1);

		// 리네임규칙
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rndValue = (int) (Math.random() * 10000);
		String reName = sdf.format(System.currentTimeMillis()) + "_" + rndValue + "." + ext;

		// 클라이언트가 바이너리파일로 보낸 데이터를 MultipartFile 객체로 대입됨.
		// getName(), getOriginalFilename(), getSize(), transferTo()

		// upload실제 경로를 가져와야함.
		String path = session.getServletContext().getRealPath("/resources/upload/community");

		File dir = new File(path);
		if (!dir.exists())
			dir.mkdirs();// 폴더를 생성

		if (upFile != null) {
			try {
				upFile.transferTo(new File(path + File.separator + reName)); // 슬러시가 안될때
			} catch (IOException e) {
				e.printStackTrace();
			}
			community.setCmThumbnail(reName);
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
	public ModelAndView commmunityView(String cmNo, ModelAndView mv, @RequestParam Map<String, Object> paramMap) {

		service.communityView(cmNo); //조횟수
		
		mv.addObject("community", service.selectCommunityOne(cmNo));
		mv.addObject("replyList", service.getReplyList(paramMap));
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
			loc = "/community/communityView";
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

	// 댓글 등록 Ajax호출

	@RequestMapping(value = "/board/reply/save", method = RequestMethod.POST)
	@ResponseBody
	public Object boardReplySave(@RequestParam Map<String, Object> objParams) {

		System.out.println("매개변수:" + objParams);
		// 리턴값
		Map<String, Object> retVal = new HashMap<String, Object>();

		// 정보입력
		int result = service.regReply(objParams);

		System.out.println("결과값 " + result);

		if (result > 0) {
			String number = service.selectSeqReply();
			BoardReply rp = service.selectBoardReplyOne(number);

			retVal.put("code", "OK");
			retVal.put("board_id", rp.getBoard_id());
			retVal.put("reply_id", rp.getReply_id());
			retVal.put("parent_id", rp.getParent_id());
			retVal.put("reply_content", rp.getReply_content());
			retVal.put("depth", rp.getDepth());
			retVal.put("reply_writer", rp.getReply_writer());
			retVal.put("mem_nick", rp.getMem_nick());
			retVal.put("mem_pro", rp.getMem_pro());
			retVal.put("register_datetime", rp.getRegister_datetime());
			retVal.put("message", "등록에 성공 하였습니다.");
		} else {
			retVal.put("code", "FAIL");
			retVal.put("message", "등록에 실패 하였습니다.");
		}

		return retVal;

	}

	// 댓글 삭제
	@RequestMapping("/community/deleteReply")
	public ModelAndView deleteReply(String reply_id, ModelAndView mv) {
		int result = service.deleteReply(reply_id);

		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "댓글 삭제 성공";
			loc = "/community/communityView?";
		} else {
			msg = " 삭제 실패";
			loc = "/community/communityList";
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");

		return mv;
	}

	// 댓글 신고
	@RequestMapping("/community/reportReply")
	public ModelAndView reportReply(BoardReply reply, ModelAndView mv) {

		int result = service.reportReply(reply);

		return mv;

	}

	//좋아요
	@RequestMapping("/community/insertLike")
	@ResponseBody
	public int insertLike(HttpSession session, String cmNo, int likeCount, int value) {

		Member m = (Member) session.getAttribute("loginMember");
		//좋아요 수 및 좋아요한 글번호 업데이트
		int result = service.insertLike(m, cmNo, likeCount, value);
		//좋아요 수만 보내기
		return service.selectLikeCount(cmNo);
	}

	//좋아요한 글인지 확인
	@RequestMapping("/community/checkLike")
	@ResponseBody 
	public String[] checkLike(HttpSession session) { 
		 
		 Member m=(Member)session.getAttribute("loginMember");
		 Member newM=service.selectLikeNo(m.getMemNo());
		 return newM.getMemCmLike();
	}
	 
}
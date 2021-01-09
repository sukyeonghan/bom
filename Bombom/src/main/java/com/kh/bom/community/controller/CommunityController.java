package com.kh.bom.community.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bom.common.page.ComAjaxPageBarFactory;
import com.kh.bom.common.page.PageBarFactory;
import com.kh.bom.community.model.service.CommunityService;
import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.service.MemberService;
import com.kh.bom.member.model.vo.Alarm;
import com.kh.bom.member.model.vo.Member;

import net.sf.json.JSON;
import net.sf.json.JSONObject;


@Controller
public class CommunityController {

	@Autowired
	private CommunityService service;
	@Autowired
	private MemberService mService;//웹소켓에 필요
	
	//communityList 화면 전환
	@RequestMapping("/community/communityList")
	public String selectCommunityList() {
		
		
		return "/community/communityList";
	}
	
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

		mv.addObject("pageBar", ComAjaxPageBarFactory.getAjaxPageBar(totalData, cPage, numPerpage, "communityListAjax", order));
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
	
	//게시글 상세보기 화면 전환
	@RequestMapping("/community/communityView.do")
	public ModelAndView communityView(Community community, String cmNo,ModelAndView mv) {
		
		service.communityView(cmNo); //조횟수
		
		mv.addObject("community", service.selectCommunityOne(cmNo));
		
		mv.setViewName("community/communityView");

		return mv;
		
	}
	
	//게시글 상세보기 댓글출력
	@RequestMapping("/community/communityReplyList")
	@ResponseBody
    public ModelAndView communityReplyList(String cmNo,String cmWriter,String cmTitle,ModelAndView mv) {
		System.out.println("야야야"+cmNo);
        mv.addObject("replyList",service.getReplyList(cmNo));
        System.out.println("djdjdjdj"+service.getReplyList(cmNo));
        //웹소켓 알림용
        mv.addObject("cmNo",cmNo);
        mv.addObject("cmWriter",cmWriter);
        mv.addObject("cmTitle",cmTitle);
		mv.setViewName("/community/communityReplyAjax");
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
	public ModelAndView updateCommunity(Community community, ModelAndView mv,MultipartFile upFile,
			HttpSession session) {
		
		System.out.println("파일"+upFile);
		
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

	@RequestMapping(value = "/community/insertReply", produces="text/plain; charset=UTF-8")
	@ResponseBody
	public ModelAndView boardReplySave(String cmNo, String memNo, String replyContent,ModelAndView mv,Alarm a) {

		System.out.println("댓글" + cmNo + memNo + replyContent);
		
		BoardReply br = new BoardReply();
		br.setBoard_id(cmNo);
		br.setMem_no(memNo);
		br.setReply_content(replyContent);
		
		int result = service.insertReply(br);
		
		String msg = "";
		String loc = "";
		String icon = "";
		
		if(result>0) {
			
	    List<BoardReply> bList = service.getReplyList(cmNo);
	    result=mService.insertAlarm(a);
	    mv.addObject("replyList",bList);
	    mv.setViewName("/community/communityReplyAjax");
			
		}else {
			
			msg = "등록실패";
			loc = "/community/communityView.do?cmNo=" + cmNo;
			icon = "warning";
			
			
			mv.addObject("msg","등록에 실패했습니다");
			mv.addObject("loc", loc);
			mv.addObject("icon", icon);
			mv.setViewName("common/msg");
			
		}
		
		return mv;
	}
	
	//대댓글 등록하기 
	
	@RequestMapping(value="/community/insertReReply")
	@ResponseBody
	public int insertReReply(ModelAndView mv,String board_id, String mem_no,String parent_id, String reply_content,Alarm a){
		
		System.out.println("대댓글" + board_id + mem_no + parent_id + reply_content);
		
		BoardReply br = new BoardReply();
		br.setBoard_id(board_id);
		br.setMem_no(mem_no);
		br.setParent_id(parent_id);
		br.setReply_content(reply_content);

		int result = service.insertReReply(br);
		System.out.println("대댓글"+result);
		//알림보내기
		if(result>0) {
			result=mService.insertAlarm(a);
			System.out.println("알림"+result);
		}
		return result;
		
	}
	
	

	// 댓글 삭제
	@RequestMapping("/community/deleteReply")
	public ModelAndView deleteReply(String cmNo,String reply_id, ModelAndView mv) {
		
		BoardReply br = new BoardReply();
		
		br.setBoard_id(cmNo);
		br.setReply_id(reply_id);
		
		int result = service.deleteReply(br);

		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) {
			msg = "댓글 삭제 성공";
			loc = "/community/communityView.do?cmNo="+cmNo;
		} else {
			msg = " 삭제 실패";
			loc = "/community/communityView.do?cmNo="+cmNo;
			icon = "warning";
		}
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");

		return mv;
	}
	
	// 댓글 삭제
		@RequestMapping("/community/deleteReply2")
		public ModelAndView deleteReply2(String cmNo,String reply_id, ModelAndView mv) {
			
			BoardReply br = new BoardReply();
			
			br.setBoard_id(cmNo);
			br.setReply_id(reply_id);
			
			int result = service.deleteReply2(br);

			String msg = "";
			String loc = "";
			String icon = "";
			if (result > 0) {
				msg = "댓글 삭제 성공";
				loc = "/community/communityView.do?cmNo="+cmNo;
			} else {
				msg = " 삭제 실패";
				loc = "/community/communityView.do?cmNo="+cmNo;
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
		System.out.println("why????"+reply.getBoard_id());
		
		String msg = "";
		String loc = "";
		String icon = "";
		if (result > 0) msg = "신고 성공";
		else msg = "신고 실패";
			
		loc = "/community/communityView.do?cmNo=" + reply.getBoard_id();
		icon = "warning";
		
		mv.addObject("msg", msg);
		mv.addObject("loc", loc);
		mv.addObject("icon", icon);
		mv.setViewName("common/msg");
		

		return mv;
	}

	//좋아요
	@RequestMapping("/community/insertLike")
	@ResponseBody
	public JSON insertLike(HttpSession session, String cmNo, int likeCount, int value,Alarm a) {

		Member m = (Member) session.getAttribute("loginMember");
		//좋아요 수 및 좋아요한 글번호 업데이트
		int result = service.insertLike(m, cmNo, likeCount, value,a);
		// json객체로 보내기
		JSONObject obj = new JSONObject();
	
		if(result>0) {
			obj.put("likeCount", service.selectLikeCount(cmNo));// 바뀐 좋아요 수
			Member newM=service.selectLikeNo(m.getMemNo());// 바뀐 좋아요 글 번호
			if(newM!=null && newM.getMemCmLike()!=null) {
				obj.put("likeNo",newM.getMemCmLike());
			}else {
				obj.put("likeNo","[]");
			}
		}

		return obj;
	}

	//좋아요한 글인지 확인
	@RequestMapping("/community/checkLike")
	@ResponseBody 
	public String[] checkLike(HttpSession session) { 
		 
		 Member m=(Member)session.getAttribute("loginMember");
		 Member newM=service.selectLikeNo(m.getMemNo());
		 if(newM!=null && newM.getMemCmLike()!=null) return newM.getMemCmLike();
		 else return null;
		 
	}
	 
}
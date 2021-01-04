package com.kh.bom.community.model.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.community.model.dao.CommunityDao;
import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.dao.MemberDao;
import com.kh.bom.member.model.vo.Alarm;
import com.kh.bom.member.model.vo.Member;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao dao;
	@Autowired
	private MemberDao mDao;
	@Autowired
	private SqlSession session;

	@Override
	public int insertCommunity(Community community) {
		// TODO Auto-generated method stub
		return dao.insertCommunity(session, community);
	}

	@Override
	public List<Community> selectCommunityList(int cPage, int numPerpage, Map m) {
		// TODO Auto-generated method stub
		return dao.selectCommunityList(session, cPage, numPerpage, m);
	}

	@Override
	public int selectCount() {
		// TODO Auto-generated method stub
		return dao.selectCount(session);
	}

	@Override
	public Community selectCommunityOne(String cmNo) {
		// TODO Auto-generated method stub
		return dao.selectCommunityOne(session, cmNo);
	}

	@Override
	public int deleteCommunity(String cmNo) {
		// TODO Auto-generated method stub
		return dao.deleteCommunity(session, cmNo);
	}

	//
	@Override
	public int updateCommunity(Community community) {
		// TODO Auto-generated method stub
		return dao.updateCommunity(session, community);
	}

	@Override
	public int communityView(String cmNo) {
		// TODO Auto-generated method stub
		return dao.communityView(session, cmNo);
	}

	@Override
	public int insertReply(BoardReply br) {
		return dao.insertReply(session,br);
		
		
	}

	
	@Override
	public int deleteReply(BoardReply br) {
		// TODO Auto-generated method stub
		return dao.deleteReply(session, br);
	}

	@Override
	public String selectSeqReply() {
		// TODO Auto-generated method stub
		return dao.selectSeqReply(session);
	}

	@Override
	public BoardReply selectBoardReplyOne(String number) {
		// TODO Auto-generated method stub
		return dao.selectBoardReplyOne(session,number);
	}
	
	public int reportReply(BoardReply reply) {
		// TODO Auto-generated method stub
		return dao.reportReply(session,reply);
	}
	

	@Override
	public List<BoardReply> getReplyList(String cmNo) {
		List<BoardReply> bList = dao.getReplyList(session, cmNo);
		if(!bList.isEmpty()) {
			for(BoardReply b : bList) {
				System.out.println(b.getReply_id());
				BoardReply br = dao.getChildReplyList(session, b.getReply_id());
				b.setChildReply(br);
			}
		}
		return bList;
	}
	
	@Override
	public int insertReReply(BoardReply br) {
		// TODO Auto-generated method stub
		return dao.insertReReply(session,br);
	}

	@Override
	@Transactional
	public int insertLike(Member m,String cmNo,int likeCount,int value,Alarm a) {
		// TODO Auto-generated method stub
		int result=0;
		String memNo=m.getMemNo();//회원 번호
		String[] memCmLike=null;
		Member newM =dao.selectLikeNo(session,memNo);
		if(newM!=null && newM.getMemCmLike()!=null) {
			memCmLike=newM.getMemCmLike();//좋아요 누른 글번호들
		}

		Map<String,Object> map=new HashMap();
		map.put("cmNo",cmNo);
		map.put("value",value);
		map.put("memNo", memNo);
		
		//좋아요한 글 업데이트
		//좋아요를 눌렀을 때
		if(value==1) {
			result=dao.updateLikeNo(session,map);
			//알림 DB에 저장
			if(result>0) {
				result=mDao.insertAlarm(session, a);
			}
		}else if(memCmLike!=null && value==0){
			//좋아요를 취소했을 때
			for(String l : memCmLike) {
				if(l.equals(cmNo)) {
					//배열을 리스트로 바꿔서 삭제 후 다시 배열로 만듦
					List<String> list = new ArrayList<>(Arrays.asList(memCmLike));
					list.remove(cmNo);
					memCmLike = list.toArray(new String[list.size()]);
					map.put("memCmLike", memCmLike);
					result=dao.deleteLikeNo(session,map);
				}
			}
		}
		if(result>0) {
			//커뮤니티글 좋아요 수 변경
			result=dao.updateCount(session,map);
		}

		return result;
	}
	
	//좋아요 수만 가져오기
	@Override
	public int selectLikeCount(String cmNo) {
		// TODO Auto-generated method stub
		return dao.selectLikeCount(session,cmNo);
	}
	//좋아요누른 글 번호만 가져오기
	@Override
	public Member selectLikeNo(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectLikeNo(session,memNo);
	}
}

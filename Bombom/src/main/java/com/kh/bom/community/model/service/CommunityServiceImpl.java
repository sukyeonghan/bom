package com.kh.bom.community.model.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.community.model.dao.CommunityDao;
import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;

@Service
public class CommunityServiceImpl implements CommunityService {

	@Autowired
	private CommunityDao dao;
	@Autowired
	private SqlSession session;

	@Override
	public int insertCommunity(Community community) {
		// TODO Auto-generated method stub
		return dao.insertCommunity(session, community);
	}

	@Override
	public List<Community> selectCommunityList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectCommunityList(session, cPage, numPerpage);
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
	public int regReply(Map<String, Object> paramMap) {
		return dao.regReply(session,paramMap);
	}

	@Override
	public List<BoardReply> getReplyList(Map<String, Object> paramMap) {

		List<BoardReply> boardReplyList = dao.getReplyList(session,paramMap);

		// msyql 에서 계층적 쿼리가 어려우니 여기서 그냥 해결하자

		// 부모
		List<BoardReply> boardReplyListParent = new ArrayList<BoardReply>();
		// 자식
		List<BoardReply> boardReplyListChild = new ArrayList<BoardReply>();
		// 통합
		List<BoardReply> newBoardReplyList = new ArrayList<BoardReply>();

		// 1.부모와 자식 분리
		for (BoardReply boardReply : boardReplyList) {
			if (boardReply.getDepth().equals("0")) {
				boardReplyListParent.add(boardReply);
			} else {
				boardReplyListChild.add(boardReply);
			}
		}

		// 2.부모를 돌린다.
		for (BoardReply boardReplyParent : boardReplyListParent) {
			// 2-1. 부모는 무조건 넣는다.
			newBoardReplyList.add(boardReplyParent);
			// 3.자식을 돌린다.
			for (BoardReply boardReplyChild : boardReplyListChild) {
				// 3-1. 부모의 자식인 것들만 넣는다.
				if (boardReplyParent.getReply_id().equals(boardReplyChild.getParent_id())) {
					newBoardReplyList.add(boardReplyChild);
				}

			}

		}

		// 정리한 list return
		return newBoardReplyList;
	}

	
	@Override
	public int deleteReply(String reply_id) {
		// TODO Auto-generated method stub
		return dao.deleteReply(session, reply_id);
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

	@Override
	public int reportReply(BoardReply reply) {
		// TODO Auto-generated method stub
		return dao.reportReply(session,reply);
	}

	

}

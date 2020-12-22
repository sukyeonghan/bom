package com.kh.bom.admin.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.admin.model.dao.CommunityMngDao;
import com.kh.bom.community.model.vo.BoardReply;

@Service
public class CommunityMngServiceImpl implements CommunityMngService {

	@Autowired
	private CommunityMngDao dao;
	@Autowired
	private SqlSession session;

	@Override
	public List<BoardReply> selectReplyList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectReplyList(session, cPage, numPerpage);
	}

	@Override
	public int selectPage() {
		// TODO Auto-generated method stub
		return dao.selectPage(session);
	}
	
	//댓글 검색 목록
	@Override
	public List<BoardReply> selectSearchList(int cPage, int numPerpage, Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.selectSearchList(session,cPage,numPerpage,map);
	}
	
	//댓글 신고
	@Override
	public int reportReply(BoardReply br) {
		// TODO Auto-generated method stub
		return dao.reportReply(session,br);
	}

	//신고 접수처리
	@Override
	public int warnMemberYn(BoardReply br) {
		// TODO Auto-generated method stub
		return dao.warnMemberYn(session,br);
	}
	
	

	

}

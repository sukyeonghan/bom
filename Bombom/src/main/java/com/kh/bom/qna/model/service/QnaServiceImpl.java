package com.kh.bom.qna.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.qna.model.dao.QnaDao;
import com.kh.bom.qna.model.vo.Qna;


@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private SqlSession session;
	@Autowired
	private QnaDao dao;
	
	
	@Override
	public int insertQna(Qna qna) {
		// TODO Auto-generated method stub
		return dao.insertQna(qna, session);
	}


	@Override
	public Object selectQnaList(String memNo,int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectQnaList(session,memNo,cPage,numPerpage);
	}


	@Override
	public int selectCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectCount(session,memNo);
	}


	@Override
	public int deleteQna(Qna q) {
		// TODO Auto-generated method stub
		return dao.deleteQna(session,q);
	}
	
	
	
	
	
	
	
}

package com.kh.bom.qna.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.bom.qna.model.dao.QnaDao;



public class QnaServiceImpl implements QnaService {

	@Autowired
	private SqlSession session;
	@Autowired
	private QnaDao dao;
}

package com.kh.bom.point.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.member.model.dao.MemberDao;
import com.kh.bom.point.model.dao.PointDao;
import com.kh.bom.point.model.vo.Point;

@Service
public class PointServiceImpl implements PointService {
	
	@Autowired
	SqlSession session;
	
	@Autowired
	PointDao dao;
	@Autowired
	MemberDao memberDao;

	@Override
	public List<Point> selectPointList(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectPointList(session,memNo);
	}


	@Override
	@Transactional
	public int stampInsertPoint(Point p) {
		// TODO Auto-generated method stub
		int result = dao.stampInsertPoint(session, p);
		if(result>0) {
			result=memberDao.updateMemBuyCount(session,p.getMemNo());
		}
		return result;
	}
	
	
	
	
}

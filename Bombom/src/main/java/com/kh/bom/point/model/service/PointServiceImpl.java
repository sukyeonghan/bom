package com.kh.bom.point.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.point.model.dao.PointDao;
import com.kh.bom.point.model.vo.Point;

@Service
public class PointServiceImpl implements PointService {
	
	@Autowired
	SqlSession session;
	
	@Autowired
	PointDao dao;

	@Override
	public int stamp10(Map param) {
		// TODO Auto-generated method stub
		return dao.stamp10(session,param);
	}

	@Override
	public List<Point> selectPointList(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectPointList(session,memNo);
	}
	
	
}

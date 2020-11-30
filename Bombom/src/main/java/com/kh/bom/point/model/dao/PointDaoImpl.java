package com.kh.bom.point.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.point.model.vo.Point;

@Repository
public class PointDaoImpl implements PointDao{


	@Override
	public List<Point> selectPointList(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectList("point.selectPointList",memNo);
	}

	@Override
	public int stampInsertPoint(SqlSession session, Point p) {
		// TODO Auto-generated method stub
		return session.insert("point.insertPoint",p);
		
	}

	
}

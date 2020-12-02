package com.kh.bom.point.model.dao;

import java.util.List;


import org.apache.ibatis.session.SqlSession;

import com.kh.bom.point.model.vo.Point;

public interface PointDao {


	List<Point> selectPointList(SqlSession session, String memNo, int cPage, int numPerpage);

	int insertStampPoint(SqlSession session, Point p);

	int selectCount(SqlSession session, String memNo);


}

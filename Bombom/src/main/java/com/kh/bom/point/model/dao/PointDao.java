package com.kh.bom.point.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.point.model.vo.Point;

public interface PointDao {

	int stamp10(SqlSession session, Map param);

	List<Point> selectPointList(SqlSession session, String memNo);

}

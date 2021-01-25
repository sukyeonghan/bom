package com.kh.bom.point.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.point.model.vo.Point;

public interface PointService {

	
	List<Point> selectPointList(Map<String, String> map, int cPage, int numPerpage);

	int insertStampPoint(Point p) throws Exception ;

	int selectCount(Map<String, String> map);

	int selectTotalPoint(String memNo);
	
	int updatePoint(Point p);


}

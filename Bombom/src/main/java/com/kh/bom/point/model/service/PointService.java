package com.kh.bom.point.model.service;

import java.util.List;


import com.kh.bom.point.model.vo.Point;

public interface PointService {

	
	List<Point> selectPointList(String memNo);

	int stampInsertPoint(Point p);

}

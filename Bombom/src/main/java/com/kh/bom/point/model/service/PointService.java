package com.kh.bom.point.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.point.model.vo.Point;

public interface PointService {

	int stamp10(Map param);

	List<Point> selectPointList(String memNo);

}

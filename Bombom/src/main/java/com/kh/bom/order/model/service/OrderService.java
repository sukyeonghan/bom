package com.kh.bom.order.model.service;

import java.util.List;

import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;

public interface OrderService {
	// 결제하기
	int insertOrder(Order order);

	String selectBasketOne(String memNo);

	List<Inbasket> selectInbasket(String basketNo);
	
	int insertInbasket(String pdtNo);
}

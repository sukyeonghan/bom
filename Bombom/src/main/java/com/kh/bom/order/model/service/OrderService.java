package com.kh.bom.order.model.service;

import com.kh.bom.order.model.vo.Order;

public interface OrderService {
	//결제하기
	int insertOrder(Order order);
}

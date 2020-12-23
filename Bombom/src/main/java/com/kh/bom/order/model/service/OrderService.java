package com.kh.bom.order.model.service;

import java.util.List;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.ProductOption;

public interface OrderService {
	// 결제하기
	int insertOrder(Order order);

	List<Basket> selectBasket(String memNo);

	int deleteBasketOne(Basket b);

	int deleteBasketOption(String optionNo);

	List<Order> selectOrderList(String memNo, int cPage, int numPerpage);

	int selectOrderCount(String memNo);

	int shipReadyCount(String memNo);
}

package com.kh.bom.order.model.service;

import java.util.List;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.vo.Point;
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

	int ordWaitCount(String memNo);

	int ordEndCount(String memNo);

	int shippingCount(String memNo);

	int shipEndCount(String memNo);

	int buyEndCount(String memNo);

	List<Order> selectOrderDetail(String orderNo);

	Order selectOrderOne(String orderNo);

	int cancelOrder(Order o, Point p);

	int buyConfirm(String orderNo, Point p);
	
	int insertBasket(String memNo);
	
	int insertInbasket(Inbasket i); 
}

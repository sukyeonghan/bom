package com.kh.bom.order.model.service;

import java.util.List;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.ProductOption;

public interface OrderService {
	// 결제하기
	int insertOrder(Order order);

	Basket selectBasketOne(String memNo);

	List<Inbasket> selectInbasket(String basketNo);
	
	int insertInbasket(String pdtNo);
	
	//상품 옵션값 가져오기
	ProductOption selectProductOption(String opNo);
}

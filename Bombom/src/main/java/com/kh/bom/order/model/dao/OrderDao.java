package com.kh.bom.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.ProductOption;

public interface OrderDao {
	int insertOrder(SqlSession session, Order order);

	List<Basket> selectBasket(SqlSession session, String memNo);

	int deleteBasketOne(SqlSession session, Basket b);

	int deleteBasketOption(SqlSession session, String optionNo);

}

package com.kh.bom.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.ProductOption;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Override
	public int insertOrder(SqlSession session, Order order) {
		return session.insert("order.insertOrder", order);
	}

	@Override
	public List<Basket> selectBasket(SqlSession session, String memNo) {
		return session.selectList("order.selectBasket", memNo);
	}

	@Override
	public int deleteBasketOne(SqlSession session, Basket b) {
		return session.delete("order.deleteBasketPdt",b);
	}
	@Override
	public int deleteBasketOption(SqlSession session, String optionNo) {
		return session.delete("order.deleteBasketOption",optionNo);
	}

}

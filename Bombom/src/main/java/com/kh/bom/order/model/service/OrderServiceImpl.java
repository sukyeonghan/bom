package com.kh.bom.order.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.order.model.dao.OrderDao;
import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.ProductOption;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao dao;
	@Autowired
	private SqlSession session;

	@Override
	public int insertOrder(Order order) {
		return dao.insertOrder(session, order);
	}

	@Override
	public Basket selectBasketOne(String memNo) {
		return dao.selectBasketOne(session, memNo);
	}

	@Override
	public List<Inbasket> selectInbasket(String basketNo) {
		return dao.selectInbasket(session, basketNo);
	}

	@Override
	public int insertInbasket(String pdtNo) {
		return dao.insertInbasket(session, pdtNo);
	}

	@Override
	public ProductOption selectProductOption(String opNo) {
		return dao.selectProductOption(session, opNo);
	}
}

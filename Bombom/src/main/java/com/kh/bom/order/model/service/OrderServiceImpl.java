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
	public List<Basket> selectBasket(String memNo) {
		return dao.selectBasket(session, memNo);
	}

	@Override
	public int deleteBasketOne(Basket b) {
		return dao.deleteBasketOne(session, b);
	}
	@Override
	public int deleteBasketOption(String optionNo) {
		return dao.deleteBasketOption(session, optionNo);
	}

	@Override
	public List<Order> selectOrderList(String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectOrderList(session,memNo,cPage,numPerpage);
	}
	
	@Override
	public int selectOrderCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderCount(session,memNo);
	}
	//배송준비 ct
	@Override
	public int shipReadyCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.shipReadyCount(session,memNo);
	}
	
	
	
	
	
}

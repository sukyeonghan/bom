package com.kh.bom.order.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.order.model.dao.OrderDao;
import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.vo.Point;

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

	@Override
	public int ordWaitCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.ordWaitCount(session,memNo);
	}

	@Override
	public int ordEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.ordEndCount(session,memNo);
	}

	@Override
	public int shippingCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.shippingCount(session,memNo);
	}

	@Override
	public int shipEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.shipEndCount(session,memNo);
	}

	@Override
	public int buyEndCount(String memNo) {
		// TODO Auto-generated method stub
		return dao.buyEndCount(session,memNo);
	}

	@Override
	public List<Order> selectOrderDetail(String orderNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderDetail(session,orderNo);
	}

	@Override
	public Order selectOrderOne(String orderNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderOne(session, orderNo);
	}
	//주문취소
	@Override
	@Transactional
	public int cancelOrder(Order o, Point p) {
		
		int result = dao.cancelOrder(session,o);
		if(result>0) {
			p.setOrderNo(o.getOrderNo());
			result=dao.cancelOrdPoint(session,p);
		}
		return result; 
	}
	//구매확정
	@Override
	@Transactional
	public int buyConfirm(String orderNo, Point p) {
		
		int result=dao.buyConfirm(session,orderNo);
		if(result>0) {
			p.setOrderNo(orderNo);
			result=dao.insertOrdPoint(session,p);
		}
		
		return result;
	}

	@Override
	public int insertBasket(String memNo) {
		// TODO Auto-generated method stub
		return dao.insertBasket(session, memNo);
	}

	@Override
	public int insertInbasket(Inbasket i) {
		// TODO Auto-generated method stub
		return dao.insertInbasket(session, i);
	}
	
	
	
	
	
}

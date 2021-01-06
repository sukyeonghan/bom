package com.kh.bom.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Inorder;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.vo.Point;

public interface OrderDao {
	int insertOrder(SqlSession session, Order order);

	int deleteInbasket(SqlSession session, String basketNo);

	int deleteBasket(SqlSession session, String basketNo);

	List<Basket> selectBasket(SqlSession session, String memNo);
	
	Basket selectBasketOne(SqlSession session, String memNo);

	int deleteBasketOne(SqlSession session, Basket b);

	int deleteBasketOption(SqlSession session, String optionNo);

	List<Order> selectOrderList(SqlSession session, String memNo, int cPage, int numPerpage);

	int selectOrderCount(SqlSession session, String memNo);

	int shipReadyCount(SqlSession session, String memNo);

	int ordWaitCount(SqlSession session, String memNo);

	int ordEndCount(SqlSession session, String memNo);

	int shippingCount(SqlSession session, String memNo);

	int shipEndCount(SqlSession session, String memNo);

	int buyEndCount(SqlSession session, String memNo);

	List<Order> selectOrderDetail(SqlSession session, String orderNo);

	Order selectOrderOne(SqlSession session, String orderNo);

	int cancelOrder(SqlSession session, Order o);

	int cancelOrdPoint(SqlSession session, Point p);

	int buyConfirm(SqlSession session, String orderNo);

	int insertOrdPoint(SqlSession session, Point p);

	int insertBasket(SqlSession session, String memNo);

	int insertInbasket(SqlSession session, Inbasket i);

	int cancelEndCount(SqlSession session, String memNo);

	int returnWaitCount(SqlSession session, String memNo);

	int returnEndCount(SqlSession session, String memNo);

	int returnRequest(SqlSession session, Order o);

	int returnOrdPoint(SqlSession session, Point p);
	
	Basket selectBasketNo(SqlSession session, String memNo);
	
	List<Inbasket> selectInbasket(SqlSession session, String basketNo);
	
	List<Inbasket> selectInbasketList(SqlSession session, String basketNo);
	
	int insertInorder(SqlSession session, Inorder i);

}

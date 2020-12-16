package com.kh.bom.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;

public interface OrderDao {
	int insertOrder(SqlSession session, Order order);

	String selectBasketOne(SqlSession session, String memNo);

	List<Inbasket> selectInbasket(SqlSession session, String basketNo);
	
	int insertInbasket(SqlSession session, String pdtNo);
}

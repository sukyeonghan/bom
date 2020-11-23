package com.kh.bom.order.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.order.model.vo.Order;

@Repository
public class OrderDaoImpl implements OrderDao {

	@Override
	public int insertOrder(SqlSession session,Order order) {
		return session.insert("order.insertOrder",order);
	}

}

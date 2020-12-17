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
	public int insertOrder(SqlSession session,Order order) {
		return session.insert("order.insertOrder",order);
	}

	@Override
	public Basket selectBasketOne(SqlSession session, String memNo) {
		return session.selectOne("order.selectBasketOne", memNo);
	}

	@Override
	public List<Inbasket> selectInbasket(SqlSession session, String basketNo) {
		return session.selectList("order.selectInbasket",basketNo);
	}

	@Override
	public int insertInbasket(SqlSession session, String pdtNo) {
		return session.insert("order.insertInbasket",pdtNo);
	}

	@Override
	public ProductOption selectProductOption(SqlSession session, String opNo) {
		return session.selectOne("order.selectProductOptionOne",opNo);
	}

}

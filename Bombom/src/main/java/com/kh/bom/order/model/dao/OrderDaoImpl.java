package com.kh.bom.order.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.order.model.vo.Basket;
import com.kh.bom.order.model.vo.Inbasket;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.vo.Point;
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
	//나의 주문내역
	@Override
	public List<Order> selectOrderList(SqlSession session, String memNo, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderList",memNo,new RowBounds((cPage-1)*numPerpage, numPerpage));
	}
	//주문내역  페이징 -카운트
	@Override
	public int selectOrderCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOrderCount", memNo);
	}
	//배송준비 카운트
	@Override
	public int shipReadyCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.shipReadyCount",memNo);
	}
	//주문대기
	@Override
	public int ordWaitCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.ordWaitCount",memNo);
	}
	//주문완료
	@Override
	public int ordEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.ordEndCount",memNo);
	}
	//배송중
	@Override
	public int shippingCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.shippingCount",memNo);
	}
	//배송완료
	@Override
	public int shipEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.shipEndCount",memNo);
	}
	//구매확정
	@Override
	public int buyEndCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.buyEndCount",memNo);
	}
	//상세주문내역 
	@Override
	public List<Order> selectOrderDetail(SqlSession session, String orderNo) {
		// TODO Auto-generated method stub
		return session.selectList("order.selectOrderDetail",orderNo);
	}
	//상세주문내역 내에서 주문정보
	@Override
	public Order selectOrderOne(SqlSession session, String orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("order.selectOrderOne",orderNo);
	}
	//주문취소
	@Override
	public int cancelOrder(SqlSession session, Order o) {
		// TODO Auto-generated method stub
		return session.delete("order.cancelOrder", o);
	}
	
	@Override
	public int cancelOrdPoint(SqlSession session, Point p) {
		// TODO Auto-generated method stub
		return session.update("order.cancelOrdPoint",p);
	}
	//구매확정
	@Override
	public int buyConfirm(SqlSession session, String orderNo) {
		// TODO Auto-generated method stub
		return session.update("order.buyConfirm",orderNo);
	}

	@Override
	public int insertOrdPoint(SqlSession session, Point p) {
		// TODO Auto-generated method stub
		return session.insert("order.insertOrdPoint",p);
	}


	
	
}

package com.kh.bom.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductThumb;


public interface AdminDao {
	List<Event> selectEvent(SqlSession session);
	int eventDelete(SqlSession session, String eventNo);
	int insertEvent(SqlSession session, Event e);
	Event selectEvent(SqlSession session, String eventNo);
	int updateEvent(SqlSession session, Event e);
	
	List<Product> selectProductList(SqlSession session);
	int deleteProduct(SqlSession session,String pdtNo);
	int insertProduct(SqlSession session,Product p);
	int insertThumb(SqlSession session,ProductThumb th);
	int insertOption(SqlSession session,Product p);

	List<Member> selectMemberList(SqlSession session, int cPage, int numPerpage);
	int selectMemberCount(SqlSession session);

}

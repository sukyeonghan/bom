package com.kh.bom.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.qna.model.vo.Qna;


public interface AdminDao {
	List<Event> selectEvent(SqlSession session);
	List<Event> selectEventSort(SqlSession session, String sort);
	int eventDelete(SqlSession session, String eventNo);
	int insertEvent(SqlSession session, Event e);
	Event selectEvent(SqlSession session, String eventNo);
	int updateEvent(SqlSession session, Event e);
	
	List<Product> selectProductList(SqlSession session);
	int deleteProduct(SqlSession session,String pdtNo);
	int insertProduct(SqlSession session,Product p);
	int insertThumb(SqlSession session,ProductThumb th);
	int insertOption(SqlSession session,ProductOption o);
	Product selectOneProduct(SqlSession session,String pdtNo);
	List<ProductOption> selectOption(SqlSession session,String pdtNo);
	List<ProductThumb> selectThumb(SqlSession session,String pdtNo);
	int updateProduct(SqlSession session,Product p);
	int updateOption(SqlSession session,ProductOption o);
	int updateThumb(SqlSession session,ProductThumb th);
	int deleteThumb(SqlSession session,String pdtNo);
	int deleteOption(SqlSession session,String pdtNo);

	List<Member> selectMemberList(SqlSession session, int cPage, int numPerpage);
	int selectMemberCount(SqlSession session);
	//관리자권한 변경
	int updateManagerYn(SqlSession session, Member m);
	List<Member> selectMemberSearch(SqlSession session,int cPage, int numPerpage, Map map);
	int selectMemberCount(SqlSession session, Map<String, String> map);
	List<Member> memberAutoComplete(SqlSession session, Map<String, String> map);
	
	List<Qna> selectQnaList(SqlSession session, int cPage, int numPerpage);
	int selectQnaCount(SqlSession session);
	int insertQnaAnswer(SqlSession session, Qna q);
	
}

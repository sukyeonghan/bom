package com.kh.bom.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.qna.model.vo.Qna;
import com.kh.bom.member.model.vo.Member;

@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public List<Event> selectEvent(SqlSession session) {
		return session.selectList("admin.selectEvent");
	}

	@Override
	public List<Event> selectEventSort(SqlSession session, String sort) {
		return session.selectList("admin.selectEventSort", sort);
	}

	@Override
	public int eventDelete(SqlSession session, String eventNo) {
		return session.delete("admin.eventDelete", eventNo);
	}

	@Override
	public int insertEvent(SqlSession session, Event e) {
		return session.insert("admin.insertEvent",e);
	}

	@Override
	public Event selectEvent(SqlSession session, String eventNo) {
		return session.selectOne("admin.selectEventOne", eventNo);
	}

	@Override
	public int updateEvent(SqlSession session, Event e) {
		return session.update("admin.updateEvent", e);
	}

	@Override
	public List<Member> selectMemberList(SqlSession session,int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectMemberList","",new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int selectMemberCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectMemberCount");
	}
	
	//제품 목록 
	@Override
	public List<Product> selectProductList(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectProductList");
	}
	//제품 삭제
	@Override
	public int deleteProduct(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.delete("admin.deleteProduct",pdtNo);
	}
	//제품등록
	@Override
	public int insertProduct(SqlSession session, Product p) {
		// TODO Auto-generated method stub
		return session.insert("admin.insertProduct",p);
	}
	//옵션 등록
	@Override
	public int insertOption(SqlSession session,ProductOption o) {
		return session.insert("admin.insertOption",o);
	}
	//제품 선택
	@Override
	public Product selectOneProduct(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectOneProduct",pdtNo);
	}
	//옵션 선택
	@Override
	public List<ProductOption> selectOption(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectOption",pdtNo);
	}
	//썸네일 선택
	@Override
	public List<ProductThumb> selectThumb(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectThumb",pdtNo);
	}
	
	//썸네일 등록
	@Override
	public int insertThumb(SqlSession session, ProductThumb th) {
		// TODO Auto-generated method stub
		return session.insert("admin.insertThumb",th);
	}
	//제품 수정
	@Override
	public int updateProduct(SqlSession session, Product p) {
		// TODO Auto-generated method stub
		return session.update("admin.updateProduct",p);
	}
	
	//옵션 수정
	@Override
	public int updateOption(SqlSession session, ProductOption o) {
		// TODO Auto-generated method stub
		return session.update("admin.updateOption",o);
	}
	//썸네일 수정
	@Override
	public int updateThumb(SqlSession session,ProductThumb th) {
		// TODO Auto-generated method stub
		return session.update("admin.updateThumb",th);
	}
	//썸네일 삭제
	@Override
	public int deleteThumb(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.delete("admin.deleteThumb",pdtNo);
	}
	//옵션 삭제
	@Override
	public int deleteOption(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.delete("admin.deleteOption",pdtNo);
	}
	//1:1목록 가져오기
	@Override
	public List<Qna> selectQnaList(SqlSession session, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectQnaList","",new RowBounds((cPage-1)*numPerpage,numPerpage));
	}
	//1:1 페이징처리 위한 count
	@Override
	public int selectQnaCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectQnaCount");
	}
	
	
	
	
	
	
}

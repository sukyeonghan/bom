package com.kh.bom.admin.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.admin.model.vo.MainBanner;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.qna.model.vo.Qna;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.vo.Order;

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
		return session.insert("admin.insertEvent", e);
	}

	@Override
	public Event selectEvent(SqlSession session, String eventNo) {
		return session.selectOne("admin.selectEventOne", eventNo);
	}

	@Override
	public int updateEvent(SqlSession session, Event e) {
		return session.update("admin.updateEvent", e);
	}

	// 회원관리시작
	// 관리지 권한 변경
	@Override
	public int updateManagerYn(SqlSession session, Member m) {
		// TODO Auto-generated method stub
		return session.update("admin.updateManagerYn", m);
	}

	// 회원리스트
	@Override
	public List<Member> selectMemberList(SqlSession session, int cPage, int numPerpage, Map map) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectMemberList", map, new RowBounds((cPage - 1) * numPerpage, numPerpage));
	}

	// 회원수
	@Override
	public int selectMemberCount(SqlSession session, Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectMemberCount", map);
	}

	// 회원검색자동완성
	@Override
	public List<Member> memberAutoComplete(SqlSession session, Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.selectList("admin.memberAutoComplete", map);
	}
	// 회원관리 끝!

	// 제품 목록
	@Override
	public List<Product> selectProductList(SqlSession session, int cPage, int numPerPage, String sort) {
		// TODO Auto-generated method stub
		Map<String, String> param = new HashMap();
		param.put("category", sort);
		return session.selectList("admin.selectProductList", param,
				new RowBounds((cPage - 1) * numPerPage, numPerPage));

	}
	//검색 목록
	@Override
	public List<Product> selectSearchList(SqlSession session, int cPage, int numPerpage, Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.selectList("admin.searchProductList",map,new RowBounds((cPage - 1) * numPerpage, numPerpage));
	}
	//제품 개수
	@Override
	public int countProduct(SqlSession session, String category) {
		// TODO Auto-generated method stub
		Map<String, String> param = new HashMap();
		param.put("sort", category);
		return session.selectOne("admin.countProduct", param);
	}
	//검색 개수
	@Override
	public int countProduct(SqlSession session, Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.countProduct",map);
	}

	// 제품 삭제
	@Override
	public int deleteProduct(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.delete("admin.deleteProduct", pdtNo);
	}

	// 제품등록
	@Override
	public int insertProduct(SqlSession session, Product p) {
		// TODO Auto-generated method stub
		return session.insert("admin.insertProduct", p);
	}

	// 옵션 등록
	@Override
	public int insertOption(SqlSession session, ProductOption o) {
		return session.insert("admin.insertOption", o);
	}

	// 제품 선택
	@Override
	public Product selectOneProduct(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectOneProduct", pdtNo);
	}

	// 옵션 선택
	@Override
	public List<ProductOption> selectOption(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectOption", pdtNo);
	}

	// 썸네일 선택
	@Override
	public List<ProductThumb> selectThumb(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectThumb", pdtNo);
	}

	// 썸네일 등록
	@Override
	public int insertThumb(SqlSession session, ProductThumb th) {
		// TODO Auto-generated method stub
		return session.insert("admin.insertThumb", th);
	}

	// 제품 수정
	@Override
	public int updateProduct(SqlSession session, Product p) {
		// TODO Auto-generated method stub
		return session.update("admin.updateProduct", p);
	}

	// 썸네일 삭제
	@Override
	public int deleteThumb(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.delete("admin.deleteThumb", pdtNo);
	}

	// 옵션 삭제
	@Override
	public int deleteOption(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.delete("admin.deleteOption", pdtNo);
	}

	// 옵션 여부 확인
	@Override
	public Product checkOption(SqlSession session, String pdtNo) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.checkOption", pdtNo);
	}
	//제품명 중복 검사
	@Override
	public int selectPdtName(SqlSession session, String pdtName) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectPdtName",pdtName);
	}
	//제품명 중복 검사-수정페이지
	@Override
	public int selectPdtName(SqlSession session, String pdtName, String pdtNo) {
		// TODO Auto-generated method stub
		Map map=new HashMap();
		map.put("pdtName", pdtName);
		map.put("pdtNo", pdtNo);
		return session.selectOne("admin.checkPdtName",map);
	}
	

	// 1:1목록 가져오기
	@Override
	public List<Qna> selectQnaList(SqlSession session, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectQnaList", "", new RowBounds((cPage - 1) * numPerpage, numPerpage));
	}

	// 1:1 페이징처리 위한 count
	@Override
	public int selectQnaCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectQnaCount");
	}

	// 1:1문의 답변
	@Override
	public int insertQnaAnswer(SqlSession session, Qna q) {
		// TODO Auto-generated method stub
		return session.insert("admin.insertQnaAnswer", q);
	}

	// 메인배너리스트
	@Override
	public List<MainBanner> selectBannerList(SqlSession session) {
		return session.selectList("admin.selectBannerList");
	}

	@Override
	public int insertBanner(SqlSession session, MainBanner mb) {
		return session.insert("admin.insertBanner", mb);
	}

	// 배너등록에 필요한 상품목록
	@Override
	public List<Product> selectProductList(SqlSession session) {
		return session.selectList("admin.selectProductBanner");
	}

	// 배너 한개 삭제
	@Override
	public int deleteBanner(SqlSession session, String no) {
		return session.delete("admin.deleteBanner", no);
	}
	//배너 한개row 가져오기
	@Override
	public MainBanner selectBannerOne(SqlSession session, String no) {
		return session.selectOne("admin.selectBannerOne", no);
	}
	//배너 수정하기
	@Override
	public int updateBanner(SqlSession session, MainBanner mb) {
		return session.update("admin.updateBanner",mb);
	}

	// 1:1문의 삭제
	@Override
	public int deleteQna(SqlSession session, String qnaNo) {
		// TODO Auto-generated method stub
		return session.delete("admin.deleteQna", qnaNo);
	}

	// 1:1문의 답변대기목록
	@Override
	public List<Qna> selectQnaWaitList(SqlSession session, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectQnaWaitList", "", new RowBounds((cPage - 1) * numPerpage, numPerpage));
	}
	//주문관리 (주문리스트)
	@Override
	public List<Order> selectOrderList(SqlSession session, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectOrderList", "", new RowBounds((cPage - 1) * numPerpage, numPerpage));
	}
	//주문관리 페이징
	@Override
	public int selectOrderCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectOrderCount");
	}
	//주문상세내역

	@Override
	public Order selectOrderOne(SqlSession session, String orderNo) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectOrderOne", orderNo);
	}
	
	
	
}

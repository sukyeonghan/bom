package com.kh.bom.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.admin.model.vo.MainBanner;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.vo.Order;
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
	
	List<Product> selectProductList(SqlSession session,int cPage,int numPerPage,String sort);
	List<Product> selectSearchList(SqlSession session,int cPage,int numPerpage,Map<String, String> map);
	int countProduct(SqlSession session,String sort);
	int countProduct(SqlSession session,Map<String, String> map);
	int deleteProduct(SqlSession session,String pdtNo);
	int insertProduct(SqlSession session,Product p);
	int insertThumb(SqlSession session,ProductThumb th);
	int insertOption(SqlSession session,ProductOption o);
	Product selectOneProduct(SqlSession session,String pdtNo);
	List<ProductOption> selectOption(SqlSession session,String pdtNo);
	List<ProductThumb> selectThumb(SqlSession session,String pdtNo);
	int updateProduct(SqlSession session,Product p);
	Product checkOption(SqlSession session,String pdtNo);
	int selectPdtName(SqlSession session,String pdtName);
	int selectPdtName(SqlSession session,String pdtName,String pdtNo);
	int updateOptStatus(SqlSession session,String status,String pdtNo);
	int deleteThumb(SqlSession session,String pdtNo);
	int deleteOption(SqlSession session,String pdtNo);
	
	//회원관리
	//관리자권한 변경
	int updateManagerYn(SqlSession session, Member m);
	//회원리스트
	List<Member> selectMemberList(SqlSession session,int cPage, int numPerpage, Map map);
	//회원수
	int selectMemberCount(SqlSession session, Map<String, String> map);
	//검색자동완성
	List<Member> memberAutoComplete(SqlSession session, Map<String, String> map);
	
	//qna 
	List<Qna> selectQnaList(SqlSession session, int cPage, int numPerpage);
	int selectQnaCount(SqlSession session);
	int insertQnaAnswer(SqlSession session, Qna q);
	int deleteQna(SqlSession session, String qnaNo);
	List<Qna> selectQnaWaitList(SqlSession session, int cPage, int numPerpage);
	
	//메인배너
	List<MainBanner> selectBannerList(SqlSession session);//배너리스트가져오기
	int insertBanner(SqlSession session, MainBanner mb);//배너등록하기
	List<Product> selectProductList(SqlSession session);//배너등록에 필요한 상품목록
	int deleteBanner(SqlSession session, String no);//배너삭제하기
	MainBanner selectBannerOne(SqlSession session, String no);//배너한개가져오기
	int updateBanner(SqlSession session, MainBanner mb);//배너수정하기
	
	//주문
	List<Order> selectOrderList(SqlSession session, int cPage, int numPerpage);
	int selectOrderCount(SqlSession session);
	List<Order> selectOrderDetail(SqlSession session, String orderNo);
	Order selectOrderOne(SqlSession session, String orderNo);
	int orderShipUpdate(SqlSession session, Order o);
	List<Order> selectOrdWaitList(SqlSession session, Map map);
	int selectOrdWaitCount(SqlSession session, Map map);
	int updateOrder(SqlSession session, Order o);

	


}

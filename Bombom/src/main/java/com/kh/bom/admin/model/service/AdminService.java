package com.kh.bom.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.admin.model.vo.MainBanner;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.vo.Order;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.qna.model.vo.Qna;

public interface AdminService {
	//이벤트 목록 출력
	List<Event> selectEvent();
	//이벤트 카테고리별 정렬후 목록 출력
	List<Event> selectEventSort(String sort);
	//이벤트 한개 삭제
	int eventDelete(String eventNo);
	//이벤트 등록
	int insertEvent(Event e);
	//이벤트 no가져오기
	Event selectEvent(String eventNo);
	//이벤트 수정하기
	int updateEvent(Event e);
	
	List<Product> selectProductList(int cpage,int numPerPage,String sort);//제품목록 출력
	List<Product> selectSearchList(int cPage,int numPerPage, Map<String, String> map);//제품검색목록 출력
	int countProduct(String sort);//제품 개수
	int countProduct(Map<String, String> map);//키워드별 개수
	int deleteSelectProduct(List<String> delnum,String path);//제품 선택 삭제
	int deleteOneProduct(String pdtNo,String path);//제품 하나 삭제
	int updateOptStatus(String status,String pdtNo);//옵션 상태 수정
	int deleteOption(String pdtNo);//옵션 삭제
	int insertProduct(Product p,ProductOption o,List<Map<Object,Object>> options,List<ProductThumb> list);//제품 등록
	Product selectOneProduct(String pdtNo);//제품 하나 선택
	List<ProductOption> selectOption(String pdtNo);//옵션 선택
	List<ProductThumb> selectThumb(String pdtNo);//썸네일 사진 선택
	int updateProduct(Product p,ProductOption o,List<Map<Object,Object>> options,List<ProductThumb> list,String path);//제품 수정
	int selectPdtName(String pdtName);//제품명 중복검사
	int selectPdtName(String pdtName,String pdtNo);//제품명 중복검사(수정페이지)
	
	//관리자권한 변경
	int updateManagerYn(Member m);
	//회원리스트
	List<Member> selectMemberList(int cPage, int numPerpage, Map map);
	//회원수
	int selectMemberCount(Map<String, String> map);
	//검색 자동완성
	List<Member> memberAutoComplete(Map<String, String> map);
	//qna 전체 목록
	List<Qna> selectQnaList(int cPage, int numPerpage);
	//qna 페이징
	int selectQnaCount();
	//qna 관리자 답변
	int insertQnaAnswer(Qna q);
	//qna 삭제
	int deleteQna(String qnaNo);
	//qna 답변대기목록
	List<Qna> selectQnaWaitList(int cPage, int numPerpage);
	
	//메인배너리스트가져오기
	List<MainBanner> selectBannerList();
	int insertBanner(MainBanner mb);
	List<Product> selectProductList();//배너등록에 필요한 상품목록
	int deleteBanner(String no);
	MainBanner selectBannerOne(String no);//수정하기를 위한 row한개 가져오기
	int updateBanner(MainBanner mb); //배너수정하기
	
	//주문관리 
	List<Order> selectOrderList(int cPage, int numPerpage);
	int selectOrderCount();
	List<Order> selectOrderDetail(String orderNo);
	Order selectOrderOne(String orderNo);
	int orderShipUpdate(Order o);
	List<Order> selectOrdWaitList(int cPage, int numPerpage, Map map);
	int selectOrdWaitCount(Map map);
	int updateOrder(Order o);

	
	
	

}

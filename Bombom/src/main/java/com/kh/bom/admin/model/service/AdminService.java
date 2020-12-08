package com.kh.bom.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;
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
	
	//제품목록 출력
	List<Product> selectProductList();
	//제품 선택 삭제
	int deleteSelectProduct(List<String> delnum);
	//제품 등록
	int insertProduct(Product p,ProductOption o,List<Map<Object,Object>> options,List<ProductThumb> list);

	List<Member> selectMemberList(int cPage, int numPerpage);
	int selectMemberCount();
	
	List<Qna> selectQnaList(int cPage, int numPerpage);
	
	int selectQnaCount();

}

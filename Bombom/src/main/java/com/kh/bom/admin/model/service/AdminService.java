package com.kh.bom.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;

public interface AdminService {
	List<Event> selectEvent();
	int eventDelete(String eventNo);
	int insertEvent(Event e);
	Event selectEvent(String eventNo);
	int updateEvent(Event e);
	
	//제품목록 출력
	List<Product> selectProductList();
	//제품 선택 삭제
	int deleteSelectProduct(List<String> delnum);
	//제품 등록
	int insertProduct(Product p,List<ProductThumb> list);

	List<Member> selectMemberList(int cPage, int numPerpage);
	int selectMemberCount();

}

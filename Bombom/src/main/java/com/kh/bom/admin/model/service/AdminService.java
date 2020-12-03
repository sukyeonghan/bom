package com.kh.bom.admin.model.service;

import java.util.List;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.member.model.vo.Member;

public interface AdminService {
	List<Event> selectEvent();
	int eventDelete(String eventNo);
	int insertEvent(Event e);
	Event selectEvent(String eventNo);
	int updateEvent(Event e);
	//상품 등록
	int insertProduct(Product p,List<ProductThumb> list);

	List<Member> selectMemberList(int cPage, int numPerpage);
	int selectMemberCount();

}

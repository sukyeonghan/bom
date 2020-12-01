package com.kh.bom.admin.model.service;

import java.util.List;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductThumb;

public interface AdminService {
	List<Event> selectEvent();
	int eventDelete(String eventNo);
	int insertEvent(Event e);
	
	//상품 등록
	int insertProduct(Product p,List<ProductThumb> list);
}

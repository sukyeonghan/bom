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
	List<Event> selectEvent();
	int eventDelete(String eventNo);
	int insertEvent(Event e);
	Event selectEvent(String eventNo);
	int updateEvent(Event e);
	
	List<Product> selectProductList();//제품목록 출력
	int deleteSelectProduct(List<String> delnum);//제품 선택 삭제
	int deleteOneProduct(String pdtNo);//제품 하나 삭제
	int insertProduct(Product p,ProductOption o,List<Map<Object,Object>> options,List<ProductThumb> list);//제품 등록
	Product selectOneProduct(String pdtNo);//제품 하나 선택
	List<ProductOption> selectOption(String pdtNo);//옵션 선택
	List<ProductThumb> selectThumb(String pdtNo);//썸네일 사진 선택
	int updateProduct(Product p,ProductOption o,List<Map<Object,Object>> options,List<ProductThumb> list);//제품 수정
	//회원관리 리스트
	List<Member> selectMemberList(int cPage, int numPerpage);
	//회원수
	int selectMemberCount();
	
	List<Qna> selectQnaList(int cPage, int numPerpage);
	
	int selectQnaCount();
	int insertQnaAnswer(Qna q);

}

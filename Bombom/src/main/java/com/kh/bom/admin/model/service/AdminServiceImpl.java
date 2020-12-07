package com.kh.bom.admin.model.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.admin.model.dao.AdminDao;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.qna.model.vo.Qna;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private SqlSession session;
	@Autowired
	private AdminDao dao;

	@Override
	public List<Event> selectEvent() {
		return dao.selectEvent(session);
	}

	@Override
	public Event selectEvent(String eventNo) {
		return dao.selectEvent(session, eventNo);
	}

	@Override
	public int eventDelete(String eventNo) {
		return dao.eventDelete(session, eventNo);
	}

	@Override
	public int insertEvent(Event e) {
		return dao.insertEvent(session, e);
	}
	
	@Override
	public int updateEvent(Event e) {
		return dao.updateEvent(session, e);
	}
	
	//제품목록 출력
	@Override
	public List<Product> selectProductList() {
		
		return dao.selectProductList(session);
	}
	//제품 선택 삭제
	@Override
	public int deleteSelectProduct(List<String> delnum) {
		// TODO Auto-generated method stub
		int result=0;
		String no="";
		for(int i=0; i<delnum.size(); i++) {
			no=delnum.get(i);
			result=dao.deleteProduct(session,no);
		}
		return result;
	}
	//제품 하나 삭제
	@Override
	public int deleteOneProduct(String pdtNo) {
		// TODO Auto-generated method stub
		return dao.deleteProduct(session, pdtNo);
	}
	//제품등록
	@Override
	@Transactional
	public int insertProduct(Product p,ProductOption o,List<Map<Object,Object>> options, List<ProductThumb> list) {
		//트랜잭션 처리하기
		int result=dao.insertProduct(session,p);
		if(result>0) {
			
			for(int i=0;i<options.size(); i++) {
				
				o.setPdtNo(p.getPdtNo());
				o.setPdtOptionContent((String)(options.get(i).get("pdtOptionContent")));
				o.setPdtOptionAddprice(Integer.parseInt((String)(options.get(i).get("pdtOptionAddprice"))));
				result=dao.insertOption(session, o);
			}
			
			if(result>0) {
					if(list!=null) {
					for(ProductThumb th : list) {
						th.setPdtNo(p.getPdtNo());
						result=dao.insertThumb(session,th);
					}
				}
			}
			
		}
		return result;
	}
	//제품 하나 선택
	@Override
	public Product selectOneProduct(String pdtNo) {
		return dao.selectOneProduct(session,pdtNo);
	}
	//옵션 선택
	@Override
	public List<ProductOption> selectOption(String pdtNo) {
		return dao.selectOption(session,pdtNo);
	}
	//썸네일 선택
	@Override
	public List<ProductThumb> selectThumb(String pdtNo) {
		return dao.selectThumb(session,pdtNo);
	}
	//제품 수정
	@Override
	public int updateProduct(Product p, ProductOption o, List<Map<Object, Object>> options,
			List<ProductThumb> list) {
	
		int result=dao.updateProduct(session,p);
		//제품 업데이트 하면 옵션 업데이트
		if(result>0) {
			if(options.size()!=0) {
				for(int i=0;i<options.size(); i++) {
					
					o.setPdtNo(p.getPdtNo());
					o.setPdtOptionContent((String)(options.get(i).get("pdtOptionContent")));
					o.setPdtOptionAddprice(Integer.parseInt((String)(options.get(i).get("pdtOptionAddprice"))));
					result=dao.updateOption(session, o);
				}
			}
			//옵션 업데이트하면 썸네일 업데이트
			if(result>0) {
				
				if(list!=null) {
					//이전에 있던 썸네일 지우기
					result=dao.deleteThumb(session,p.getPdtNo());
					System.out.println("result결과"+result);
					if(result>0) {
						//지운 후 다시 insert
						for(ProductThumb th : list) {
							th.setPdtNo(p.getPdtNo());
							result=dao.insertThumb(session,th);
							System.out.println("result결과"+result);
						}
					}
				}
			}
			
		}
		return result;
	}
	
	@Override
	public List<Member> selectMemberList(int cPage,int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectMemberList(session,cPage, numPerpage);
	}

	@Override
	public int selectMemberCount() {
		// TODO Auto-generated method stub
		return dao.selectMemberCount(session);
	}
	
	@Override
	public List<Qna> selectQnaList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectQnaList(session, cPage, numPerpage);
	}

	@Override
	public int selectQnaCount() {
		// TODO Auto-generated method stub
		return dao.selectQnaCount(session);
	}
	
	
	

}

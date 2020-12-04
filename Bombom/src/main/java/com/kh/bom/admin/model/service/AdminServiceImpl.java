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
	
	//제품등록
	@Override
	@Transactional
	public int insertProduct(Product p,ProductOption o,List<Map<Object,Object>> options, List<ProductThumb> list) {
		//트랜잭션 처리하기
		int result=dao.insertProduct(session,p);
		if(result>0) {
			//List<Map>에 들어있는 옵션 내용,옵션 가격 뺴기
			/*Iterator<Entry<Integer, String>> entries = options.entrySet().iterator();
			while(entries.hasNext()){
			    Map.Entry<Integer, String> entry = entries.next();
			    System.out.println("[Key]:" + entry.getKey() + " [Value]:" +  entry.getValue());
			}
			*/
			for(Map<Object,Object> map:options) {
				for(Map.Entry<Object,Object> entry:map.entrySet()) {
					String key=(String) entry.getKey();
					Object value=entry.getValue();
					
					if(key.contains("pdtOptionContent")) {
						o.setPdtOptionContent((String)value);
					}else if(key.contains("pdtOptionPrice")) {
						o.setPdtOptionAddprice((int)value);
					}
					result=dao.insertOption(session, o);
				}
				
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
	
	
	

}

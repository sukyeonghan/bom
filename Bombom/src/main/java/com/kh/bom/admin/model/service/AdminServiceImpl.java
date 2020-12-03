package com.kh.bom.admin.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.admin.model.dao.AdminDao;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.member.model.vo.Member;

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

	//상품등록
	@Override
	@Transactional
	public int insertProduct(Product p, List<ProductThumb> list) {
		//트랜잭션 처리하기
		int result=dao.insertProduct(session,p);
		if(result>0) {
			result=dao.insertOption(session, p);
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

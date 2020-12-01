package com.kh.bom.admin.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.admin.model.dao.AdminDao;
import com.kh.bom.admin.model.vo.Event;
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
	public int eventDelete(String eventNo) {
		return dao.eventDelete(session, eventNo);
	}

	@Override
	public int insertEvent(Event e) {
		return dao.insertEvent(session, e);
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

package com.kh.bom.member.model.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.member.model.dao.MemberDao;
import com.kh.bom.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private SqlSession session;
	@Autowired
	private MemberDao dao;
	
	@Override
	public Member selectMemberOne(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectMemberOne(session,memNo);
	}

	@Override
	public int deleteMember(String memNo) {
		// TODO Auto-generated method stub
		return dao.deleteMember(session,memNo);
	}

	@Override
	public Member selectMemberNick(String memNick) {
		// TODO Auto-generated method stub
		return dao.selectMemberNick(session, memNick);
	}

	@Override
	public int updateMember(Member m) {
		// TODO Auto-generated method stub
		return dao.updateMember(session,m);
	}
	
	
}

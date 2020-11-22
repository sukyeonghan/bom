package com.kh.bom.member.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public Member selectMemberOne(SqlSession session, String memEmail) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberOne", memEmail);
	}

	@Override
	public int deleteMember(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.update("member.deleteMember",memNo);
	}



	

	
}

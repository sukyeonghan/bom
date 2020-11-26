package com.kh.bom.member.model.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.member.model.vo.Member;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public Member selectMemberOne(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberOne", memNo);
	}

	@Override
	public int deleteMember(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.update("member.deleteMember",memNo);
	}

	@Override
	public Member selectMemberNick(SqlSession session, String memNick) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberNick",memNick);
	}

	@Override
	public int updateMember(SqlSession session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateMember",m);
	}

	@Override
	public int insertMember(SqlSession session, Member m) {
		// TODO Auto-generated method stub
		return session.insert("member.insertMember",m);
	}

	//로그인
	@Override
	public Member selectOneMember(SqlSession session, String email) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectOneMember",email);
	}

	
	

	

	
}

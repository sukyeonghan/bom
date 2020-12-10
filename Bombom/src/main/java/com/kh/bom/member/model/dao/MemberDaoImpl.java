package com.kh.bom.member.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.vo.Point;

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

	//이메일중복확인
	@Override
	public Member selectMemberEmail(SqlSession session, String email) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberEmail",email);
	}

	@Override
	public int updateMemBuyCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		Map param=new HashMap();
		param.put("memNo",memNo);
		return session.update("member.updateMemBuyCount",param);
	}

	//가입할때 포인트적립
	@Override
	public int insertMemPoint(SqlSession session, Point p) {
		// TODO Auto-generated method stub
		return session.insert("member.insertMemPoint",p);
	}

	
	
	
	

	

	
}

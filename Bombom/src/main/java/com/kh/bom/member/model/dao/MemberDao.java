package com.kh.bom.member.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.member.model.vo.Member;

public interface MemberDao {
	Member selectMemberOne(SqlSession session,String memNo);

	int deleteMember(SqlSession session, String memNo);

	Member selectMemberNick(SqlSession session, String memNick);

	int updateMember(SqlSession session, Member m);

	int insertMember(SqlSession session, Member m);

	Member selectOneMember(SqlSession session, String email);
}

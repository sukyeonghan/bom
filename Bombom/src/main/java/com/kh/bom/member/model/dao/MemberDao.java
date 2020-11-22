package com.kh.bom.member.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.member.model.vo.Member;

public interface MemberDao {
	Member selectMemberOne(SqlSession session,String memEmail);

	int deleteMember(SqlSession session, String memNo);
}

package com.kh.bom.member.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.vo.Point;

public interface MemberDao {
	Member selectMemberOne(SqlSession session,String memNo);

	int deleteMember(SqlSession session, String memNo);

	Member selectMemberNick(SqlSession session, String memNick);

	int updateMember(SqlSession session, Member m);

	int insertMember(SqlSession session, Member m);

	Member selectOneMember(SqlSession session, String email);

	Member selectMemberEmail(SqlSession session, String email);

	int updateMemBuyCount(SqlSession session, String memNo);

	int insertMemPoint(SqlSession session, Point p);

	int updateMemberPw(SqlSession session, Member m);

}

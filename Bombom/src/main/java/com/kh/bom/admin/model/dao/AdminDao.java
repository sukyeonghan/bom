package com.kh.bom.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;

public interface AdminDao {
	List<Event> selectEvent(SqlSession session);
	int eventDelete(SqlSession session, String eventNo);
	int insertEvent(SqlSession session, Event e);
	
	List<Member> selectMemberList(SqlSession session);
	int selectMemberCount(SqlSession session);
}

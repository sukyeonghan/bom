package com.kh.bom.admin.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;
@Repository
public class AdminDaoImpl implements AdminDao {

	@Override
	public List<Event> selectEvent(SqlSession session) {
		return session.selectList("admin.selectEvent");
	}

	@Override
	public int eventDelete(SqlSession session, String eventNo) {
		return session.delete("admin.eventDelete", eventNo);
	}

	@Override
	public int insertEvent(SqlSession session, Event e) {
		return session.insert("admin.insertEvent",e);
	}

	@Override
	public List<Member> selectMemberList(SqlSession session,int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("admin.selectMemberList","",new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int selectMemberCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("admin.selectMemberCount");
	}
	
	
	
}

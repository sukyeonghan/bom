package com.kh.bom.notice.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.notice.model.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Override
	public List<Notice> selectNoticeList(SqlSession session) {
		
		return session.selectList("notice.selectNoticeList");
	}

	@Override
	public Notice selectNoticeOne(SqlSession session, String noticeNo) {
		// TODO Auto-generated method stub
		return session.selectOne("notice.selectNoticeOne",noticeNo);
	}

	
	
}

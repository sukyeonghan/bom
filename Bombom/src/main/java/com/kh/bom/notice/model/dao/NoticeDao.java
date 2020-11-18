package com.kh.bom.notice.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.notice.model.vo.Notice;

public interface NoticeDao {
	
	List<Notice> selectNoticeList(SqlSession session);
	
	Notice selectNoticeOne(SqlSession session,String noticeNo);

}

package com.kh.bom.notice.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.notice.model.dao.NoticeDao;
import com.kh.bom.notice.model.vo.Notice;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao dao;
	
	@Autowired
	private SqlSession session;
	
	@Override
	public List<Notice> selectNoticeList() {
		// TODO Auto-generated method stub
		return dao.selectNoticeList(session);
	}

	@Override
	public int insertNotice(Notice notice) {
		// TODO Auto-generated method stub
		
		return dao.insertNotice(session, notice);
	}

	@Override
	public int deleteNotice(String noticeNo) {
		// TODO Auto-generated method stub
		return dao.deleteNotice(session,noticeNo);
	}
	
	@Override
	public Notice selectNoticeOne(String noticeNo) {
		// TODO Auto-generated method stub
		return dao.selectNoticeOne(session,noticeNo);
	}
	@Override
	public int updateNotice(Notice notice) {
		// TODO Auto-generated method stub
		return dao.updateNotice(session,notice);
	}

	
	
	
}

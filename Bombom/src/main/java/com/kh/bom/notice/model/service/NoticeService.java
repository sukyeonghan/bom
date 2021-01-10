package com.kh.bom.notice.model.service;

import java.util.List;

import com.kh.bom.notice.model.vo.Notice;

public interface NoticeService {
	
	List<Notice> selectNoticeList();
	
	List<Notice> selectNoticeList2();
	
	Notice selectNoticeOne(String noticeNo);
	
	int insertNotice(Notice notice);
	
	int deleteNotice(String noticeNo);
	
	int updateNotice(Notice notice);


}

package com.kh.bom.notice.model.service;

import java.util.List;

import com.kh.bom.notice.model.vo.Notice;

public interface NoticeService {
	
	List<Notice> selectNoticeList(int cPage,int numPerpage);
	
	int selectCount();
	
	Notice selectNoticeOne(String noticeNo);
	
	int insertNotice(Notice notice);
	
	int deleteNotice(String noticeNo);
	
	int updateNotice(Notice notice);


}

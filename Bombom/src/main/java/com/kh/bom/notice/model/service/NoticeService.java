package com.kh.bom.notice.model.service;

import java.util.List;

import com.kh.bom.notice.model.vo.Notice;

public interface NoticeService {
	
	List<Notice> selectNoticeList();
	
	Notice selectNoticeOne(String noticeNo);


}

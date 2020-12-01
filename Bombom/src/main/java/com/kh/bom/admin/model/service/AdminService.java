package com.kh.bom.admin.model.service;

import java.util.List;

import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;

public interface AdminService {
	List<Event> selectEvent();
	int eventDelete(String eventNo);
	int insertEvent(Event e);
	
	List<Member> selectMemberList(int cPage, int numPerpage);
	int selectMemberCount();
}

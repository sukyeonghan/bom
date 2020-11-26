package com.kh.bom.admin.model.service;

import java.util.List;

import com.kh.bom.admin.model.vo.Event;

public interface AdminService {
	List<Event> selectEvent();
	int eventDelete(String eventNo);
}

package com.kh.bom.community.model.service;

import java.util.List;


import com.kh.bom.community.model.vo.Community;

public interface CommunityService {
	
	int insertCommunity(Community community);
	
	List<Community> selectCommunityList(int cPage, int numPerpage);
	
	int selectCount();
	
	Community selectCommunityOne(String cmNo);
	
	int deleteCommunity(String cmNo);
	
	int updateCommunity(Community community);
	
	int communityView(String cmNo);

}

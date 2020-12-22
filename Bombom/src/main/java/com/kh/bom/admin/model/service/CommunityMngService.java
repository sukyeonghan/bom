package com.kh.bom.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.community.model.vo.BoardReply;

public interface CommunityMngService {
	
	List<BoardReply> selectReplyList(int cPage, int numPerpage);
	
	int selectPage();
	
	List <BoardReply> selectSearchList(int cPage,int numPerpage,Map<String,String>map); //제품검색목록 출력
	
    int reportReply(BoardReply br);
    
    int warnMemberYn(BoardReply br);
    
}

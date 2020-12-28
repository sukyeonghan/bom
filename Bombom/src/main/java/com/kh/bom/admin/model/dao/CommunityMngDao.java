package com.kh.bom.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.community.model.vo.BoardReply;


public interface CommunityMngDao {
	
	List<BoardReply> selectReplyList(SqlSession session,int cPage, int numPerpage,Map m);
	
	int selectPage(SqlSession session);
	
	List<BoardReply> selectSearchList(SqlSession session,int cPage,int numPerpage,Map<String,String> map);
    
	int reportReply(SqlSession session,BoardReply br);
	
	int warnMemberYn(SqlSession session,BoardReply br);

}

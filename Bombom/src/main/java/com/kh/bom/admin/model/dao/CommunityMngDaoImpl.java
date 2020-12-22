package com.kh.bom.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.bom.community.model.vo.BoardReply;

@Repository
public class CommunityMngDaoImpl implements CommunityMngDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<BoardReply> selectReplyList(SqlSession session,int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("community.selectReplyList",null,
				new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int selectPage(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("community.selectPage");
	}
    //검색목록
	@Override
	public List<BoardReply> selectSearchList(SqlSession session, int cPage, int numPerpage, Map<String, String> map) {
		// TODO Auto-generated method stub
		return session.selectList("community.searchReplyList",map,new RowBounds((cPage - 1) * numPerpage, numPerpage));
	}

	@Override
	public int reportReply(SqlSession session, BoardReply br) {
		// TODO Auto-generated method stub
		return session.insert("community.reportReply",br);
	}

	@Override
	public int warnMemberYn(SqlSession session, BoardReply br) {
		// TODO Auto-generated method stub
		return session.update("community.warnMemberYn",br);
	}
	
	
   
	
	
}

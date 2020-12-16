package com.kh.bom.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;

@Repository
public class CommunityDaoImpl implements CommunityDao {
	
	@Autowired
    private SqlSession sqlSession;
 

	@Override
	public int insertCommunity(SqlSession session, Community community) {
		// TODO Auto-generated method stub
		return session.insert("community.insertCommunity",community);
	}

	@Override
	public List<Community> selectCommunityList(SqlSession session,int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("community.selectCommunityList",null,
				new RowBounds((cPage-1)*numPerpage,numPerpage));
	}
	
	@Override
	public int selectCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("community.selectCount");
	}

	@Override
	public Community selectCommunityOne(SqlSession session, String cmNo) {
		// TODO Auto-generated method stub
		return session.selectOne("community.selectCommunityOne",cmNo);
	}

	@Override
	public int deleteCommunity(SqlSession session, String cmNo) {
		// TODO Auto-generated method stub
		return session.delete("community.deleteCommunity",cmNo);
	}

	@Override
	public int updateCommunity(SqlSession session, Community community) {
		// TODO Auto-generated method stub
		return session.update("community.updateCommunity",community);
	}

	@Override
	public int communityView(SqlSession session, String cmNo) {
		// TODO Auto-generated method stub
		return session.update("community.communityView",cmNo);
	}

	
	  @Override
	    public int regReply(SqlSession session,Map<String, Object> paramMap) {
	        return session.insert("community.insertBoardReply", paramMap);
	    }
	 
	    @Override
	    public List<BoardReply> getReplyList(SqlSession session,Map<String, Object> paramMap) {
	        return session.selectList("community.selectBoardReplyList", paramMap);
	    }
	 
	    @Override
	    public int delReply(SqlSession session,Map<String, Object> paramMap) {
	        if(paramMap.get("r_type").equals("main")) {
	            //부모부터 하위 다 지움
	            return session.delete("community.deleteBoardReplyAll", paramMap);
	        }else {
	            //자기 자신만 지움
	            return session.delete("community.deleteBoardReply", paramMap);
	        }
	        
	        
	    }
	
	 
	    @Override
	    public boolean checkReply(SqlSession session,Map<String, Object> paramMap) {
	        int result = session.selectOne("community.selectReplyPassword", paramMap);
	                
	        if(result>0) {
	            return true;
	        }else {
	            return false;
	        }
	        
	    }
	 
	    @Override
	    public boolean updateReply(SqlSession session,Map<String, Object> paramMap) {
	        int result = session.update("community.updateReply", paramMap);
	        
	        if(result>0) {
	            return true;
	        }else {
	            return false;
	        }
	    }


		@Override
		public String selectSeqReply(SqlSession session) {
			// TODO Auto-generated method stub
			return session.selectOne("community.selectSeqReply");
		}

		@Override
		public BoardReply selectBoardReplyOne(SqlSession session, String number) {
			// TODO Auto-generated method stub
			return session.selectOne("community.selectBoardReplyOne",number);
		}
    
		


	
}

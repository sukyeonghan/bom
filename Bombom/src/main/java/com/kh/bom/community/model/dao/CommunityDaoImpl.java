package com.kh.bom.community.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.bom.community.model.vo.BoardReply;
import com.kh.bom.community.model.vo.Community;
import com.kh.bom.member.model.vo.Member;

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
	public List<Community> selectCommunityList(SqlSession session,int cPage, int numPerpage, Map m) {
		// TODO Auto-generated method stub
		return session.selectList("community.selectCommunityList",m,
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
	    public int insertReply(SqlSession session,BoardReply br) {
	        return session.insert("community.insertReply", br);
	        
	        
	    }
	 
	    @Override
	    public int insertReReply(SqlSession session, BoardReply br) {
		// TODO Auto-generated method stub
		return session.insert("community.insertReReply",br);
	    }

		@Override
	    public List<BoardReply> getReplyList(SqlSession session,String cmNo) {
	        return session.selectList("community.selectBoardReplyList", cmNo);
	    }
	    
	    
		@Override
		public BoardReply getChildReplyList(SqlSession session, String reply_id) {
			return session.selectOne("community.selectChildBoardReplyList", reply_id);
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

		@Override
		public int deleteReply(SqlSession session,BoardReply br) {
			// TODO Auto-generated method stub
			return session.delete("community.deleteReply",br);
		}

		@Override
		public int reportReply(SqlSession session, BoardReply reply) {
			// TODO Auto-generated method stub
			return session.insert("community.reportReply",reply);
		}
    
		//좋아요 수 업데이트
		@Override
		public int updateCount(SqlSession session,Map<String,Object> map) {
			// TODO Auto-generated method stub
			return session.update("community.updateLikeCount",map);
		}

		//좋아요 수만 가져오기
		@Override
		public int selectLikeCount(SqlSession session, String cmNo) {
			// TODO Auto-generated method stub
			return session.selectOne("community.selectLikeCount",cmNo);
		}
		//좋아요 한 글 번호 넣기
		@Override
		public int updateLikeNo(SqlSession session, Map<String,Object> map) {
			// TODO Auto-generated method stub
			return session.update("community.updateLikeNo",map);
		}
		//좋아요 취소 시 글 번호 업데이트
		@Override
		public int deleteLikeNo(SqlSession session, Map<String, Object> map) {
			// TODO Auto-generated method stub
			return session.update("community.deleteLikeNo",map);
		}
		//업데이트한 글 번호 가져오기
		@Override
		public Member selectLikeNo(SqlSession session, String memNo) {
			// TODO Auto-generated method stub
			return session.selectOne("community.selectLikeNo", memNo);
		}

	
}

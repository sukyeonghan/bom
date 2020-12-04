package com.kh.bom.qna.model.dao;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.qna.model.vo.Qna;

@Repository
public class QnaDaoImpl implements QnaDao {

	@Override
	public int insertQna(Qna qna, SqlSession session) {
		// TODO Auto-generated method stub
		return session.insert("qna.insertQna",qna);
	}

	@Override
	public Object selectQnaList(SqlSession session, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("qna.selectQnaList",null,new RowBounds((cPage-1)*numPerpage, numPerpage));
	}

	@Override
	public int selectCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("qna.selectCount");
	}

	
	
}

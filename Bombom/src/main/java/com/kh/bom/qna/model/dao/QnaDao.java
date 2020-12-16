package com.kh.bom.qna.model.dao;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.qna.model.vo.Qna;

public interface QnaDao {

	int insertQna(Qna qna, SqlSession session);

	Object selectQnaList(SqlSession session, String memNo,int cPage, int numPerpage);

	int selectCount(SqlSession session, String memNo);

	int deleteQna(SqlSession session, Qna q);


}

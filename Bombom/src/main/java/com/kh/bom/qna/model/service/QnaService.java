package com.kh.bom.qna.model.service;

import com.kh.bom.qna.model.vo.Qna;

public interface QnaService {

	int insertQna(Qna qna);

	Object selectQnaList(String memNo,int cPage, int numPerpage);

	int selectCount(String memNo);

	int deleteQna(Qna q);

}

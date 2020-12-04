package com.kh.bom.qna.model.service;

import com.kh.bom.qna.model.vo.Qna;

public interface QnaService {

	int insertQna(Qna qna);

	Object selectQnaList(int cPage, int numPerpage);

	int selectCount();

}

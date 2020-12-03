package com.kh.bom.qna.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Qna {

	private String qnaNo;
	private String qnaWriter;
	private String qnaCategory;
	private String qnaTitle;
	private String qnaContent;
	private Date qnaDate;
	private String qnaYn;
	private String qnaAnswer;
	private String qnaAnswerDate;
}

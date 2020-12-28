package com.kh.bom.community.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BoardReply {
	private String reply_id;
	private String board_id;
	private String parent_id;
	private String depth;
	private String reply_content;
	private String reply_writer;
	private Date register_datetime;
	private Date com_date;
	private String com_reason;
	private String com_status;
    private String mem_nick;
    private String mem_pro;
    private String mem_no;
 
}

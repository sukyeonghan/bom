package com.kh.bom.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Builder
@Data
public class Alarm {
   
   private String alarmNo;
   private String receiverNo;
   private String message;
   private Date alarmDate;
   
}
package com.kh.bom.member.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
    private String memNo;
    private String memNick;
    private String memPwd;
    private String memEmail;
    private String memPro;
    private int memBuyCount;
    private int memWarnCount;
    private String memManagerYn;
    private String memStatus;
    private int memPoint;
    private String googleId;
    private String naverId;
    private String kakaoId;
    private String[] memCmLike;
    private Date memOutDate;//탈퇴날짜
    private Date memLastDate;//최근접속날짜
    private int last;//최근접속일-오늘날짜
    private	int out;//탈퇴일-오늘날짜

}

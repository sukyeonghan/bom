package com.kh.bom.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
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
}

package com.kh.bom.ship.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Ship {
    private String shipNo;
    private String memNo;
    private String shipLocalName;
    private String shipAddress;
    private String shipPhone;
    private String shipRecipient;
    private String shipYn;
    private String shipZipCode;
    private String shipDetailAddress; 
    private String shipExtraAddress;
}

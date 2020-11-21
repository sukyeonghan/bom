package com.kh.bom.member.model.service;

import com.kh.bom.member.model.vo.Member;

public interface MemberService {
	//회원정보수정 전 비밀번호 체크
	Member selectMemberOne(String memEmail);

}

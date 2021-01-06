package com.kh.bom.member.model.service;

import java.util.List;

import com.kh.bom.member.model.vo.Alarm;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.vo.Point;

public interface MemberService {
	//회원정보수정 전 비밀번호 체크
	Member selectMemberOne(String memNo);

	int deleteMember(String memNo);

	Member selectMemberNick(String memNick);

	int updateMember(Member m);

	int insertMember(Member mem, Point p);

	Member selectOneMember(String email);
	//이메일 중복체크
	Member selectMemberEmail(String email);

	int updateMemberPw(Member m);
	
	//알림 리스트
	List<Alarm> selectAlarmList(String memNo);
	//알림 개수
	int countAlarm(String memNo);
	//알림저장
	int insertAlarm(Alarm a);
	//알림삭제
	int deleteAlarm(String alarmNo);
	int deleteAlarmAll(String receiverNo);

	//sns로가입되어 있는지 여부
	Member selectSnsMem(Member snsMem);
	//접속일
	int updateMemLastDate(String memNo);

	
}

package com.kh.bom.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.member.model.vo.Alarm;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.vo.Point;

@Repository
public class MemberDaoImpl implements MemberDao {

	@Override
	public Member selectMemberOne(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberOne", memNo);
	}

	@Override
	public int deleteMember(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.update("member.deleteMember",memNo);
	}

	@Override
	public Member selectMemberNick(SqlSession session, String memNick) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberNick",memNick);
	}

	@Override
	public int updateMember(SqlSession session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateMember",m);
	}

	@Override
	public int insertMember(SqlSession session, Member m) {
		// TODO Auto-generated method stub
		return session.insert("member.insertMember",m);
	}

	//로그인
	@Override
	public Member selectOneMember(SqlSession session, String email) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectOneMember",email);
	}

	//이메일중복확인
	@Override
	public Member selectMemberEmail(SqlSession session, String email) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectMemberEmail",email);
	}

	@Override
	public int updateMemBuyCount(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		Map param=new HashMap();
		param.put("memNo",memNo);
		return session.update("member.updateMemBuyCount",param);
	}

	//가입할때 포인트적립
	@Override
	public int insertMemPoint(SqlSession session, Point p) {
		// TODO Auto-generated method stub
		return session.insert("member.insertMemPoint",p);
	}

	@Override
	public int updateMemberPw(SqlSession session, Member m) {
		// TODO Auto-generated method stub
		return session.update("member.updateMemberPw",m);
	}

	@Override
	public List<Alarm> selectAlarmList(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectList("member.selectAlarmAll",memNo);
	}
	
	@Override
	public int countAlarm(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.selectOne("member.countAlarm",memNo);
	}

	@Override
	public int insertAlarm(SqlSession session, Alarm a) {
		// TODO Auto-generated method stub
		return session.insert("member.insertAlarm",a);
	}
	
	@Override
	public int deleteAlarm(SqlSession session, String alarmNo) {
		// TODO Auto-generated method stub
		return session.delete("member.deleteAlarm",alarmNo);
	}

	@Override
	public int deleteAlarmAll(SqlSession session, String receiverNo) {
		// TODO Auto-generated method stub
		return session.delete("member.deleteAlarmAll",receiverNo);
	}

	@Override
	public Member selectSnsMem(SqlSession session, Member snsMem) {
		// TODO Auto-generated method stub
		return session.selectOne("member.selectSnsMem",snsMem);
	}

	@Override
	public int updateMemLastDate(SqlSession session, String memNo) {
		// TODO Auto-generated method stub
		return session.update("member.updateMemLastDate", memNo);
	}
	
	
	
}

package com.kh.bom.member.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.member.model.dao.MemberDao;
import com.kh.bom.member.model.vo.Alarm;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.point.model.dao.PointDao;
import com.kh.bom.point.model.vo.Point;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private SqlSession session;
	@Autowired
	private MemberDao dao;
	@Autowired
	private PointDao pointdao;
	
	@Override
	public Member selectMemberOne(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectMemberOne(session,memNo);
	}

	@Override
	public int deleteMember(String memNo) {
		// TODO Auto-generated method stub
		return dao.deleteMember(session,memNo);
	}

	@Override
	public Member selectMemberNick(String memNick) {
		// TODO Auto-generated method stub
		return dao.selectMemberNick(session, memNick);
	}

	@Override
	public int updateMember(Member m) {
		// TODO Auto-generated method stub
		return dao.updateMember(session,m);
	}
//회원가입시 포인트 적립
	@Override
	@Transactional
	public int insertMember(Member m,Point p)  {
		
		int result=dao.insertMember(session, m);
	
		if(result>0) {
			p.setMemNo(m.getMemNo());
			result=dao.insertMemPoint(session,p);
		}
		return result;
	}

//로그인
	@Override
	public Member selectOneMember(String email) {
		// TODO Auto-generated method stub
		return dao.selectOneMember(session,email);
	}

	@Override
	public Member selectMemberEmail(String email) {
		// TODO Auto-generated method stub
		return dao.selectMemberEmail(session, email);
	}

	@Override
	public int updateMemberPw(Member m) {
		// TODO Auto-generated method stub
		return dao.updateMemberPw(session, m);
	}

	@Override
	public List<Alarm> selectAlarmList(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectAlarmList(session,memNo);
	}
	
	@Override
	public int countAlarm(String memNo) {
		// TODO Auto-generated method stub
		return dao.countAlarm(session,memNo);
	}

	@Override
	public int insertAlarm(Alarm a) {
		// TODO Auto-generated method stub
		return dao.insertAlarm(session,a);
	}
	
	
	
}

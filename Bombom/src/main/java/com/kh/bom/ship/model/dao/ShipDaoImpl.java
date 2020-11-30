package com.kh.bom.ship.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.ship.model.vo.Ship;
@Repository
public class ShipDaoImpl implements ShipDao {

	@Override
	public List<Ship> selectShipList(SqlSession session,String memNo) {
		// TODO Auto-generated method stub
		return session.selectList("ship.selectShipList",memNo);
	}

	@Override
	public int insertShip(SqlSession session, Ship s) {
		// TODO Auto-generated method stub
		System.out.println(s);
		//기본배송지에 체크된 경우
		if(s.getShipYn()!=null) {
	         List<Ship> list=session.selectList("ship.selectShipList",s.getMemNo());
	         //회원번호로 배송지리스트가 있을경우에는 
	         if(list.size()>0) {
	            //기존 배송지  기본배송지여부 모두 N로 전환
	            int result=session.update("ship.updateShipYn",s.getMemNo());
	            //변경이 성공했을경우에만 인서트
	            if(result>0) return session.insert("ship.insertShip",s);
	            else return 0;
	         }else {
	            return session.insert("ship.insertShip",s);
	         }
	   }else {
	         
	      return session.insert("ship.insertShip",s);
	   }
	}

	
	@Override
	public int deleteShip(SqlSession session, String shipNo) {
		// TODO Auto-generated method stub
		return session.delete("ship.deleteShip",shipNo);
	}

	@Override
	public Ship selectShipOne(SqlSession session, String shipNo) {
		// TODO Auto-generated method stub
		return session.selectOne("ship.selectShipOne",shipNo);
	}

	@Override
	public int updateShip(SqlSession session, Ship s) {
		// TODO Auto-generated method stub
		if(s.getShipYn()!=null) {
			int result=session.update("ship.updateShipYn",s.getMemNo());
			if(result>0) return session.update("ship.updateShip",s);
			else return 0;
		}else {
			return session.update("ship.updateShip",s);
		}
		
	}
	
	
	
}

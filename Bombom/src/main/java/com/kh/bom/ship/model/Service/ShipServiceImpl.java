package com.kh.bom.ship.model.Service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.bom.ship.model.dao.ShipDao;
import com.kh.bom.ship.model.vo.Ship;
@Service
public class ShipServiceImpl implements ShipService {
	@Autowired
	SqlSession session;
	@Autowired
	ShipDao dao;
	
	@Override
	public List<Ship> selectShipList(String memNo) {
		// TODO Auto-generated method stub
		return dao.selectShipList(session,memNo);
	}

}

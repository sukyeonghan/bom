package com.kh.bom.ship.model.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.kh.bom.ship.model.vo.Ship;

public interface ShipDao {

	List<Ship> selectShipList(SqlSession session, String memNo);

	int insertShip(SqlSession session, Ship s);

	int deleteShip(SqlSession session, String shipNo);

	Ship selectShipOne(SqlSession session,String shipNo);

	int updateShip(SqlSession session, Ship s);

}

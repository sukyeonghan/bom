package com.kh.bom.ship.model.Service;

import java.util.List;

import com.kh.bom.ship.model.vo.Ship;

public interface ShipService {

	List<Ship> selectShipList(String memNo);

	int insertShip(Ship s);

}

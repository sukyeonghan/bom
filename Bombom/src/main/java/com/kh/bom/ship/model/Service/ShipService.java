package com.kh.bom.ship.model.Service;

import java.util.List;

import com.kh.bom.ship.model.vo.Ship;

public interface ShipService {
	//회원이가지고 있는 배송리스트 전체 불러오기
	List<Ship> selectShipList(String memNo);
	
	//배송지 추가
	int insertShip(Ship s);
	
	//배송지삭제
	int deleteShip(String shipNo);
	
	//배송지번호로 배송지정보 불러오기
	Ship selectShipOne(String shipNo);

	//배송지 업데이트
	int updateShip(Ship s);
	
	//기본배송지가 Y인 배송지 가져오기(order)
	Ship selectShipOneY(String memNo);

}

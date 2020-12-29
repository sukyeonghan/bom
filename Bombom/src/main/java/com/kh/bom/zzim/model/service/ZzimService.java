package com.kh.bom.zzim.model.service;

import java.util.List;
import java.util.Map;

import com.kh.bom.zzim.model.vo.Zzim;
import com.kh.bom.zzim.model.vo.ZzimContent;

public interface ZzimService {
	//찜 폴더 리스트 전체 불러오기
	List<Zzim> selectZzimList(String memNo);
	//찜 폴더 추가
	int insertZzim(Zzim z);
	//찜 상품 리스트 가져오기
	List<ZzimContent> selectZzimContentList(String zzimNo);
	//다중 찜 폴더 삭제
	int deleteZzim(List<String> zzimNoList);
	//가장 최근 찜 폴더 번호
	String selectSeqZzimNo();
	//찜 폴더 이름바꾸기
	int updateZzimName(Zzim zzim);
	//찜 폴더 하나 지우기
	int deleteZzimOne(String zzimNo);
	//찜 상품 다중 지우기
	int deleteZzimContent(List<String> pdtNoList);
	//찜 폴더 하나 가져오기
	Zzim selectZzimOne(String zzimNo);
	//찜 폴더 이동하기
	int updateZzimNo(Map map);

	//제품상세페이지 - 찜폴더 추가
	int proInsertZzim(Zzim z);
	
	//제품상세페이지 - 추가한 찜폴더에 제품추가
	int proInsertZzimContent(Map map);
	
	List selectfavlist(String zzimNo);


}

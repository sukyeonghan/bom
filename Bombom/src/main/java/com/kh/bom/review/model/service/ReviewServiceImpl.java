package com.kh.bom.review.model.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.order.model.vo.Order;
import com.kh.bom.point.model.dao.PointDao;
import com.kh.bom.point.model.vo.Point;
import com.kh.bom.product.model.dao.ProductDao;
import com.kh.bom.review.model.dao.ReviewDao;
import com.kh.bom.review.model.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {
	@Autowired
	private SqlSession session;
	@Autowired
	private ReviewDao dao;
	@Autowired
	private PointDao pointdao;
	@Autowired
	private ProductDao proDao;
	
	@Override
	public Order selectOrder(Map map) {
		return dao.selectOrder(session, map);
	}
	
	@Override
	//try문에서 에러떴을 때 rollback처리
	@Transactional(rollbackFor=Exception.class)
	public int insertReview(Review r) throws Exception{
		
		int result = 0;
		try {
			result =  dao.insertReview(session, r);

			String msg = "";
			int plus = 0;
		
			if(r.getRevImage()!=null) {
				msg="포토구매평 작성";
				plus=500;
			}else {
				msg="구매평 작성";
				plus=200;
			}
			Point p = new Point(r.getMemNo(),null,null,msg,plus);				
			result = pointdao.insertStampPoint(session, p);
	
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception();
		}
		return result;
	}

	@Override
	public int deleteRevivew(String revNo) {
		return dao.deleteRevivew(session, revNo);
	}

	@Override
	public int updateReview(Review r) {
		return dao.updateReview(session, r);
	}

	

	


}

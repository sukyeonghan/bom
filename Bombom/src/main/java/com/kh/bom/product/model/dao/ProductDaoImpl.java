package com.kh.bom.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.inquiry.model.vo.Inquiry;

@Repository
public class ProductDaoImpl implements ProductDao {

	@Override
	public List<Inquiry> inquiryList(SqlSession session, int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return session.selectList("inquiry.inquiryList",null,new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	@Override
	public int inquiryCount(SqlSession session) {
		return session.selectOne("inquiry.inquiryCount");
	}

	
	

}

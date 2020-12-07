package com.kh.bom.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.inquiry.model.vo.Inquiry;
import com.kh.bom.product.model.vo.Product;

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

	
	@Override
	public int productAllCount(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectOne("product.allCount");
	}
	@Override
	public int productCateCount(SqlSession session, String pdtCategory) {
		// TODO Auto-generated method stub
		return session.selectOne("product.cateCount",pdtCategory);
	}
	@Override
	public List<Product> selectProductList(SqlSession session) {
		// TODO Auto-generated method stub
		return session.selectList("product.allProductList");
	}
	@Override
	public List<Product> cateProductList(SqlSession session, String pdtCategory) {
		// TODO Auto-generated method stub
		return session.selectList("product.cateProductList",pdtCategory);
	}

}

package com.kh.bom.faq.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kh.bom.faq.model.vo.Faq;

@Repository
public class FaqDaoImpl implements FaqDao {

	@Override
	public List<Faq> selectFaqList(SqlSession session,int cPage,int numPerpage,String category) {
		// TODO Auto-generated method stub
		Map<String,String> param=new HashMap();
		param.put("category", category);
		return session.selectList("faq.selectFaqList",param,new RowBounds((cPage-1)*numPerpage,numPerpage));
	}

	
	
	@Override
	public int selectFaqCount(SqlSession session,String category) {
		// TODO Auto-generated method stub
		Map<String,String> param=new HashMap();
		param.put("category", category);
		return session.selectOne("faq.selectFaqCount",param);
	}



	@Override
	public int insertFaq(SqlSession session, Faq f) {
		// TODO Auto-generated method stub
		return session.insert("faq.insertFaq",f);
	}


	@Override
	public int deleteFaq(SqlSession session, String faqNo) {
		// TODO Auto-generated method stub
		return session.delete("faq.deleteFaq",faqNo);
	}

	@Override
	public Faq selectFaqOne(SqlSession session, String faqNo) {
		// TODO Auto-generated method stub
		return session.selectOne("faq.selectFaqOne",faqNo);
	}

	@Override
	public int updateFaq(SqlSession session, Faq f) {
		// TODO Auto-generated method stub
		return session.update("faq.updateFaq",f);
	}
	
	
	
}
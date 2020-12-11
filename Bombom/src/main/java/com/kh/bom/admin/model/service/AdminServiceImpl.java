package com.kh.bom.admin.model.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.admin.model.dao.AdminDao;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.product.model.vo.Product;
import com.kh.bom.product.model.vo.ProductOption;
import com.kh.bom.product.model.vo.ProductThumb;
import com.kh.bom.qna.model.vo.Qna;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private SqlSession session;
	@Autowired
	private AdminDao dao;

	@Override
	public List<Event> selectEvent() {
		return dao.selectEvent(session);
	}

	@Override
	public List<Event> selectEventSort(String sort) {
		return dao.selectEventSort(session, sort);
	}

	@Override
	public Event selectEvent(String eventNo) {
		return dao.selectEvent(session, eventNo);
	}

	@Override
	public int eventDelete(String eventNo) {
		return dao.eventDelete(session, eventNo);
	}

	@Override
	public int insertEvent(Event e) {
		return dao.insertEvent(session, e);
	}
	
	@Override
	public int updateEvent(Event e) {
		return dao.updateEvent(session, e);
	}
	
	//제품목록 출력
	@Override
	public List<Product> selectProductList(int cPage,int numPerPage,String sort) {
		
		return dao.selectProductList(session,cPage,numPerPage,sort);
	}
	//카테고리별 목록 출력
	@Override
	public int countProduct(String category) {
		// TODO Auto-generated method stub
		return dao.countProduct(session,category);
	}
	//제품 선택 삭제
	@Override
	public int deleteSelectProduct(List<String> delnum) {
		// TODO Auto-generated method stub
		int result=0;
		String no="";
		
		/*
		 * String path=((HttpSession)
		 * session).getServletContext().getRealPath("/resources/upload/product"); File
		 * file=new File(path);
		 */
		
		for(int i=0; i<delnum.size(); i++) {
			no=delnum.get(i);
			result=dao.deleteProduct(session,no);
			/*if(result>0) {
				//제품 삭제하면 해당 제품사진도 같이 삭제하기
				
				 * if(file.exists()) { if(file.delete()) { result=dao.deletePicture(no); } }
				
			} */
		}
		return result;
	}
	//제품 하나 삭제
	@Override
	public int deleteOneProduct(String pdtNo) {
		// TODO Auto-generated method stub
		
		return dao.deleteProduct(session, pdtNo);
	}
	//제품등록
	@Override
	@Transactional
	public int insertProduct(Product p,ProductOption o,List<Map<Object,Object>> options, List<ProductThumb> list) {
		//트랜잭션 처리하기
		int result=dao.insertProduct(session,p);
		if(result>0) {
			
			for(int i=0;i<options.size(); i++) {
				
				o.setPdtNo(p.getPdtNo());
				o.setPdtOptionContent((String)(options.get(i).get("pdtOptionContent")));
				o.setPdtOptionAddprice(Integer.parseInt((String)(options.get(i).get("pdtOptionAddprice"))));
				result=dao.insertOption(session, o);
			}
			
			if(result>0) {
					if(list!=null) {
					for(ProductThumb th : list) {
						th.setPdtNo(p.getPdtNo());
						result=dao.insertThumb(session,th);
					}
				}
			}
			
		}
		return result;
	}
	//제품 하나 선택
	@Override
	public Product selectOneProduct(String pdtNo) {
		return dao.selectOneProduct(session,pdtNo);
	}
	//옵션 선택
	@Override
	public List<ProductOption> selectOption(String pdtNo) {
		return dao.selectOption(session,pdtNo);
	}
	//썸네일 선택
	@Override
	public List<ProductThumb> selectThumb(String pdtNo) {
		return dao.selectThumb(session,pdtNo);
	}
	//제품 수정
	@Override
	@Transactional
	public int updateProduct(Product p, ProductOption o, List<Map<Object, Object>> options,
			List<ProductThumb> list) {
	
		int result=dao.updateProduct(session,p);
		//제품 업데이트 하면 옵션 업데이트
		if(result>0) {
			System.out.println(options);
			if(options.size()!=0) {
				Product check=dao.checkOption(session,p.getPdtNo());
				if(check.getPdtOptionNo()!=null) {
					//이전에 있던 옵션 지우기
					result=dao.deleteOption(session,p.getPdtNo());
					System.out.println("delete결과"+result);
				}
				//지우고 다시 insert
				for(int i=0;i<options.size(); i++) {
					
					o.setPdtNo(p.getPdtNo());
					o.setPdtOptionContent((String)(options.get(i).get("pdtOptionContent")));
					o.setPdtOptionAddprice(Integer.parseInt((String)(options.get(i).get("pdtOptionAddprice"))));
					result=dao.insertOption(session, o);
					System.out.println("insert결과"+result);
				}
	
			}
			//옵션 업데이트하면 썸네일 업데이트
			if(result>0) {
				
				if(list.size()!=0) {
					//이전에 있던 썸네일 지우기
					result=dao.deleteThumb(session,p.getPdtNo());
			
					//지운 후 다시 insert
					for(ProductThumb th : list) {
						th.setPdtNo(p.getPdtNo());
						result=dao.insertThumb(session,th);
					
					}
				}
			}
			
		}
		return result;
	}
	//회원관리
	//관리자권한 변경
	@Override
	public int updateManagerYn(Member m) {
		// TODO Auto-generated method stub
		return dao.updateManagerYn(session,m);
	}
	//회원리스트
	@Override
	public List<Member> selectMemberList(int cPage, int numPerpage, Map map) {
		// TODO Auto-generated method stub
		return dao.selectMemberList(session,cPage, numPerpage, map);
	}
	//회원수
	@Override
	public int selectMemberCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.selectMemberCount(session,map);
	}
	//검색어자동완성
	@Override
	public List<Member> memberAutoComplete(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.memberAutoComplete(session,map);
	}
	
	//qna
	@Override
	public List<Qna> selectQnaList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectQnaList(session, cPage, numPerpage);
	}

	@Override
	public int selectQnaCount() {
		// TODO Auto-generated method stub
		return dao.selectQnaCount(session);
	}

	@Override
	public int insertQnaAnswer(Qna q) {
		// TODO Auto-generated method stub
		return dao.insertQnaAnswer(session, q);
	}

	@Override
	public int deleteQna(String qnaNo) {
		// TODO Auto-generated method stub
		return dao.deleteQna(session,qnaNo);
	}

	@Override
	public List<Qna> selectQnaWaitList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectQnaWaitList(session,cPage,numPerpage);
	}
	
	
	

}

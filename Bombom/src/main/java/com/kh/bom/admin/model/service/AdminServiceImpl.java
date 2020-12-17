package com.kh.bom.admin.model.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.bom.admin.model.dao.AdminDao;
import com.kh.bom.admin.model.vo.Event;
import com.kh.bom.admin.model.vo.MainBanner;
import com.kh.bom.member.model.vo.Member;
import com.kh.bom.order.model.vo.Order;
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

	// 제품목록 출력
	@Override
	public List<Product> selectProductList(int cPage, int numPerPage, String sort) {

		return dao.selectProductList(session, cPage, numPerPage, sort);
	}
	//제품 검색 목록
	@Override
	public List<Product> selectSearchList(int cPage, int numPerPage, Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.selectSearchList(session,cPage,numPerPage,map);
	}

	//제품 개수
	@Override
	public int countProduct(String category) {
		// TODO Auto-generated method stub
		return dao.countProduct(session, category);
	}
	//검색별 개수
	@Override
	public int countProduct(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.countProduct(session, map);
	}

	// 제품 선택 삭제
	@Override
	@Transactional
	public int deleteSelectProduct(List<String> delnum,String path) {
		// TODO Auto-generated method stub
		int result = 0;
		String pdtNo = "";
		int fileResult=0;
		int fileResult2=0;
		String thumb="";
		

		for (int i = 0; i < delnum.size(); i++) {
			pdtNo = delnum.get(i);
			//상세이미지 삭제
			 Product p=dao.selectOneProduct(session,pdtNo);
			 System.out.println(p.getPdtDetailImage());
			 File dfile=new File(path+"/"+p.getPdtDetailImage());
			 if(dfile.exists()) {
				 dfile.delete();
				 fileResult=1;
			 }
			 //썸네일 삭제
			 List<ProductThumb> thumbs=dao.selectThumb(session, pdtNo);

			 for(ProductThumb th:thumbs) {
					thumb=th.getPdtThumbImage();
					
					File tfile=new File(path+"/"+thumb);
					if(tfile.exists()) {
						tfile.delete();
						fileResult2=1;
					}
			 }
			 
			if(fileResult==1 && fileResult2==1) {
				result = dao.deleteProduct(session, pdtNo);
			}

		}
		return result;
	}

	//제품 하나 삭제-upload 폴더에 저장되어있는 사진도 같이 삭제 
	@Override
	@Transactional
	public int deleteOneProduct(String pdtNo,String path) {
		
		int fileResult=0;
		int fileResult2=0;
		String thumb="";
		int result=0;
		
		 //상세이미지 삭제
		 Product p=dao.selectOneProduct(session,pdtNo);
		 
		 File dfile=new File(path+"/"+p.getPdtDetailImage());
		 if(dfile.exists()) {
			 dfile.delete();
			 fileResult=1;

		 }
		 //썸네일 이미지 삭제
		 List<ProductThumb> thumbs=dao.selectThumb(session, pdtNo);

		 for(ProductThumb th:thumbs) {
				thumb=th.getPdtThumbImage();
				
				File tfile=new File(path+"/"+thumb);
				if(tfile.exists()) {
					tfile.delete();
					fileResult2=1;
				}
		 }

		if(fileResult==1 && fileResult2==1) {
			result=dao.deleteProduct(session, pdtNo);

		}
			
		return result;
	}

	// 제품등록
	@Override
	@Transactional
	public int insertProduct(Product p, ProductOption o, List<Map<Object, Object>> options, List<ProductThumb> list) {
		// 트랜잭션 처리하기
		int result = dao.insertProduct(session, p);
		if (result > 0) {
			if(options!=null) {
				for (int i = 0; i < options.size(); i++) {
	
					o.setPdtNo(p.getPdtNo());
					o.setPdtOptionContent((String) (options.get(i).get("pdtOptionContent")));
					o.setPdtOptionAddprice(Integer.parseInt((String) (options.get(i).get("pdtOptionAddprice"))));
					result = dao.insertOption(session, o);
				}
			}
			if (result > 0) {
				if (list != null) {
					for (ProductThumb th : list) {
						th.setPdtNo(p.getPdtNo());
						result = dao.insertThumb(session, th);
					}
				}
			}

		}
		return result;
	}

	// 제품 하나 선택
	@Override
	public Product selectOneProduct(String pdtNo) {
		return dao.selectOneProduct(session, pdtNo);
	}

	// 옵션 선택
	@Override
	public List<ProductOption> selectOption(String pdtNo) {
		return dao.selectOption(session, pdtNo);
	}

	// 썸네일 선택
	@Override
	public List<ProductThumb> selectThumb(String pdtNo) {
		return dao.selectThumb(session, pdtNo);
	}

	// 제품 수정
	@Override
	@Transactional
	public int updateProduct(Product p, ProductOption o, List<Map<Object, Object>> options, List<ProductThumb> list) {

		int result = dao.updateProduct(session, p);
		// 제품 업데이트 하면 옵션 업데이트
		if (result > 0) {
			System.out.println(options);
			if (options!=null && options.size() != 0) {
				Product check = dao.checkOption(session, p.getPdtNo());
				if (check.getPdtOptionNo() != null) {
					// 이전에 있던 옵션 지우기
					result = dao.deleteOption(session, p.getPdtNo());
					System.out.println("delete결과" + result);
				}
				// 지우고 다시 insert
				for (int i = 0; i < options.size(); i++) {

					o.setPdtNo(p.getPdtNo());
					o.setPdtOptionContent((String) (options.get(i).get("pdtOptionContent")));
					o.setPdtOptionAddprice(Integer.parseInt((String) (options.get(i).get("pdtOptionAddprice"))));
					result = dao.insertOption(session, o);
					System.out.println("insert결과" + result);
				}

			}
			// 옵션 업데이트하면 썸네일 업데이트
			if (result > 0) {

				if (list.size() != 0) {
					// 이전에 있던 썸네일 지우기
					result = dao.deleteThumb(session, p.getPdtNo());

					// 지운 후 다시 insert
					for (ProductThumb th : list) {
						th.setPdtNo(p.getPdtNo());
						result = dao.insertThumb(session, th);

					}
				}
			}

		}
		return result;
	}

	// 제품명 중복 확인
	@Override
	public int selectPdtName(String pdtName) {
		// TODO Auto-generated method stub
		return dao.selectPdtName(session, pdtName);
	}

	// 제품명 중복 확인-수정페이지
	@Override
	public int selectPdtName(String pdtName, String pdtNo) {
		// TODO Auto-generated method stub
		return dao.selectPdtName(session, pdtName, pdtNo);
	}
	//옵션 삭제
	@Override
	public int deleteOption(String pdtNo) {
		// TODO Auto-generated method stub
		return dao.deleteOption(session, pdtNo);
	}
	//옵션 상태 수정
	@Override
	public int updateOptStatus(String status,String pdtNo) {
		// TODO Auto-generated method stub
		return dao.updateOptStatus(session,status,pdtNo);
	}
	
	// 회원관리
	// 관리자권한 변경
	@Override
	public int updateManagerYn(Member m) {
		// TODO Auto-generated method stub
		return dao.updateManagerYn(session, m);
	}

	// 회원리스트
	@Override
	public List<Member> selectMemberList(int cPage, int numPerpage, Map map) {
		// TODO Auto-generated method stub
		return dao.selectMemberList(session, cPage, numPerpage, map);
	}

	// 회원수
	@Override
	public int selectMemberCount(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.selectMemberCount(session, map);
	}

	// 검색어자동완성
	@Override
	public List<Member> memberAutoComplete(Map<String, String> map) {
		// TODO Auto-generated method stub
		return dao.memberAutoComplete(session, map);
	}

	// qna
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

	// 메인배너리스트 가져오기
	@Override
	public List<MainBanner> selectBannerList() {
		return dao.selectBannerList(session);
	}
	//배너등록하기
	@Override
	public int insertBanner(MainBanner mb) {
		return dao.insertBanner(session, mb);
	}

	// 배너등록에 필요한 product목록
	@Override
	public List<Product> selectProductList() {
		return dao.selectProductList(session);
	}
	//배너삭제하기
	@Override
	public int deleteBanner(String no) {
		return dao.deleteBanner(session, no);
	}

	// 배너한개 가져오기
	@Override
	public MainBanner selectBannerOne(String no) {
		return dao.selectBannerOne(session, no);
	}
	//배너 수정하기
	@Override
	public int updateBanner(MainBanner mb) {
		return dao.updateBanner(session,mb);
	}

	@Override
	public int deleteQna(String qnaNo) {
		// TODO Auto-generated method stub
		return dao.deleteQna(session, qnaNo);
	}

	@Override
	public List<Qna> selectQnaWaitList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectQnaWaitList(session, cPage, numPerpage);
	}

	@Override
	public List<Order> selectOrderList(int cPage, int numPerpage) {
		// TODO Auto-generated method stub
		return dao.selectOrderList(session, cPage, numPerpage);
	}

	@Override
	public int selectOrderCount() {
		// TODO Auto-generated method stub
		return dao.selectOrderCount(session);
	}

	@Override
	public List<Order> selectOrderDetail(String orderNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderDetail(session, orderNo);
	}

	@Override
	public Order selectOrderOne(String orderNo) {
		// TODO Auto-generated method stub
		return dao.selectOrderOne(session, orderNo);
	}

	@Override
	public int orderShipUpdate(Order o) {
		// TODO Auto-generated method stub
		return dao.orderShipUpdate(session, o);
	}
	
	

	
	
}

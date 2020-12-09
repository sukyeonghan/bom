package com.kh.bom.common.page;

public class PageBarFactory {
	
	public static String getPageBar(int totalData, int cPage,int numPerpage, String uri) {
		//totalData 전체데이터수, cPage 현재페이지, numPerpage 한페이지데이터수, uri 요청주소
		
		String pageBar="";
		
		int pageBarSize=5;
		
		//전체페이지수=전체데이터수/한페이지당 데이터수
		int totalPage=(int)Math.ceil((double)totalData/numPerpage); 
		//페이지바시작번호 
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		//페이지바마지막번호
		int pageEnd=pageNo+pageBarSize-1;
		
		pageBar+="<ul class='pagination justify-content-center pagination-sm'>";
		
		if(pageNo==1) {
			//페이지번호가 1일때는 이전버튼이 선택되지 않도록 함
			pageBar+="<li class='page-item disabled'>";
			pageBar+="<a class='page-link' href='#'>이전</a>";
			pageBar+="</li>";
		}else {
			//페이지번호가 1이 아닐경우에는 이전버튼 선택시 (현재페이지-1)한 페이지수로 이동.
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' href='javascript:fn_paging("+(pageNo-1)+")'>이전</a>";
			pageBar+="</li>";
		}
		
		//이전버튼, 다음버튼 사이의 페이지 번호
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			
			if(pageNo==cPage) { 
				//현재페이지가 페이지넘버와 같을경우 눌리지 마라
				pageBar+="<li class='page-item active'>";
				pageBar+="<a class='page-link' href='#'>"+pageNo+"</a>";
				pageBar+="</li>";
			}else {
				//현재페이지랑 다른 페이지넘버를 선택할경우 그 페이지넙버로 이동
				pageBar+="<li class='page-item'>";
				pageBar+="<a class='page-link' href='javascript:fn_paging("+(pageNo)+")'>"+pageNo+"</a>";
				pageBar+="</li>";
			}
			pageNo++;
		}
		
		//페이지번호가 전체페이지수보다 클경우
		if(pageNo>totalPage) {
			//다음선택불가
			pageBar+="<li class='page-item disabled'>";
			pageBar+="<a class='page-link' href='#'>다음</a>";
			pageBar+="</li>";
		}else {
			//아닐경우 다음페이지시 다음페이지로이동(위에서 pageNo++해야지만 넘어오기에 pageNo로 이동하면 됨)
			pageBar+="<li class='page-item'>";
			pageBar+="<a class='page-link' href='javascript:fn_paging("+(pageNo)+")'>다음</a>";
			pageBar+="</li>";
		}
		
		pageBar+="</ul>";
		
		pageBar+="<script>";
		pageBar+="function fn_paging(cPage){";
		pageBar+="location.href='"+uri+"?cPage='+cPage;";
		
		pageBar+="}";
		pageBar+="</script>";
		
		return pageBar;
	}

}

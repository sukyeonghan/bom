package com.kh.bom.common.page;

public class MypageAjaxPageBarFactory {
	
	public static String getAjaxPageBar(int totalData,int cPage,int numPerpage,String url) {

		String pageBar="";
		
		int pageBarSize=5;
		
		//전체페이지수=전체데이터수/한페이지당 데이터수
		int totalPage=(int)Math.ceil((double)totalData/numPerpage); 
		//페이지바시작번호 
		int pageNo=((cPage-1)/pageBarSize)*pageBarSize+1;
		//페이지바 마지막번호
		int pageEnd=pageNo+pageBarSize-1;
		
		
		if(pageNo==1) {
			//페이지번호가 1일때는 이전버튼이 선택되지 않도록 함
			pageBar+="<a class='w3-button disabled' href='#'> << </a>";
		}else {
			//페이지번호가 1이 아닐경우에는 이전버튼 선택시 (현재페이지-1)한 페이지수로 이동.
			pageBar+="<a class='w3-button' href=\"javascript:fn_paging("+(pageNo-1)+")'> << </a>";
		}
		
		//이전버튼, 다음버튼 사이의 페이지 번호
		while(!(pageNo>pageEnd||pageNo>totalPage)) {
			
			if(pageNo==cPage) { 
				//현재페이지가 페이지넘버와 같을경우 눌리지 마라
				pageBar+="<a class='w3-button w3-green' href='#'>"+pageNo+"</a>";
			}else {
				//현재페이지랑 다른 페이지넘버를 선택할경우 그 페이지넙버로 이동
				pageBar+="<a class='w3-button' href=\"javascript:fn_paging("+pageNo+")\">"+pageNo+"</a>";
			}
			pageNo++;
		}
		
		//페이지번호가 전체페이지수보다 클경우
		if(pageNo>totalPage) {
			//다음선택불가
			pageBar+="<a class='w3-button disabled' href='#'> >> </a>";
		}else {
			//아닐경우 다음페이지시 다음페이지로이동(위에서 pageNo++해야지만 넘어오기에 pageNo로 이동하면 됨)
			pageBar+="<a class='w3-button' href=\"javascript:fn_paging("+pageNo+")\"> >> </a>";
		}
		
		pageBar+="<script>";

		pageBar+="function fn_paging(cPage){";
		pageBar+="$.ajax({";
		pageBar+="url:'"+url+"',";
		pageBar+="data:{cPage:cPage,numPerpage:5},";
		pageBar+="type:'get',";
		pageBar+="success:data=>{";
		//pageBar+="console.log(data);";
					
		pageBar+="document.getElementById('result').innerHTML=data";
		pageBar+="}";	
		pageBar+="});";
		
		pageBar+="};";
		pageBar+="</script>";
		
		return pageBar;
	}	
}

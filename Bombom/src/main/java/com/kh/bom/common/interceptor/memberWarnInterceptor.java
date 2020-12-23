package com.kh.bom.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.bom.member.model.vo.Member;

public class memberWarnInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response,Object handler)
	      throws Exception{
		
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
		
		if(loginMember.getMemWarnCount() >= 10 ){
			request.setAttribute("msg","활동이 차단되셨습니다. 관리자에게 문의하여 주세요");
			request.setAttribute("loc","/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request,response);
		    return false;
		}else {
			return super.preHandle(request,response,handler);
		}
	}

}

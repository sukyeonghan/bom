package com.kh.bom.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.bom.member.model.vo.Member;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session=request.getSession();
		Member loginMember=(Member)session.getAttribute("loginMember");
	
		if(loginMember==null|| loginMember.getMemManagerYn().equals("N")) {
			request.setAttribute("msg", "운영자만 이용이 가능합니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			return false;
		}else {
			return super.preHandle(request, response, handler);
		}
	}

	
		
}

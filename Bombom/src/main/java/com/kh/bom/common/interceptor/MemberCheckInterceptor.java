package com.kh.bom.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.bom.member.model.vo.Member;

public class MemberCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member loginMember = (Member)session.getAttribute("loginMember");
		if(loginMember == null || loginMember.getMemEmail().equals(loginMember.getMemEmail()) ) {
			request.setAttribute("msg", "잘못된 접근입니다. 다시 로그인해주세요");
			request.setAttribute("loc", "/");
			request.setAttribute("icon", "error");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			return false;
		}else {
			return super.preHandle(request, response, handler);
		}
	}
	
}

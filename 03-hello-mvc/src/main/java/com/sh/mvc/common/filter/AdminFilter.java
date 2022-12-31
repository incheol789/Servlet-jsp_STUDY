package com.sh.mvc.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sh.mvc.member.model.dto.Member;
import com.sh.mvc.member.model.dto.MemberRole;

@WebFilter("/admin/*")
public class AdminFilter extends HttpFilter implements Filter {
       
    
    public void AdminFilter() {
    	
    }
    
    public void destroy() {
    	
    }

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpReq = (HttpServletRequest) request;
		HttpServletResponse httpRes = (HttpServletResponse) response;
		
		HttpSession session = httpReq.getSession();
		Member loginMember = (Member) session.getAttribute("loginMember");
		
		if(loginMember == null || loginMember.getMemberRole() != MemberRole.A) {
			session.setAttribute("msg", "관리자만 접속할 수 있는 페이지입니다.");
			httpRes.sendRedirect(httpReq.getContextPath() + "/");
			return;
		}
		
	
		
		chain.doFilter(request, response);
	}
	

	public void init(FilterConfig fConfig) throws ServletException {
	}

}
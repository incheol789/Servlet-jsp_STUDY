package com.sh.mvc.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpFilter;


@WebFilter(value="/*", initParams={
		@WebInitParam(name="encodingType", value="utf-8")
})
// @WebFilter("/*") // value속성은 속성명 생략이 가능하다.
public class EncodingFilter extends HttpFilter implements Filter {
     
	String encodingType;

	
	public void destroy() {
		// TODO Auto-generated method stub
	}

	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		request.setCharacterEncoding(encodingType);
		System.out.println("[" + encodingType + "] 인코딩 처리!");
		
		
		chain.doFilter(request, response);
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		this.encodingType = fConfig.getInitParameter("encodingType");
	}

}

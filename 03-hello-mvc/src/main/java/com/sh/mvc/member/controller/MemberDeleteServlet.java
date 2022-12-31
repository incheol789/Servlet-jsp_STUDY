package com.sh.mvc.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sh.mvc.member.model.dto.Member;
import com.sh.mvc.member.model.service.MemberService;


@WebServlet("/member/memberDelete")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 1. 사용자 입력값 가져오기
		String memberId = request.getParameter("memberId");
		Member loginMember = (Member) session.getAttribute("memberId");
		
		// 2. 업무 로직
		int result = memberService.deleteMember(memberId);
		if(result > 0) {
			// 회원 탈퇴에 성공한 경우
			session.setAttribute("msg", memberId + "회원 탈퇴 성공");
			response.sendRedirect(request.getContextPath() + "/member/logout");
		} 
		else {
			// 회원 탈퇴에 실패한 경우
			session.setAttribute("msg", memberId + "회원 탈퇴 실패");
			request.getRequestDispatcher("views/common/memberView.jsp")
				.forward(request, response);


		// 3. view단 처리  - /member/memberView
//			response.sendRedirect(request.getContextPath() + "/");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

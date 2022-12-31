package com.sh.mvc.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sh.mvc.member.model.service.MemberService;


@WebServlet("/admin/updateMemberRole")
public class AdminUpdateMemberRoleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		try {
			// 1. 사용자 입력값
			String memberId = request.getParameter("memberId");
			String memberRole = request.getParameter("memberRole");
			System.out.println("memberId = " + memberId);
			System.out.println("memberRole = " + memberRole);
			
			// 2. 업무로직 - DB 해당회원 권한 수정
			int result = memberService.updateMemberRole(memberId, memberRole);
			
			// 2.5 사용자메세지 전송
//			String msg = result > 0 ? "회원 권한 수정 완료!" : "회원 변경 실패!";
			session.setAttribute("msg", "회원권한을 성공적으로 변경했습니다.");
			
		} catch (Exception e) {
			session.setAttribute("msg", "회원권한 변경 중 오류가 발생했습니다.");
			e.printStackTrace();
		}
		
		
		// 3. 리다이렉트 - url 변경
		response.sendRedirect(request.getContextPath() + "/admin/memberList");
		
	}

}

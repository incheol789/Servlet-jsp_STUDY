package com.sh.mvc.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.mvc.board.model.service.BoardService;


@WebServlet("/board/boardCommentDelete")
public class BoardCommentDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		// 사용자 입력값
		int no = Integer.parseInt(request.getParameter("no"));
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		
		// 업무 로직
		int result = boardService.deleteBoardComment(no);
		
		String msg = result > 0 ? "댓글 삭제 성공" : "댓글 삭제 실패";
		
		// 리다이렉트
		request.getSession().setAttribute("msg", msg);
		response.sendRedirect(request.getContextPath() + "/board/boardView?no=" + boardNo);
	}

}

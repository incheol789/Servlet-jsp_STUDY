package com.sh.mvc.board.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sh.mvc.board.model.dto.BoardComment;
import com.sh.mvc.board.model.service.BoardService;

/**
 * Servlet implementation class BoardCommentEnrollServlet
 */
@WebServlet("/board/boardCommentEnroll")
public class BoardCommentEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BoardService boardService = new BoardService();

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 사용자입력값처리
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		String writer = request.getParameter("writer");
		String content = request.getParameter("content");
		int commentLevel = Integer.parseInt(request.getParameter("commentLevel"));
		int commentRef = Integer.parseInt(request.getParameter("commentRef"));
		BoardComment bc = new BoardComment(0, commentLevel, writer, content, boardNo, commentRef, null);
		System.out.println(bc);
		
		// 2. 업무로직 - board_comment 행추가
		// dao에서 comment_ref컬럼값 세팅시, setObject를 사용해서 0이면 null을 대입할수 있도록 한다.
		int result = boardService.insertBoardComment(bc);
		
		// 3. 리다이렉트 /board/boardView
		response.sendRedirect(request.getContextPath() + "/board/boardView?no=" + boardNo);
	}

}

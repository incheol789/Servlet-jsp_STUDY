<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%-- jsp 주석 --%>
<%-- 
	지시어 (directive)
	<%@ page %> 기본설정
	<%@ include %> 다른 페이지를 포함하는 설정
	<%@ taglib %> jsp tag 사용선언
	
	자바코드
	<% %> scriptlet 
	<%= %> 출력식
	
	jsp는 servlet으로 변환되서 처리된다. 
	지역서버하위에 work\Catalina\localhost\web\org\apache\jsp\에서 변환
	
 --%>
<%
	// 자바영역
	// 1 ~ 10 합구하기
	int sum = 0;
	for(int i = 1; i <= 10; i++){
		sum += i;
	}
	System.out.println("sum = " + sum);
	
	int num = (int)(Math.random() * 10) + 1;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Basics</title>
<script>
	const num = <%= num %>;
	
	window.onload = () => {
		let sum = 0;
		for(let i = 1; i <= 10; i++)
			sum += i;
		document.querySelector("#sum").innerHTML = sum;
		
		document.querySelector("#now").innerHTML = Date.now();
	};
</script>
</head>
<body>
	<h1>JSP Basics</h1>
	<h2>ㅋㅋㅋ</h2>
	<%-- jsp 주석 --%>
	<!-- html 주석 -->
	<ul>
		<li>Server Side : <span><%-- <%= sum %> --%></span></li>
		<li>Client Side : <span id="sum"></span></li>
	</ul>
	<ul>
<%
	//long millis = new Date().getTime();
	long millis = System.currentTimeMillis();
	System.out.println("millis = " + millis);
%>
		<li>Server Side : <span><%= millis %></span></li>   
		<li>Client Side : <span id="now"></span></li>
	</ul>
	
	<h2>분기처리</h2>
<%	if(num % 2 == 0) { %>
	<p><%= num %>은 짝수입니다.</p>
<% 	}else { %>
	<p><%= num %>은 홀수입니다.</p>
<%	}  %>

	<%-- mode=en | ko | num --%>
<%
	String mode = request.getParameter("mode");
	System.out.println("mode = " + mode);
	
	if("en".equals(mode)){
%>
		<p>abcdefg</p>
<%	
	}
	else if("ko".equals(mode)){
%>
		<p>가나다라마바사</p>
<%
	}
	else if("num".equals(mode)){
%>
		<p>1234567890</p>	
<%		
	}
%>
	
	<h2>반복처리</h2>
	<ul>
<%
	String[] names = {"홍길동", "신사임당", "이순신"};

	for(int i = 0; i < names.length; i++){
%>
		<li><%= names[i] %></li>
<%
	}
%>
	</ul>
	
	
	<ol>
<%
	List<String> webLangs = new ArrayList<>();
	webLangs.add("html");
	webLangs.add("css");
	webLangs.add("javascript");
	
	for(int i = 0; i < webLangs.size(); i++){
%>
		<li><%= webLangs.get(i) %></li>
<%		
	}
%>
	</ol>
	
	<%-- 
		@실습문제 : no, prod, option값 테이블태그 
	--%>
	<%
	String no = request.getParameter("no");
	String prod = request.getParameter("prod");
	String[] option = request.getParameterValues("option");
	%>
	<h2>실습문제</h2>
	<table border = "3" width = "400" height = "300">
		<tr align="center">
			<th>주문번호</th>
			<td><%= no %></td>
		</tr>
		<tr align="center">
			<th>상품명</th>
			<td><%= prod %></td>
		</tr>
	<% for(int i = 1; i < option.length; i++) { %>
		<tr align="center">
			<th>옵션<%= i + 1 %></th>
			<td><%= option[i] %></td>
		</tr>
	<% } %>
	</table>
</body>
</html>





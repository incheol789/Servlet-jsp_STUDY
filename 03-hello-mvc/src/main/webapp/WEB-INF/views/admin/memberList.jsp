<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<!-- 관리자용 admin.css link -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/admin.css" />

<style>
div#search-container {width: 100%; margin:0 0 10px 0; padding:3px; background-color: rgba(0, 188, 212, 0.3);}
div#search-memberId {display: inline-block;}
div#search-memberName{display:none;}
div#search-gender{display:none;}
</style>
<script>
window.addEventListener('load', () => {
	document.querySelector("#searchType").addEventListener('change', (e) => {
		console.log(e.target.value); // member_id, member_name, gender
		
		// 모두 숨김
		document.querySelectorAll(".search-type").forEach((div) => {
			div.style.display = "none";
		});
		
		// 현재 선택된 값에 상응하는 div만 노출
		let id;
		switch(e.target.value){
		case "member_id" : id ="search-memberId"; break;
		case "member_name" : id ="search-memberName"; break;
		case "gender" : id ="search-gender"; break;
		}
		
		document.querySelector("#" + id).style.display = "inline-block";
	});
});
</script>
<section id="memberList-container">
	<h2>회원관리</h2>
	<div id="search-container">
        <label for="searchType">검색타입 :</label> 
        <select id="searchType">
            <option value="member_id">아이디</option>        
            <option value="member_name">회원명</option>
            <option value="gender">성별</option>
        </select>
        <div id="search-memberId" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_id"/>
                <input type="text" name="searchKeyword"  size="25" placeholder="검색할 아이디를 입력하세요."/>
                <button type="submit">검색</button>            
            </form>    
        </div>
        <div id="search-memberName" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="member_name"/>
                <input type="text" name="searchKeyword" size="25" placeholder="검색할 이름을 입력하세요."/>
                <button type="submit">검색</button>            
            </form>    
        </div>
        <div id="search-gender" class="search-type">
            <form action="<%=request.getContextPath()%>/admin/memberFinder">
                <input type="hidden" name="searchType" value="gender"/>
                <input type="radio" name="searchKeyword" value="M" checked> 남
                <input type="radio" name="searchKeyword" value="F"> 여
                <button type="submit">검색</button>
            </form>
        </div>
    </div>

	<table id="tbl-member">
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>회원권한</th>
				<th>성별</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>전화번호</th>
				<th>포인트</th>
				<th>취미</th>
				<th>가입일</th>
			</tr>
		</thead>
	<%
 List<Member> members = (List<Member>) request.getAttribute("members");
	%>
		<tbody>
		<% if(members.isEmpty()) { %>
			<tr>
				<td colspan="10">조회된 회원이 없습니다.</td>
			</tr>
		<% 
			} else { 
			 for(Member member : members) {
		%>
				<tr>
					<td><%= member.getMemberId() %></td>
					<td><%= member.getMemberName() %></td>
					<td>
						<select class="member-role" data-member-id="<%= member.getMemberId() %>"
													data-member-birthday="<%= member.getBirthday() %>">
							<option value="<%= MemberRole.U%>" <%= member.getMemberRole() == MemberRole.U ? "selected" : "" %>>일반사용자</option>
							<option value="<%= MemberRole.A%>" <%= member.getMemberRole() == MemberRole.A ? "selected" : "" %>>관리자</option>
						</select>
					</td>
					<td><%= member.getGender() != null ? member.getGender() : "" %></td>
					<td><%= member.getBirthday() != null ? member.getBirthday() : "" %></td>
					<td><%= member.getEmail() != null ? member.getBirthday() : "" %></td>
					<td><%= member.getPhone() %></td>
					<td><%= member.getPoint() %></td>
					<td><%= member.getHobby() != null ? member.getHobby() : "" %></td>
					<td><%= member.getEnrollDate() %></td>
				</tr>
		<%
			 }
		} 
		
		%>
		</tbody>
	</table>
</section>
<form action="<%= request.getContextPath() %>/admin/updateMemberRole" name="memberRoleUpdateFrm" method="POST">
	<input type="hidden" name="memberId" />
	<input type="hidden" name="memberRole" />
</form>
<script>
document.querySelectorAll(".member-role").forEach((select) => {
	select.addEventListener('change', (e) => {
		console.log(e.target.value);
		console.log(e.target.dataset.memberId);
		const memberId = e.target.dataset.memberId;
		const memberRole = e.target.value;
		
		// js template string문법 jsp에서 사용시 주의사항 : \${}이스케이핑 처리해야 한다.
		if(confirm(`[\${memberId}]회원의 권한을 \${memberRole}로 변경하시겠습니까?`)){
			const frm = document.memberRoleUpdateFrm;
			frm.memberId.value = memberId;
			frm.memberRole.value = memberRole;
			frm.submit();	
		}
		else {
			// e.target(select)하위의 selected 속성이 있는 option 태그
			e.target.querySelector("[selected]").selected = true;

		}
		
		
	});
});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>




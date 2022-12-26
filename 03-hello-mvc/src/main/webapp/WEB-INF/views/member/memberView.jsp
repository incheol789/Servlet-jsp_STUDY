<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<section id=enroll-container>
<%
	Member m=(Member)request.getAttribute("member");
	String[] hobby=m.getHobby().split(",");
	String[] checkedHobby=new String[5];
	for(String h : hobby){
		switch(h){
			case "운동" : checkedHobby[0]="checked";break;
			case "등산" : checkedHobby[1]="checked";break;
			case "독서" : checkedHobby[2]="checked";break;
			case "게임" : checkedHobby[3]="checked";break;
			case "여행" : checkedHobby[4]="checked";break;
		}
	}
%>
<script>

const fn_updateMember=()=>{
	const updateFrm=$("#memberFrm");
	updateFrm.attr("action","<%=request.getContextPath()%>/updateMember");
	updateFrm.submit();
	
}

</script>    

	<h2>회원 정보</h2>
	<form 
		name="memberEnrollFrm" 
		method="POST" 
		action="<%= request.getContextPath() %>/member/memberView">
		<table>
			<tr>
				<th>아이디<sup>*</sup></th>
				<td>
					<input type="text" name="memberId" id="memberId" value="<%= m.getMemberId() %>" readonly>
				</td>
			</tr>
			<tr>
				<th>이름<sup>*</sup></th>
				<td>	
				<input type="text"  name="memberName" id="memberName" value="<%= m.getMemberName()%>"required><br>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>	
				<input type="date" name="birthday" id="birthday" value="<%= m.getBirthday()%>"><br>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" placeholder="abc@xyz.com" name="email" id="email" value="<%= m.getEmail()%>"><br>
				</td>
			</tr>
			<tr>
				<th>휴대폰<sup>*</sup></th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" value="<%= m.getPhone()%>" required><br>
				</td>
			</tr>
			<tr>
				<th>포인트</th>
				<td>	
					<input type="text" placeholder="" name="point" id="point" value="<%= m.getPoint()%>" readonly><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>	
			       		 <input type="radio" name="gender" id="gender0" value="M" <%=m.getGender().equals("M")?"checked":"" %>>
						 <label for="gender0">남</label>
						 <input type="radio" name="gender" id="gender1" value="F" <%=m.getGender().equals("F")?"checked":"" %>>
						 <label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동" <%=m.getHobby().contains("운동")?"checked":"" %>>><label for="hobby0">운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산" <%=m.getHobby().contains("등산")?"checked":"" %>>><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서" <%=m.getHobby().contains("독서")?"checked":"" %>>><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임" <%=m.getHobby().contains("게임")?"checked":"" %>>><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행" <%=m.getHobby().contains("여행")?"checked":"" %>>><label for="hobby4">여행</label><br />


				</td>
			</tr>
		</table>
        <input type="submit" value="정보수정"/>
        <input type="button" onclick="deleteMember();" value="탈퇴"/>
	</form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>

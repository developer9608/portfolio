<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/include/top.jsp" %>

<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	$(document).ready(function() {
		$('#IdCk').click(function() {
			var memberLoginId = $('#id').val();
			if (memberLoginId === "") {
				alert("아이디를 입력해주세요.");
				return false;
			}
			var dataStr = { memberLoginId : memberLoginId };
			$.ajax({
				type : "POST",
				url : path + "/IdCk.do",
				data : dataStr,
				success : function(data) {
					if (data === "T") {
						alert("사용 가능한 아이디 입니다.");
					} else if (data === "F") {
						alert("사용중인 아이디 입니다.");
						$('#id').val("");
						$('#id').focus();
					}
				}
			});
		});
	});	
	function submitCheck() {
		if (f1.id.value == "") {
			alert("아이디를 입력해주세요.");
			f1.id.focus();
			return false;
		} else if (f1.password.value == "") {
			alert("비밀번호를 입력해주세요.");
			f1.password.focus();
			return false;
		} else if (f1.password.value.length < 6) {
			alert("비밀번호를 6자리 이상 입력해주세요.");
			f1.password.focus();
			return false;
		} else if (f1.name.value == "") {
			alert("이름을 입력해주세요.");
			f1.name.focus();
			return false;
		} else if (f1.tel.value == "") {
			alert("전화번호를 입력해주세요.");
			f1.tel.focus();
			return false;
		} else if (f1.tel.value.length != 13) {
			alert("전화번호를 양식을 확인해주세요.(예: 010-1234-5678)");
			f1.tel.focus();
			return false;
		} else {
			alert("가입완료! 가입한 아이디로 다시 로그인 해주세요!");
		}
	}
</script>
<section>
	<br>
	<div align="center">
		<h3>회원가입</h3>
		<font color="red">*</font>표시는 반드시 기입해주세요.<br></div>
	<div class="Formcontainer">
		<form name="f1" action="insertMember.do" onSubmit="return submitCheck()">
				<table id="joinFormTable">
						<tr>
							<td align="center">아이디<font color="red">*</font></td>
							<td><input type="text" name="memberLoginId" id="id">&emsp;<input type="button" value="중복확인" id="IdCk"></td>
						</tr>
						<tr>
							<td align="center">비밀번호<font color="red">*</font></td>
							<td><input type="password" name="memberPassword" id="password" size="30" placeholder="최소 6자리이상 입력해주세요."></td>
						</tr>
						<tr>
							<td align="center">이름<font color="red">*</font></td>
							<td><input type="text" name="memberName" id="name" size="13"></td>
						</tr>
						<tr>
							<td align="center">전화번호<font color="red">*</font></td>
							<td><input type="text" name="memberPhone" id="tel" size="20" placeholder="010-0000-0000"></td>
						</tr>
						<tr>
							<td align="center">이메일</td>
							<td><input type="email" name="memberEmail" size="20" placeholder="ex)abc123@vehicle.com"></td>
						</tr>
				</table><br>
				<div align="center">
					<input type="submit" value="가입하기">
				</div>
		</form>	
	</div>
	<br>
</section>

<%@ include file="/include/bottom.jsp" %>

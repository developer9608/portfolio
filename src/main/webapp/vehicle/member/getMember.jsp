<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // Ajax 요청 시 캐시를 사용하지 않도록 설정
    $.ajaxSetup({cache:false});

    $('#updateButton').click(function() {
        // 필수 입력 확인
        if ($('#memberLoginId').val() == '') {
            alert("회원 아이디를 입력해 주세요.");
            $('#memberLoginId').focus();
            return false;
        } else if ($('#memberPassword').val() == '') {
            alert("회원 비밀번호를 입력해 주세요.");
            $('#memberPassword').focus();
            return false;
        } else if ($('#memberPassword').val().length < 7) {
            alert("비밀번호를 최소 6자 이상 입력해 주세요.");
            $('#memberPassword').focus();
            return false;
        } else if ($('#memberPhone').val() == '') {
            alert("회원 연락처를 입력해 주세요.");
            $('#memberPhone').focus();
            return false;
        } else if ($('#memberEmail').val() == '') {
            alert("회원 이메일을 입력해 주세요.");
            $('#memberEmail').focus();
            return false;
        }

        // FormData 객체 생성
        const formData = new FormData();
        formData.append("memberNo", $('#memberNo').val());
        formData.append("memberLoginId", $('#memberLoginId').val());
        formData.append("memberPassword", $('#memberPassword').val());
        formData.append("memberPhone", $('#memberPhone').val());
        formData.append("memberEmail", $('#memberEmail').val());

        // 컨트롤러 URL을 path 변수에 할당
        var path = '${pageContext.request.contextPath}';
        if (confirm('수정하시겠습니까?')) {
            $.ajax({
                type: "POST",
                url: path + "/memberUpdate.do",
                data: formData,
                contentType: false,
                processData: false,
                success: function (data) {
                    alert("수정 완료");
                    // 수정 성공 시 회원 정보 페이지로 이동
                    location.href = path + "/getMember.do?memberLoginId=" + $('#memberLoginId').val();
                },
                error: function (error) {
                    alert("에러 발생: " + error.statusText);
                }
            });
        } else {
            // 삭제 취소 시 처리
            alert("취소되었습니다.");
        }
    });

    $('#deleteButton').click(function() {
        var memberNo = $('#memberNo').val();
        var path = '<%=request.getContextPath()%>';

        if (confirm('정말로 탈퇴하시겠습니까?')) {
            $.ajax({
                type: 'POST',
                url: path + '/memberDelete.do',
                data: { memberNo: memberNo },
                success: function(data) {
                    alert("탈퇴가 완료되었습니다.");
                    location.replace(path + '/index.jsp');
                }
            });
        } else {
            // 탈퇴 취소 시 처리
            alert("탈퇴가 취소되었습니다.");
        }
    });
});
</script>

<section>
	<br>
	<div align="center">
		<h3>회원정보수정</h3>
		<font color="red">*</font>표시만 수정이 가능합니다.</div><br>
		<div class="getmembercontainer">
		<input type="hidden" name="memberNo" id="memberNo" value="${vo.memberNo}">
		<table id="joinFormTable">
			<tr>
				<th align="center">아이디</th>
				<td><input type="text" name="memberLoginId" id="memberLoginId" value="${vo.memberLoginId}" readonly></td>
			</tr>
			<tr>
				<th align="center">비밀번호<font color="red">*</font></th>
				<td><input type="text" name="memberPassword" id="memberPassword" value="${vo.memberPassword}" size="30" placeholder="최소 6자리이상 입력해주세요."></td>
			</tr>
			<tr>
				<th align="center">이름</th>
				<td><input type="text" name="memberName" id="memberName" value="${vo.memberName}" size="13"  readonly></td>
			</tr>
			<tr>
				<th align="center">전화번호<font color="red">*</font></th>
				<td><input type="text" name="memberPhone" id="memberPhone" value="${vo.memberPhone}" size="20" placeholder="010-0000-0000"></td>
			</tr>
			<tr>
				<th align="center">이메일<font color="red">*</font></th>
				<td><input type="email" name="memberEmail" id="memberEmail" value="${vo.memberEmail}" size="30" placeholder="ex)abc123@vehicle.com"></td>
			</tr>
		</table>		
	</div>
	<br>
	<div align=center>
					<input type="button" value="수정하기" id="updateButton">&nbsp;
					 <input type="button" value="탈퇴하기" id="deleteButton">
	</div>
	<br>
</section>
<%@ include file="/include/bottom.jsp" %>


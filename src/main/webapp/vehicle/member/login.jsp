<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>
<script>
    function logincheck() {
        var login_check = '<%= request.getAttribute("login_check") %>';
     
        if (login_check === 'F') {
            if (f1.memberLoginId.value === "" || f1.memberPassword.value === "") {
                alert("아이디와 비밀번호를 확인해주세요!");
                f1.memberLoginId.focus();
                return false;
            }
        }
        return true;
    }
</script>




<section>
		<div class="login">
			<div class="Logincontainer"  align="center">
	            <form name="f1" action="loginOK.do" method="POST" onSubmit="return logincheck()">
	                <table id="formLogin">
						<tr align="center">
	                        <td>
				               	<c:choose>
									<c:when test="${login_check == null || login_check == 'F'}">
										<h3>로그인</h3>
										<input type="text" name="memberLoginId" placeholder="아이디" value="admin111"><br><br>
										<input type="password" name="memberPassword" placeholder="비밀번호" value="admin123"><br><br>
										<input type="submit" value="로그인">
									</c:when>
									<c:otherwise>
										<font color='green'><b>${login_name}</b></font> 님 환영합니다!
									</c:otherwise>
								</c:choose>
							</td>			
	                    </tr>
	                </table>
	            </form>
        	</div>
     	</div>
</section>
<%@ include file="/include/bottom.jsp" %>

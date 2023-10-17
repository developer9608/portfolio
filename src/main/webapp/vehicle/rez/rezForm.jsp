<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>

<link rel="stylesheet" href="<%=path%>/css/total.css">
<script src="<%=path%>/js/setupRezDatepicker.js"></script>
<script>
	var path = '${pageContext.request.contextPath}';
	function checkVal() {
		if (f1.rezPhone.value == '') {
			alert('연락가능한 연락처를 입력해주세요.');
			f1.rezPhone.focus();
			return false;
		} else if (${login_id == null}) {
			alert('로그인이 필요합니다.');
			location.replace(path + "/login.do");
			return false;
		} else {
			if(confirm("예약하시겠습니까?")) {
				return true;
			} else {
				return false;
			}
		}
	}
</script>

<section>
<div align="center">
  		<h1>차량 시승 예약</h1></div>
  		<div class="getmodelcontainer">
			<form id="f1" action="rezFormOK.do" method="post" onSubmit="return checkVal();">
				<input type="hidden" name="rezLoginId" value="${login_id}">
				<input type="hidden" name="rezName" value="${login_name}">
				<table id="editTable">
				    <tr>
				    	<td colspan='2' align="center">
						<c:forEach items="${m.imageNames}" var="imageName">
			     				<img src="<%=path %>/vehicle/admin/files/${imageName}" alt="이미지" class="modelImg">
			            		</c:forEach>
			            	</td>
				    </tr>
				    <tr>
				        <th align="center">예약 차량 모델</th>
				        <td><input type="text" id="rezModelName" name="rezModelName" value="${mvo.modelName}" readonly></td>
				    </tr>
				    <tr>
				        <th align="center">예약자 전화번호</th>
				        <td><input type="tel" id="rezPhone" name="rezPhone" size="15" placeholder="010-0000-0000"></td>
				    </tr>
				    <tr>
					<th align="center">예약 희망 날짜</th>
					<td>
						<input type="text" id="startDate" name="startDate" size="10" placeholder="yyyy-MM-dd"> ~ 
						<input type="text" id="endDate" name="endDate" size="10" placeholder="yyyy-MM-dd">
					</td>
				    </tr>
				</table>
			    <br>
			    	<div align="center">
			    		<input type="submit" value="시승 예약하기">
			    	</div>
			</form>
		</div>
</section>

<%@ include file="/include/bottom.jsp" %>

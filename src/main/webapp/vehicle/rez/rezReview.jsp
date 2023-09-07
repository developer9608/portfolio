<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>

<link rel="stylesheet" href="<%=path%>/css/total.css">
<script>
	function checkVal() {
		if (f1.review.value == '') {
			alert('리뷰를 남겨주세요.');
			f1.review.focus();
			return false;
		} else {
			if(confirm("작성이 완료되었습니까?")) {
				return true;
			} else {
				return false;
			}
		}
	}
</script>
<section>
	<br>
	<div align="center"><h3>리뷰작성</h3></div>
	<div class="getmembercontainer">
		<form name="f1" action="<%=path%>/insertReview.do" onSubmit="return checkVal();">
			<input type="hidden" name="reviewNo" value="${vo.rezNo}">
			<input type="hidden" name="reviewLoginId" value="${login_id}">
			<input type="hidden" name="reviewName" value="${login_name}">
			<input type="hidden" name="reviewModelName" value="${vo.rezModelName}">
		<table id="reviewFormTable">
			<tr><th>차량명</th><td>${vo.rezModelName}</td></tr>
			<tr><th>예약자</th><td>${login_name}</td></tr>
			<tr style="border-bottom-style: double;">
				<th>예약일</th>
				<td>
					<fmt:formatDate value="${vo.startDate}" pattern="yyyy-MM-dd" /> ~ 
					<fmt:formatDate value="${vo.endDate}" pattern="yyyy-MM-dd" />
				</td>
			</tr>
			<tr><th>리뷰작성</th><td><textarea name="review" rows="6" cols="30" placeholder="한 줄 후기 남겨주세요."></textarea></td></tr>
		</table><br>
		<div align="center">
			<input type="submit" value="리뷰작성">
		</div>
		</form>
	</div>
	<br>
</section>
<%@ include file="/include/bottom.jsp" %>

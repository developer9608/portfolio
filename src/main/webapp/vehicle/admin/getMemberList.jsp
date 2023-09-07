<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ include file="/include/top.jsp" %>

<link rel="stylesheet" href="<%=path%>/css/total.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	function updateButton(memberNo, startIdx, searchT, searchV) {
		if (confirm('변경하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/memberAuthority.do',
				data: {
					memberNo: memberNo,
					memberRole: $("input[name='memberRole']:checked").val()
				},
				success: function(data) {
					console.log("변경 성공!")
					// 페이지를 유지하기 위한 부분
					location.replace(path + '/getMemberList.do');
				}
			}) // 비동기 처리
		} // 변경 확인
	}
	
	function deleteButton(memberNo, startIdx, searchT, searchV) {
		if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/memberDeleteAdmin.do',
				data: { memberNo: memberNo},
				success: function(data) {
					// 페이지를 유지하기 위한 부분
					location.replace(path + '/getMemberList.do');
				}
			}) // 비동기 처리
		} // 삭제 확인
	}
	
	$(document).ready(function() {
	    $('.memberRoleCheckbox').on('change', function() {
	        var clickedCheckbox = this;
	        if ($(clickedCheckbox).prop('checked')) {
	            $('.memberRoleCheckbox').not(clickedCheckbox).prop('checked', false);
	        }
	    });
	});
</script>
<section>
	<br>
	<div align="center"><h3>회원 권한 관리</h3></div>
	<div class="Search" align=center>
			<form action="getMemberList.do">
				<select name="searchTitle" id="searchTitle">
					<option value="memberLoginId">아이디</option>
					<option value="memberName">이름</option>
					<option value="memberRole">권한</option>
				</select>
				<input type="text" name="searchValue" id="searchValue" placeholder="검색어를 입력해주세요" size="60">
				<input type="submit" id="searchBtn" value="검색">
			</form>
	</div>
	<div class="tablecontainer">
		<c:if test="${not empty li}">
			<table border=1>
				<tr><th>회원번호</th><th>아이디</th><th>이름</th><th>권한</th><th>권한선택</th><th>변경/삭제</th></tr>
					<c:forEach items="${li}" var="vo">
						<c:if test="${vo.memberEnabled eq 'Y'}">
							<tr>
								<td>${vo.memberNo}</td>
								<td>${vo.memberLoginId}</td>
								<td>${vo.memberName}</td>
								<td>&nbsp; ${vo.memberRole}</td>
								<td id="role" class="roleColumn">&nbsp;
						                <c:choose>
								                    <c:when test="${login_role == 'ROLE_MEMBER' || login_name == vo.memberName}">
								                        <input type="checkbox"  class="memberRoleCheckbox" name="memberRole" value="ROLE_MEMBER" ${vo.memberRole eq 'ROLE_MEMBER' ? 'checked' : ''}>일반회원&nbsp;&nbsp;
								                        <input type="checkbox"  class="memberRoleCheckbox" name="memberRole" value="ROLE_ADMIN" ${vo.memberRole eq 'ROLE_ADMIN' ? 'checked' : ''}>시스템관리자&nbsp;&nbsp;
								                    </c:when>
								                    <c:when test="${login_role == 'ROLE_ADMIN'}">
								                        <input type="checkbox"  class="memberRoleCheckbox"  name="memberRole" value="ROLE_MEMBER" ${vo.memberRole eq 'ROLE_MEMBER' ? 'checked' : ''}>일반회원&nbsp;&nbsp;
								                        <input type="checkbox"  class="memberRoleCheckbox" name="memberRole" value="ROLE_ADMIN" ${vo.memberRole eq 'ROLE_ADMIN' ? 'checked' : ''}>시스템관리자&nbsp;&nbsp;
								                    </c:when>
						                </c:choose>
								</td>
								<td align="center" style="width: 150px;">
									<input type="button" value="변경" onClick="updateButton('${vo.memberNo}', '${startIdx}', '${searchTitle}', '${searchValue}')">&nbsp; / &nbsp;
									<input type="button" value="삭제" onClick="deleteButton('${vo.memberNo}', '${startIdx}', '${searchTitle}', '${searchValue}')">
								</td>
							</tr>
					</c:if>	
				</c:forEach>
			</table>
		</c:if>
		<c:if test="${empty li}">
			<table border="1" style="margin: 0 auto; border-collapse: collapse;">
				<tr>
					<td style="text-align: center; padding: 10px;">
						검색된 내용이 없습니다.
					</td>
				</tr>
			</table>
		</c:if>
	</div>
	<div id="page1" align=center>
			<c:url value="getMemberList.do" var="url">
				<c:param name="start_idx" value="1" />
				<c:param name="searchTitle" value="${searchTitle}" />
				<c:param name="searchValue" value="${searchValue}" />
			</c:url>
			<a href="${url}">처음</a>&emsp;
			
			<c:choose>
				<c:when test="${listStartPage > 1}">
					<c:url value="getMemberList.do" var="url">
						<c:param name="start_idx" value="${(listStartPage - 2) * pageSize + 1}" />
						<c:param name="searchTitle" value="${searchTitle}" />
						<c:param name="searchValue" value="${searchValue}" />
					</c:url>
					<a href="${url}">&lt;이전</a>&emsp;
				</c:when>
				<c:otherwise>
					&lt;&emsp;
				</c:otherwise>
			</c:choose>
			
			<c:forEach var="i" begin="${listStartPage}" end="${listEndPage}">
				<c:if test="${i < totalPage + 1}">
					<c:url value="getMemberList.do" var="url">
						<c:param name="start_idx" value="${(i - 1) * pageSize + 1}" />
						<c:param name="searchTitle" value="${searchTitle}" />
						<c:param name="searchValue" value="${searchValue}" />
					</c:url>
					<a href="${url}">${i}</a>&emsp;
				</c:if>
			</c:forEach>
			
			<c:choose>
				<c:when test="${listEndPage * pageSize + 1 > totalCount}">
					&gt;&emsp;
				</c:when>
				<c:otherwise>
					<c:url value="getMemberList.do" var="url">
						<c:param name="start_idx" value="${listEndPage * pageSize + 1}" />
						<c:param name="searchTitle" value="${searchTitle}" />
						<c:param name="searchValue" value="${searchValue}" />
					</c:url>
					<a href="${url}">다음&gt;</a>&emsp;
				</c:otherwise>
			</c:choose>
			
			<c:url value="getMemberList.do" var="url">
				<c:param name="start_idx" value="${endPage}" />
				<c:param name="searchTitle" value="${searchTitle}" />
				<c:param name="searchValue" value="${searchValue}" />
			</c:url>
			<a href="${url}">끝</a>
	</div>
</section>
<%@ include file="/include/bottom.jsp" %>


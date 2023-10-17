<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>

<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	function deleteReserve(rezNo, startIdx, id) {
		if (confirm('취소하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/deleteRez.do',
				data: { rezNo: rezNo},
				success: function(data) {
					location.replace(path + '/getRezList.do?start_idx=' + startIdx + '&id=' + id);
				}
			}) // 비동기 처리
		} // 삭제 확인
	}
	
	function writeReview(rezModelName) {
		$.ajax({
			type: 'POST',
			url: path + '/rezReview.do',
			data: { rezModelName: rezModelName },
			success: function(data) {
				location.replace(path + '/rezReview.do?rezModelName=' + rezModelName);
			}
		}) // 비동기 처리
	}
</script>

<section>
    <div align="center">
        <h1>시승예약 리스트</h1></div>
		    <div class="Search" align="center">
		        <font color="red">* </font>예약자분 성함 및 예약번호로 검색하세요<br>
		        <form action="<%=path %>/getRezList.do">
		            <select name="searchTitle">
		                <option value="rezNo">예약번호</option>
		                <option value="rezName">이름</option>
		            </select>
		            <input name="searchValue" type="text" placeholder="검색어를 입력해주세요" size="60">
		            <input type="submit" value="검색">
		        </form>
		    </div>
		    <div class="rezTableContainer">
		            <form id="f1"  method="post" onSubmit="return checkVal();">
		                <input type="hidden" name="rezLoginId" value="${login_id}">
		                <input type="hidden" name="rezName" value="${login_name}">
						<table>
						    <tr>
						        <th>차량</th>
						        <th>모델명</th>
						        <th>예약자</th>
						        <th>연락처</th>
						        <th>시승 날짜</th>
						        <th>예약취소</th>
						        <th>리뷰작성</th>
						    </tr>
						    <c:forEach items="${rli}" var="r">
							    <c:set var="modelList" value="${rezModelMap[r]}" />
							    <c:if test="${not empty modelList}">
							        <c:set var="firstModel" value="${modelList[0]}" />
							        <tr>
							            <td>
							                <c:forEach items="${firstModel.imageNames}" var="imageName">
							                    <c:if test="${imageName.indexOf('front') != -1}">
							                        <img src="<%=path %>/vehicle/admin/files/${imageName}" alt="이미지" class="rezImg">
							                    </c:if>
							                </c:forEach>
							            </td>
							            <td>${r.rezModelName}</td>
							            <td>${r.rezName}</td>
							            <td>${r.rezPhone}</td>
							            <td>
							                <fmt:formatDate value="${r.startDate}" pattern="yyyy-MM-dd" /> ~ 
							                <fmt:formatDate value="${r.endDate}" pattern="yyyy-MM-dd" />
							            </td>
							            <td>
							                <c:choose>
							                    <c:when test="${today < r.startDate && r.rezName eq login_name}">
							                        <input type="button" value="취소" onClick="deleteReserve(${r.rezNo}, ${startIdx}, '${login_id}')">
							                    </c:when>
							                    <c:otherwise>
							                        기한만료
							                    </c:otherwise>
							                </c:choose>
							            </td>
							            <td>
							                <c:choose>
							                    <c:when test="${r.writeReview == 'N' && r.rezName eq login_name}">
							                        <input type="button" value="작성하기" onClick="writeReview('${r.rezModelName}')">
							                    </c:when>
							                    <c:otherwise>
							                        작성완료
							                    </c:otherwise>
							                </c:choose>
							            </td>
							        </tr>
							    </c:if>
							</c:forEach>
						</table>
		            </form>       
    		</div>
	       <div id="page1" align=center>
				<c:url value="getRezList.do" var="url">
					<c:param name="startIdx" value="1" />
					<c:param name="searchTitle" value="${searchTitle}" />
					<c:param name="searchValue" value="${searchValue}" />
				</c:url>
			<a href="${url}">처음</a>&emsp;
			<c:choose>
				<c:when test="${listStartPage > 1}">
					<c:url value="getRezList.do" var="url">
						<c:param name="startIdx" value="${(listStartPage - 2) * pageSize + 1}" />
						<c:param name="searchTitle" value="${searchTitle}" />
						<c:param name="searchValue" value="${searchValue}" />
					</c:url>
					<a href="${url}">&lt;이전</a>&emsp;
				</c:when>
				<c:otherwise>
					&lt;
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" begin="${listStartPage}" end="${listEndPage}">
				<c:if test="${i < totalPage + 1}">
					<c:url value="getRezList.do" var="url">
						<c:param name="startIdx" value="${(i - 1) * pageSize + 1}" />
						<c:param name="searchTitle" value="${searchTitle}" />
						<c:param name="searchValue" value="${searchValue}" />
					</c:url>
					<a href="${url}">${i}</a>&emsp;
				</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${listEndPage * pageSize + 1 > totalCount}">
					&gt;
				</c:when>
				<c:otherwise>
					<c:url value="getRezList.do" var="url">
						<c:param name="startIdx" value="${listEndPage * pageSize + 1}" />
						<c:param name="searchTitle" value="${searchTitle}" />
						<c:param name="searchValue" value="${searchValue}" />
					</c:url>
					<a href="${url}">다음&gt;</a>&emsp;
				</c:otherwise>
			</c:choose>
			<c:url value="getRezList.do" var="url">
				<c:param name="startIdx" value="${endPage}" />
				<c:param name="searchTitle" value="${searchTitle}" />
				<c:param name="searchValue" value="${searchValue}" />
			</c:url>
			<a href="${url}">끝</a>
		</div>
</section>

<%@ include file="/include/bottom.jsp" %>

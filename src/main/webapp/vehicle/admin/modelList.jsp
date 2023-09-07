<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ include file="/include/top.jsp" %>

<link rel="stylesheet"  href="<%=path%>/css/total.css">
<section>
   <div align=center><h2>시승 차량 목록</h2></div>
	   <div class="Search" align=center>
	       <font color="red">*</font>이미지를 선택하면 상세화면으로 이동합니다. <br>
	            <form action="<%=path %>/modelList.do">
	            	<select>
		                    <option value="modelName">모델명</option>
		                    <option value="modelMake">제조사</option>
		                </select>
		                <input name="searchValue" type="text"  placeholder="검색어를 입력해주세요" size="60">
		                <input type="submit" value="검색">
	            </form>
	    </div>
	    <div class="Listcontainer">
	        <c:if test="${not empty li}">
	            <table border="1">
	                <c:forEach items="${li}" var="m">
					        <tr>
							    <td>
							        <c:forEach items="${m.imageNames}" var="imageName">
							            <a href="<%=path %>/getModel.do?modelNo=${m.modelNo}">
							                <img src="<%=path %>/vehicle/admin/files/${imageName}" alt="이미지" class="modelImg">
							            </a>
							        </c:forEach>
							    </td>
							</tr>
	                </c:forEach>
	            </table>
	        </c:if>
	        <c:if test="${empty li}">
	        	<table border="1">
	                <tr>
	                	<td>
	                    	검색된 내용이 없습니다.
	                    </td>
	            	</tr>
	        	</table>
	        </c:if>
	       </div>
	      <br>
	       <div id="page1" align=center>
				<c:url value="modelList.do" var="url">
					<c:param name="startIdx" value="1" />
							<c:param name="searchTitle" value="${searchTitle}" />
							<c:param name="searchValue" value="${searchValue}" />
				</c:url>
			<a href="${url}">처음</a>&emsp;
			<c:choose>
				<c:when test="${listStartPage > 1}">
					<c:url value="modelList.do" var="url">
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
					<c:url value="modelList.do" var="url">
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
					<c:url value="modelList.do" var="url">
						<c:param name="startIdx" value="${listEndPage * pageSize + 1}" />
						<c:param name="searchTitle" value="${searchTitle}" />
						<c:param name="searchValue" value="${searchValue}" />
					</c:url>
					<a href="${url}">다음&gt;</a>&emsp;
				</c:otherwise>
			</c:choose>
			<c:url value="modelList.do" var="url">
				<c:param name="startIdx" value="${endPage}" />
				<c:param name="searchTitle" value="${searchTitle}" />
				<c:param name="searchValue" value="${searchValue}" />
			</c:url>
			<a href="${url}">끝</a>
		</div>
</section>
<%@ include file="/include/bottom.jsp" %>


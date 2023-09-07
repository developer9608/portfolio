<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>

<script>
    function rez(modelNo) {
        if ("${login_check}" !== "T") {
            alert('로그인이 필요합니다.');
            location.href = "login.do";
        } else {
            location.href = "rezForm.do?modelNo=" + modelNo;
        }
    }
</script>


<section>
    <div align="center"><h2>차량 정보</h2></div>
    	<div class="getmodelcontainer" align=center>
	        <form action="<%=path%>/modelList.do" method="post" 
		        enctype="multipart/form-data">
	            <table border="1" class="editTable">
	            	<tr>
	                    <td colspan=2 align="center">
	                        <c:forEach items="${m.imageNames}" var="imageName">
	                                <img src="<%=path %>/vehicle/admin/files/${imageName}" alt="이미지" class="modelImg">
	                        </c:forEach>
	                <tr>
	                    <th align="center">모델명</th>
	                    <td align="left"><input type="text" name="modelName" value="${m.modelName}" readonly></td>
	                <tr>
	                    <th align="center">제조사</th>
	                    <td align="left"><input type="text" name="modelMake" value="${m.modelMake}" readonly></td>
	                <tr>
	                    <th align="center">년식</th>
	                    <td align="left"><input type="number" name="modelYear" value="${m.modelYear}" readonly>&nbsp;년식</td> 
	                <tr>
	                    <th align="center">상세설명</th>
	                    <td align="left"><textarea name="modelDesc" style="width=100%;, height=100px;" readonly>${m.modelDesc}</textarea></td>
	                </tr>
	            </table><br>
	            <div align="center">
	                <input type="button" value="예약하기" onClick="rez('${m.modelNo}')">
	                <input type="submit" value="목록보기">
	            </div>
	        </form>
	    </div>
    <br>
</section>

<%@ include file="/include/bottom.jsp" %>



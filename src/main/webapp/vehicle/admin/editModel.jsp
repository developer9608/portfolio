<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	var path = '${pageContext.request.contextPath}';
	jQuery.ajaxSetup({cache:false});
	$(document).ready(function() {
		$('#submitButton').click(function() {
			// 필수 입력 확인
			if ($('#modelName').val() == '') {
				alert("모델명을 입력해주세요.");
				$('#modelName').focus();
				return false;
			} else if ($('#modelMake').val() == '') {
				alert("제조사를 입력해주세요.");
				$('#modelMake').focus();
				return false;
			} else if ($('#modelYear').val() == '') {
				alert("자동차 연식을 입력해주세요.");
				$('#modelYear').focus();
				return false;
			} 
		})
	})

	function listButton() {
		location.href = "manageModelList.do";
	}
	
	function deleteButton(modelNo) {
	if (confirm('삭제하시겠습니까?')) {
			$.ajax({
				type: 'POST',
				url: path + '/deleteModel.do',
				data: { modelNo: modelNo },
				success: function(data) {
					alert("삭제되었습니다.")
					location.replace(path + '/manageModelList.do');
				}
			});
		}
	}
</script>

<section>
  	<div align="center"><h2>차량 정보 수정</h2></div>
    	<div class="getmodelcontainer" align=center>
    		<form action="<%=path%>/updateModel.do" enctype="multipart/form-data" method="POST">
	            <table border="1" class="editTable">
	            	<tr>
	            	    <th align="center">이미지</th>
	                    <td align="center">
	                        <c:forEach items="${m.imageNames}" var="imageName">
	                                <img src="<%=path %>/vehicle/admin/files/${imageName}" alt="이미지" class="modelImg">
	                        </c:forEach>
	                    </td>
					<tr>
	                    <th align="center">파일</th>
	                    <td>
	                    	<input type="file" name="modelImgList" id="modelImgList" value="${m.modelImgStr}"multiple> &nbsp;<font color="red">*</font> 미기입시 기본이미지로 변경됩니다.
	                    	<input type="hidden" name="modelNo" id="modelNo" value="${m.modelNo}" ></td>
	                <tr>
	                    <th align="center">모델명</th>
	                    <td><input type="text" name="modelName" id="modelName" value="${m.modelName}"></td>
	                <tr>
	                    <th align="center">제조사</th>
	                    <td><input type="text" name="modelMake" id="modelMake" value="${m.modelMake}" ></td>
	                <tr>
	                    <th align="center">년식</th>
	                    <td><input type="number" name="modelYear"  id="modelYear" value="${m.modelYear}" >&nbsp;년식</td> 
	                <tr>
	                    <th align="center">상세설명</th>
	                    <td><textarea name="modelDesc" style="width=100%;, height=100px;">${m.modelDesc}</textarea></td>
	                </tr>
	            </table>
		<br>
	            <div>
	                <input type="button" value="목록보기" onClick="listButton()">&emsp;
					<input type="submit" value="정보수정" id="submitButton"> &emsp;
	                <input type="button" value="삭제하기" onClick="deleteButton(${m.modelNo})">
	            </div>
	        </form>
	    </div>
    <br>
</section>

<%@ include file="/include/bottom.jsp" %>

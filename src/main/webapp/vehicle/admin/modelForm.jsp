<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/top.jsp" %>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(function() {
		  // Ajax 요청 시 캐시를 사용하지 않도록 설정
		  $.ajaxSetup({cache:false});
		  $('#submitButton').click(function() {
			// 필수 입력 확인
			if ($('#modelName').val() == '') {
				alert("차량 모델명을 입력해 주세요.");
				$('#modelName').focus();
				return false;
			} else if ($('#modelMake').val() == '') {
				alert("차량 제조사를 입력해 주세요.");
				$('#modelMake').focus();
				return false;
			} else if ($('#modelYear').val() == '') {
				alert("차량 연식을 입력해 주세요.");
				$('#modelYear').focus();
				return false;
			} else if ($('#modelDesc').val() == '') {
				alert("차량관련 설명을 입력해 주세요.");
				$('#modelDesc').focus();
				return false;
			}
			
		    // FormData 객체 생성
		    const formData = new FormData();
		    formData.append("modelName", $('#modelName').val());
		    formData.append("modelMake", $('#modelMake').val());
		    formData.append("modelYear", $('#modelYear').val());
		    formData.append("modelDesc", $('#modelDesc').val());

		    // 이미지 파일 추가
		    const inputElement = document.getElementById("modelImgList");
		    const fileCount = inputElement.files.length;
		    for (let i = 0; i < fileCount; i++) {
		      formData.append("modelImgList", inputElement.files[i]);
		    }
			
		    // 컨트롤러 URL을 path 변수에 할당
		    var path = '${pageContext.request.contextPath}';

		    $.ajax({
		      type: "POST",
		      url: path + "/insertModel.do",
		      data: formData,
		      contentType: false, 
		      processData: false,
		      success: function (data) {
		        alert("저장완료!");
		        $('#modelName').val('');
		        $('#modelMake').val('');
		        $('#modelYear').val('');
		        $('#modelDesc').val('');
		        $('#modelImgList').val('');
		      },
		    });
		  });
		});
	
	function listButton() {
		location.href="manageModelList.do"
	}
</script>
<section>
    <br>
    <div align="center" >
        <h2>차량 모델 등록</h2></div>
        <div class="Formcontainer">
            <table border="1">
                <tr>
                    <th align="center">모델명</th>
                    <td><input type="text" name="modelName" id="modelName"></td>
                <tr>
                    <th align="center">제조사</th>
                    <td><input type="text" name="modelMake" id="modelMake"></td>
                <tr>
                    <th align="center">년식</th>
                    <td><input type="number" name="modelYear" id="modelYear">&nbsp;년식</td>
                <tr>
                    <th align="center">이미지</th>
                    <td><input type="file" name="modelImgList"  id="modelImgList" multiple></td>
                <tr>
                    <th align="center">상세설명</th>
                    <td><textarea name="modelDesc" id="modelDesc" style="width=100%;, height=100px;"></textarea></td>
                </tr>
            </table>
            </div>
            <div align=center>
				<input type="button" value="목록보기" onClick="listButton()">&emsp;
                <input type="button" value="등록하기" id="submitButton">
            </div>

    <br>
</section>

<%@ include file="/include/bottom.jsp" %>

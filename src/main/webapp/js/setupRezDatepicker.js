/**
 * 
 */
 $(document).ready(function() {
	$.datepicker.setDefaults({
		showMonthAfterYear:true
	    	,showOn: "both"
	    	,buttonImage: "https://clipart-library.com/img/848153.jpg" //버튼 이미지 경로
	    	,buttonImageOnly: true //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        	,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
		,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
		,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
		,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
	});

	$('#startDate').datepicker({ minDate : +1 });
	$('#startDate').datepicker('setDate', '+1D');
	
	$('#endDate').datepicker({ minDate : +2 });
	$('#endDate').datepicker('setDate', '+2D');

})

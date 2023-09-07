package com.car.k1.rez;

import java.util.Date;

import lombok.Data;

@Data
public class RezVO {
    // 예약 정보
	private int rezNo;                  // 예약 번호
	private String rezLoginId;          // 예약한 회원 로그인 아이디
 	private String rezName;             // 예약한 회원 이름
 	private String rezPhone;            // 예약한 회원 전화번호
 	private String rezModelName;        // 예약한 차량 모델명
 	private Date startDate;             // 예약 시작 날짜
 	private Date endDate;               // 예약 종료 날짜
 	private String writeReview;         // 후기 작성 여부
 	
    // 예약 목록 페이지 관련
 	private int totalCount;              // 총 데이터 개수
 	private int startIdx;                // 페이지의 시작 인덱스
 	private int endIdx;                  // 페이지의 끝 인덱스
 	
 	// 검색 기능
  	private String searchTitle;          // 검색 제목
  	private String searchValue;          // 검색 값
  	
 	// 후기 정보
 	private int reviewNo;                // 후기 번호
 	private String reviewLoginId;		// 후기남긴 회원 아이디
 	private String reviewName;		//후기남긴 회원 이름
 	private String reviewModelName; // 후기남긴 차량 이름
 	private String review;                  // 후기 내용
 	private Date revieDate;              // 후기 작성일
}

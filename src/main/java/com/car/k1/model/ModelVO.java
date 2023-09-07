package com.car.k1.model;

import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ModelVO {
    private int modelNo;                  					 // 모델번호
    private String modelName;              				 // 모델명
    private String modelMake;             	 			 // 제조사
    private int modelYear;                 	 			 // 연식
    private String modelImgStr;			  	 			 // 모델 이미지 파일명
    private List<MultipartFile> modelImgList;  		 // 모델 이미지 파일 리스트
    private List<String> imageNames;             		 // 모델 이미지 파일명 리스트
    private String modelDesc;              				 // 모델 설명
    private Date created;                   				 // 등록일자

    // 페이지 관련
    private int totalCount;                // 총 데이터 개수
    private int startIdx;                  // 페이지의 시작 인덱스
    private int endIdx;                    // 페이지의 끝 인덱스
    
    private String searchTitle;            // 검색 타이틀
    private String searchValue;            // 검색 값
}

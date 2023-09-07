package com.car.k1.member;

import java.util.Date;
import lombok.Data;

@Data
public class MemberVO {
    private int memberNo;                   // 회원 번호
    private String memberName;              // 회원 이름
    private String memberLoginId;           // 회원 로그인 아이디
    private String memberPassword;          // 회원 비밀번호
    private String memberEncPassword;       // 암호화된 회원 비밀번호
    private String memberPhone;             // 회원 전화번호
    private String memberEmail;             // 회원 이메일
    private Date memberJoinDate;            // 회원 가입일
    private String joinDate;                // 가입일 문자열 형식
    private String memberEnabled;           // 회원 활성화 여부
    private Role memberRole;                // 회원 역할 (권한)

    // Member 목록 페이지 관련
    private int totalCount;                 // 총 데이터 개수
    private int startIdx;                   // 페이지의 시작 인덱스
    private int endIdx;                     // 페이지의 끝 인덱스
    
    // Member 검색
    private String searchTitle;             // 검색 제목
    private String searchValue;             // 검색 값
}

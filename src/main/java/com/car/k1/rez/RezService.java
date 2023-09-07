package com.car.k1.rez;

import java.util.List;


public interface RezService {
    void insertRez(RezVO vo);
    void deleteRez(RezVO vo);
    void updateWriteReview(RezVO vo);
 	RezVO getRez(RezVO vo);
    List<RezVO> getRezList(RezVO vo);
	int totalCount(RezVO vo);
	
 // 리뷰 등록, 삭제, 출력
 	void insertReview(RezVO vo);
 	void deleteReview(RezVO vo);
    
	int totalCountReview(RezVO vo);
    
}

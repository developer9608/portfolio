package com.car.k1.model;

import java.util.List;

public interface ModelService {
	void modelInsert(ModelVO vo);
	void modelInsertSub(ModelVO vo);
	void modelUpdate(ModelVO vo);
	void modelDelete(ModelVO vo);
	ModelVO modelOne(ModelVO vo);
	List<ModelVO> modelList(ModelVO vo);
    List<ModelVO> modelRezImg(ModelVO mvo);
	
	int totalCount(ModelVO vo);
}

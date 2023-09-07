package com.car.k1.model;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.car.k1.rez.RezVO;

@Service
public class ModelServiceImpl implements ModelService{

	@Autowired
	private ModelDao dao;
	
	@Override
	public void modelInsert(ModelVO vo) {
		dao.modelInsert(vo);
	}

	@Override
	public void modelInsertSub(ModelVO vo) {
		dao.modelInsertSub(vo);
	}
	
	@Override
	public void modelUpdate(ModelVO vo) {
		dao.modelUpdate(vo);
	}

	@Override
	public void modelDelete(ModelVO vo) {
		dao.modelDelete(vo);
	}
	
	@Override
	public ModelVO modelOne(ModelVO vo) {
		return dao.modelOne(vo);
	}
	
	@Override
	public List<ModelVO> modelList(ModelVO vo) {
		return dao.modelList(vo);
	}

	@Override
	public int totalCount(ModelVO vo) {
		return dao.totalCount(vo);
	}

	@Override
	public List<ModelVO> modelRezImg(ModelVO vo) {
		return dao.modelRezImg(vo);
	}
}

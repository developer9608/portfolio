package com.car.k1.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ModelDaoImpl implements ModelDao{

	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void modelInsert(ModelVO vo) {
		mybatis.insert("ModelDAO.MODEL_INSERT",vo);
	}
	
	@Override
	public void modelInsertSub(ModelVO vo) {
		mybatis.insert("ModelDAO.MODEL_INSERT_SUB", vo);
	}
	
	@Override
	public void modelUpdate(ModelVO vo) {
		mybatis.update("ModelDAO.MODEL_UPDATE",vo);
	}

	@Override
	public void modelDelete(ModelVO vo) {
		mybatis.delete("ModelDAO.MODEL_DELETE",vo);
	}

	@Override
	public ModelVO modelOne(ModelVO vo) {
		return  mybatis.selectOne("ModelDAO.MODEL_SELECT_ONE", vo);
	}

	@Override
	public List<ModelVO> modelList(ModelVO vo) {
		return mybatis.selectList("ModelDAO.MODEL_SELECT_ALL", vo);
	}

	@Override
	public int totalCount(ModelVO vo) {
		return mybatis.selectOne("ModelDAO.TOTAL_COUNT", vo);
	}

	@Override
	public List<ModelVO> modelRezImg(ModelVO vo) {
		return mybatis.selectList("ModelDAO.MODEL_REZ_IMG", vo);
	}
}

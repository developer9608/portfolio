package com.car.k1.rez;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class RezDaoImpl implements RezDao{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	//¿¹¾à
	@Override
	public void insertRez(RezVO vo) {
		mybatis.insert("RezDAO.REZ_INSERT", vo);
		
	}

	@Override
	public void updateWriteReview(RezVO vo) {
		mybatis.update("RezDAO.REZ_REVIEW", vo);
	}
	
	@Override
	public List<RezVO> getRezList(RezVO vo) {
		return mybatis.selectList("RezDAO.REZ_SELECTALL", vo);
	}

	@Override
	public int totalCount(RezVO vo) {
		return mybatis.selectOne("RezDAO.TOTAL_COUNT", vo);
	}

	@Override
	public void deleteRez(RezVO vo) {
		mybatis.delete("RezDAO.REZ_DELETE", vo);
		
	}
	
	// ¸®ºä
	@Override
	public void insertReview(RezVO vo) {
		mybatis.insert("RezDAO.REVIEW_INSERT", vo);
	}

	@Override
	public void deleteReview(RezVO vo) {
		mybatis.delete("RezDAO.REVIEW_DELETE", vo);
	}

	@Override
	public RezVO getRez(RezVO vo){
		return mybatis.selectOne("RezDAO.REVIEW_SELECTONE", vo);
	}

	@Override
	public int totalCountReview(RezVO vo) {
		return mybatis.selectOne("RezDAO.TOTAL_COUNT_REVIEW", vo);
	}



}

package com.car.k1.rez;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RezServiceImpl implements RezService{

	@Autowired
	private RezDao dao;

	@Override
	public void insertRez(RezVO vo) {
		dao.insertRez(vo);
	}

	@Override
	public void updateWriteReview(RezVO vo) {
		dao.updateWriteReview(vo);
	}

	@Override
	public List<RezVO> getRezList(RezVO vo) {
		return dao.getRezList(vo);
	}

	public int totalCount(RezVO vo) {
		return dao.totalCount(vo);
	}

	@Override
	public void deleteRez(RezVO vo) {
		dao.deleteRez(vo);
	}

	@Override
	public void insertReview(RezVO vo) {
		dao.insertReview(vo);
	}

	@Override
	public void deleteReview(RezVO vo) {
		dao.deleteReview(vo);
	}

	@Override
	public  	RezVO getRez(RezVO vo) {
		return dao.getRez(vo);
	}

	@Override
	public int totalCountReview(RezVO vo) {
		return dao.totalCountReview(vo);
	}

}

package com.car.k1.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao dao;
	
	@Override
	public void memberInsert(MemberVO vo) {
		dao.memberInsert(vo);
	}
	
	@Override
	public void memberUpdate(MemberVO vo) {
		dao.memberUpdate(vo);
	}

	@Override
	public void memberAuthority(MemberVO vo) {
		dao.memberAuthority(vo);
	}
	
	@Override
	public void memberDelete(MemberVO vo) {
		dao.memberDelete(vo);
	}

	@Override
	public MemberVO getMember(MemberVO vo) {
		return dao.getMember(vo);
	}

	@Override
	public List<MemberVO> getMemberList(MemberVO vo) {
		return dao.getMemberList(vo);
	}

	@Override
	public int totalCount(MemberVO vo) {
		return dao.totalCount(vo);
	}

}

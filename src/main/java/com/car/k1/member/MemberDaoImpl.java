package com.car.k1.member;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void memberInsert(MemberVO vo) {
		mybatis.insert("MemberDAO.MEMBER_INSERT", vo);
	}

	@Override
	public void memberUpdate(MemberVO vo) {
		mybatis.update("MemberDAO.MEMBER_UPDATE", vo);
	}

	@Override
	public void memberAuthority(MemberVO vo) {
		mybatis.update("MemberDAO.MEMBER_AUTHORITY", vo);
	}
	
	@Override
	public void memberDelete(MemberVO vo) {
		mybatis.delete("MemberDAO.MEMBER_DELETE", vo);
	}
	
	@Override
	public MemberVO getMember(MemberVO vo) {
		return mybatis.selectOne("MemberDAO.MEMBER_SELECT_ONE", vo);
	}

	@Override
	public List<MemberVO> getMemberList(MemberVO vo) {
		return mybatis.selectList("MemberDAO.MEMBER_SELECT_ALL", vo);
	}

	@Override
	public int totalCount(MemberVO vo) {
		return mybatis.selectOne("MemberDAO.TOTAL_COUNT", vo);
	}




}

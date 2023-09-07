package com.car.k1.member;

import java.util.List;

public interface MemberService {
    void memberInsert(MemberVO vo);
    void memberDelete(MemberVO vo);
    void memberUpdate(MemberVO vo);
    void memberAuthority(MemberVO vo);
    MemberVO getMember(MemberVO vo);
    List<MemberVO> getMemberList(MemberVO vo);

	int totalCount(MemberVO vo);
}

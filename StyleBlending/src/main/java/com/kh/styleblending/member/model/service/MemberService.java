package com.kh.styleblending.member.model.service;

import com.kh.styleblending.member.model.vo.Member;

public interface MemberService {

	// 1. 회원가입
	int insertMember(Member m);
	
	// 2. 로그인
	Member loginMember(Member m);
	
	// 3. 비밀번호 찾기
	
	// 4. 이메일ajax
	int joinCheckEmail(String id);
	
	// 5. 닉네임ajax
	int joinCheckNickName(String nickName);
	
}
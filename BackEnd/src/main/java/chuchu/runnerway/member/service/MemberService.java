package chuchu.runnerway.member.service;

import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;

public interface MemberService {
    String signUp(MemberSignUpRequestDto signUpMemberDto);
}

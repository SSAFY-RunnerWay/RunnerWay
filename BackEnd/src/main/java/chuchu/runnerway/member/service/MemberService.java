package chuchu.runnerway.member.service;

import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;
import chuchu.runnerway.member.dto.response.MemberSelectResponseDto;

public interface MemberService {
    String signUp(MemberSignUpRequestDto signUpMemberDto);
    MemberSelectResponseDto selectMember(Long memberId);
}

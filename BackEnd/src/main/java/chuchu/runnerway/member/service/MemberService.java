package chuchu.runnerway.member.service;

import chuchu.runnerway.member.dto.request.MemberFavoriteCourseRequestDto;
import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;
import chuchu.runnerway.member.dto.request.MemberUpdateRequestDto;
import chuchu.runnerway.member.dto.response.DuplicateNicknameResponseDto;
import chuchu.runnerway.member.dto.response.MemberIsFavoriteCourseResponseDto;
import chuchu.runnerway.member.dto.response.MemberSelectResponseDto;
import chuchu.runnerway.member.dto.response.MemberUpdateResponseDto;

public interface MemberService {
    String signUp(MemberSignUpRequestDto signUpMemberDto);
    MemberSelectResponseDto selectMember(Long memberId);
    MemberUpdateResponseDto updateMember(MemberUpdateRequestDto memberUpdateRequestDto, Long memberId);
    MemberIsFavoriteCourseResponseDto isFavoriteCourses(Long memberId);
    void registFavoriteCourses(MemberFavoriteCourseRequestDto memberFavoriteCourseRequestDto, Long memberId);
    void resignMember(Long memberId);
    DuplicateNicknameResponseDto checkDuplicateNickname(String nickname);
}

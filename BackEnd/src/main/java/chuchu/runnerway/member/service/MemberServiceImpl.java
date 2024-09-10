package chuchu.runnerway.member.service;

import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.domain.MemberImage;
import chuchu.runnerway.member.dto.MemberDto;
import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;
import chuchu.runnerway.member.dto.response.MemberSelectResponseDto;
import chuchu.runnerway.member.exception.MemberDuplicateException;
import chuchu.runnerway.member.exception.NotFoundMemberException;
import chuchu.runnerway.member.repository.MemberImageRepository;
import chuchu.runnerway.member.repository.MemberRepository;
import chuchu.runnerway.security.util.JwtUtil;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

    private final JwtUtil jwtUtil;
    private final MemberRepository memberRepository;
    private final ModelMapper mapper;
    private final MemberImageRepository memberImageRepository;

    @Transactional
    @Override
    public String signUp(MemberSignUpRequestDto signUpMemberDto) {
        Optional<Member> member = memberRepository.findByEmail(signUpMemberDto.getEmail());
        if (member.isPresent()) {
            throw new MemberDuplicateException();
        }

        Member savedMember = memberRepository.save(Member.signupBuilder()
            .memberSignUpRequestDto(signUpMemberDto)
            .build()
        );

        saveMemberImage(signUpMemberDto, savedMember);

        return jwtUtil.createAccessToken(mapper.map(savedMember, MemberDto.class));
    }

    @Override
    public MemberSelectResponseDto selectMember(Long memberId) {
        Member member = memberRepository.findById(memberId).orElseThrow(
            NotFoundMemberException::new
        );
        MemberSelectResponseDto memberSelectResponseDto = mapper.map(member, MemberSelectResponseDto.class);
//        MemberImageDto memberImageDto = mapper.map(memberImageRepository.findByMember(member), MemberImageDto.class);

        MemberSelectResponseDto responseDto = mapper.map(member, MemberSelectResponseDto.class);
//        responseDto.setMemberImage(memberImageDto);

        return memberSelectResponseDto;
    }

    private void saveMemberImage(MemberSignUpRequestDto signUpMemberDto, Member savedMember) {
        MemberImage memberImage = MemberImage.builder()
            .member(savedMember)
            .url(signUpMemberDto.getMemberImage().getUrl())
            .path(signUpMemberDto.getMemberImage().getPath())
            .build();
        memberImageRepository.save(memberImage);
    }
}

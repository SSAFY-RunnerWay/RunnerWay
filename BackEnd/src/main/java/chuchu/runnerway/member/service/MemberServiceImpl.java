package chuchu.runnerway.member.service;

import chuchu.runnerway.member.domain.FavoriteCourse;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.domain.MemberImage;
import chuchu.runnerway.member.dto.FavoriteCourseDto;
import chuchu.runnerway.member.dto.MemberDto;
import chuchu.runnerway.member.dto.request.MemberFavoriteCourseRequestDto;
import chuchu.runnerway.member.dto.request.MemberSignUpRequestDto;
import chuchu.runnerway.member.dto.request.MemberUpdateRequestDto;
import chuchu.runnerway.member.dto.response.MemberSelectResponseDto;
import chuchu.runnerway.member.exception.MemberDuplicateException;
import chuchu.runnerway.member.exception.NotFoundMemberException;
import chuchu.runnerway.member.exception.ResignedMemberException;
import chuchu.runnerway.member.repository.FavoriteCourseRepository;
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
    private final MemberImageRepository memberImageRepository;
    private final FavoriteCourseRepository favoriteCourseRepository;
    private final ModelMapper mapper;

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

    @Transactional
    @Override
    public MemberSelectResponseDto selectMember(Long memberId) {
        Member member = memberRepository.findById(memberId).orElseThrow(
            NotFoundMemberException::new
        );
        if (member.getIsResign() == 1) throw new ResignedMemberException();

        return mapper.map(member, MemberSelectResponseDto.class);
    }

    @Transactional
    @Override
    public void updateMember(MemberUpdateRequestDto memberUpdateRequestDto, Long memberId) {
        Member member = memberRepository.findById(memberId).orElseThrow(
            NotFoundMemberException::new
        );
        member.updateMember(memberUpdateRequestDto);

        MemberImage memberImage = memberImageRepository.findByMember(member).orElseThrow(
            NotFoundMemberException::new
        );
        memberImage.updateMemberImage(memberUpdateRequestDto.getMemberImage());

        memberRepository.save(member);
        memberImageRepository.save(memberImage);
    }

    @Override
    public void registFavoriteCourses(
        MemberFavoriteCourseRequestDto memberFavoriteCourseRequestDto,
        Long memberId
    ) {
        Member member = memberRepository.findById(memberId).orElseThrow(
            NotFoundMemberException::new
        );

        for (FavoriteCourseDto favoriteCourse : memberFavoriteCourseRequestDto.getFavoriteCourses()) {
            favoriteCourseRepository.save(FavoriteCourse.builder()
                .member(member)
                .tagName(favoriteCourse.getTagName())
                .build()
            );
        }
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

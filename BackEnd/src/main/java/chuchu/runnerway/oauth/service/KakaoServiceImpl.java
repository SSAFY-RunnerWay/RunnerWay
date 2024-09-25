package chuchu.runnerway.oauth.service;

import chuchu.runnerway.member.exception.MemberDuplicateException;
import chuchu.runnerway.member.exception.ResignedMemberException;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.dto.MemberDto;
import chuchu.runnerway.member.repository.MemberRepository;
import chuchu.runnerway.oauth.dto.KakaoMemberResponseDto;
import chuchu.runnerway.security.util.JwtUtil;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KakaoServiceImpl implements KakaoService {

    private final MemberRepository memberRepository;
    private final JwtUtil jwtUtil;
    private final ModelMapper mapper;

    @Override
    public KakaoMemberResponseDto getKakaoUser(String email) {;
        //이미 가입한 유저라면
        Optional<Member> member = memberRepository.findByEmail(email);
        if (member.isPresent()) {
            if (member.get().getIsResign().equals(1)) {
                throw new ResignedMemberException();
            }
            MemberDto memberDto = mapper.map(member.get(), MemberDto.class);
            String token = jwtUtil.createAccessToken(memberDto);
            throw new MemberDuplicateException(token);
        }
        return new KakaoMemberResponseDto(email);
    }
}

package chuchu.runnerway.badge.service;

import chuchu.runnerway.badge.domain.Badge;
import chuchu.runnerway.badge.dto.BadgeDto;
import chuchu.runnerway.badge.dto.response.BadgesSelectResponseDto;
import chuchu.runnerway.badge.repository.BadgeRepository;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.exception.NotFoundMemberException;
import chuchu.runnerway.member.repository.MemberRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BadgeServiceImpl implements BadgeService {

    private final MemberRepository memberRepository;
    private final BadgeRepository badgeRepository;
    private final ModelMapper mapper;

    @Override
    public BadgesSelectResponseDto selectAllMyBadge(Long memberId) {
        Member member = memberRepository.findById(memberId).orElseThrow(
            NotFoundMemberException::new
        );
        List<Badge> badgeList = badgeRepository.findAllByMember(member);
        mapper.typeMap(Badge.class, BadgeDto.class).addMapping(
            src -> src.getBadgeItem().getName(),
            BadgeDto::setName
        );
        List<BadgeDto> badgeDtoList = badgeList.stream()
            .map(badge -> {
                BadgeDto dto = mapper.map(badge, BadgeDto.class);
                return dto;
            })
            .toList();
        return new BadgesSelectResponseDto(badgeDtoList);
    }
}

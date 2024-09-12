package chuchu.runnerway.badge.service;

import chuchu.runnerway.badge.domain.Badge;
import chuchu.runnerway.badge.dto.BadgeDto;
import chuchu.runnerway.badge.dto.BadgeImageDto;
import chuchu.runnerway.badge.dto.response.BadgeSelectAllResponseDto;
import chuchu.runnerway.badge.dto.response.BadgeSelectResponseDto;
import chuchu.runnerway.badge.exception.NotFoundBadgeException;
import chuchu.runnerway.badge.exception.NotOwnerBadgeException;
import chuchu.runnerway.badge.repository.BadgeRepository;
import chuchu.runnerway.common.util.MemberInfo;
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
    public BadgeSelectAllResponseDto selectAllMyBadge(Long memberId) {
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
        return new BadgeSelectAllResponseDto(badgeDtoList);
    }

    @Override
    public BadgeSelectResponseDto selectBadge(Long badgeId) {
        Badge badge = badgeRepository.findById(badgeId).orElseThrow(
            NotFoundBadgeException::new
        );
        Long loginUserId = MemberInfo.getId();
        Member badgeOwner = badge.getMember();
        if (!badgeOwner.getMemberId().equals(loginUserId)) {
            throw new NotOwnerBadgeException();
        }

        return getBadgeSelectResponseDto(badge);
    }

    private BadgeSelectResponseDto getBadgeSelectResponseDto(Badge badge) {
        String name = badge.getBadgeItem().getName();
        String content = badge.getBadgeItem().getContent();

        // BadgeImage를 BadgeImageDto로 매핑
        BadgeImageDto badgeImageDto = mapper.map(badge.getBadgeItem().getBadgeImage(), BadgeImageDto.class);

        // BadgeSelectResponseDto로 변환
        return new BadgeSelectResponseDto(name, content, badge.getGetTime(), badgeImageDto);
    }
}

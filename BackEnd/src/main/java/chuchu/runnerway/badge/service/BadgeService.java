package chuchu.runnerway.badge.service;


import chuchu.runnerway.badge.dto.response.BadgesSelectResponseDto;

public interface BadgeService {
    BadgesSelectResponseDto selectAllMyBadge(Long memberId);
}

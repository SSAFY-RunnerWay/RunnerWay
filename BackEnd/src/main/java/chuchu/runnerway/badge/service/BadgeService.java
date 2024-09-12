package chuchu.runnerway.badge.service;


import chuchu.runnerway.badge.dto.response.BadgeSelectAllResponseDto;
import chuchu.runnerway.badge.dto.response.BadgeSelectResponseDto;

public interface BadgeService {
    BadgeSelectAllResponseDto selectAllMyBadge(Long memberId);
    BadgeSelectResponseDto selectBadge(Long badgeId);
}

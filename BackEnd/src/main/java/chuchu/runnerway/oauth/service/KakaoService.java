package chuchu.runnerway.oauth.service;

import chuchu.runnerway.oauth.dto.KakaoMemberResponseDto;

public interface KakaoService {
    KakaoMemberResponseDto getKakaoUser(String email);
}

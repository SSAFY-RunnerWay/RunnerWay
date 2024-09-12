package chuchu.runnerway.badge.controller;

import chuchu.runnerway.badge.dto.response.BadgesSelectResponseDto;
import chuchu.runnerway.badge.service.BadgeService;
import chuchu.runnerway.common.util.MemberInfo;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/badges")
@RestController
@RequiredArgsConstructor
public class BadgeController {

    private final BadgeService badgeService;

    @GetMapping
    @Operation(summary = "전체 뱃지 조회", description = "내가 소유한 전체 뱃지를 조회 할 때 사용하는 API")
    @ApiResponses(value = {
        @ApiResponse(
            responseCode = "200",
            description = "전체 뱃지 조회 성공!",
            content = @Content(mediaType = "application/json")
        ),
        @ApiResponse(
            responseCode = "500",
            description = "Error Message 로 전달함",
            content = @Content(mediaType = "application/json")
        ),
    })
    public ResponseEntity<?> selectAllMyBadge() {
        Long memberId = MemberInfo.getId();
        BadgesSelectResponseDto badgesSelectResponseDto = badgeService.selectAllMyBadge(memberId);
        return ResponseEntity.status(HttpStatus.OK).body(badgesSelectResponseDto);
    }
}

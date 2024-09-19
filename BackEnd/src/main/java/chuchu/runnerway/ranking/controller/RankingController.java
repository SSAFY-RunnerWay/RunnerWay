package chuchu.runnerway.ranking.controller;

import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.model.service.RankingService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/ranking")
@RequiredArgsConstructor
@Slf4j
@Validated
public class RankingController {

    private final RankingService rankingService;

    @GetMapping("/log/{rankId}")
    @Operation(summary = "랭킹 로그 경로 조회", description = "랭킹 로그 경로를 조회할 때 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "랭킹 로그 조회",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<String> getLankerLog(@PathVariable("rankId") Long rankId){
        String path = rankingService.getRankerLog(rankId);

        return ResponseEntity.status(200).body(path);
    }


    @GetMapping("/{courseId}")
    @Operation(summary = "코스 랭킹 조회", description = "코스 랭킹을 조회할 때 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "코스 랭킹 조회",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> getRankingByCourse(@PathVariable("courseId") Long courseId){
        List<RankingResponseDto> rankings = rankingService.getRankingByCourse(courseId);
        return ResponseEntity.status(200).body(rankings);
    }


}

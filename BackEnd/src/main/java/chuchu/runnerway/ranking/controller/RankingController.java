package chuchu.runnerway.ranking.controller;

import chuchu.runnerway.ranking.dto.request.RankingCheckRequestDto;
import chuchu.runnerway.ranking.dto.request.RankingRegisterRequestDto;
import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.model.service.RankingService;
import chuchu.runnerway.runningRecord.model.service.RunningRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
@RequestMapping("/ranking")
@RequiredArgsConstructor
@Slf4j
@Validated
public class RankingController {

    private final RankingService rankingService;
    private final RunningRecordService runningRecordService;

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
        if(path == null) return ResponseEntity.status(404).build();
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
        if(rankings.isEmpty()){
            return ResponseEntity.status(204).build();
        }
        return ResponseEntity.status(200).body(rankings);
    }

    @PostMapping
    @Operation(summary = "코스 랭킹 등록", description = "코스 랭킹을 등록할 때 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "코스 랭킹 등록",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> registRanking(@Valid @RequestBody RankingRegisterRequestDto rankingRegisterRequestDto){
        rankingService.registRanking(rankingRegisterRequestDto);
        return ResponseEntity.status(201).body("랭킹 등록 완료!!");
    }

    @GetMapping("/check")
    @Operation(summary = "코스 랭킹 갱신 여부", description = "코스 랭킹 갱신이 가능한지 판단하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "코스 랭킹 갱신 가능",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> rankingRenewCheck(@RequestParam("courseId") Long courseId,
                                               @RequestParam("score") String score){
        RankingCheckRequestDto rankingCheckRequestDto = new RankingCheckRequestDto(courseId, score);
        boolean check = rankingService.rankingRenewCheck(rankingCheckRequestDto);

        if(check) return ResponseEntity.status(200).body("등록 가능");

        else return ResponseEntity.status(422).body("등록 불가");

    }


}

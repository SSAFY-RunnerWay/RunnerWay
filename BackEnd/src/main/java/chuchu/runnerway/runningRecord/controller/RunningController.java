package chuchu.runnerway.runningRecord.controller;

import chuchu.runnerway.runningRecord.dto.request.*;
import chuchu.runnerway.runningRecord.dto.response.RecordDetailResponseDto;
import chuchu.runnerway.runningRecord.dto.response.RecordMonthData;
import chuchu.runnerway.runningRecord.dto.response.RecordResponseDto;
import chuchu.runnerway.runningRecord.model.service.RunningRecordService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.responses.ApiResponses;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/record")
@RequiredArgsConstructor
@Validated
@Slf4j
public class RunningController {

    private final RunningRecordService runningRecordService;

    @GetMapping
    @Operation(summary = "러닝 기록 목록 조회", description = "러닝기록 목록 조회 시 사용하는 API, day존재 시 일자별 조회")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "러닝 기록 목록 조회 성공",
                    content = @Content(mediaType = "application/json")
            ),
    })
    public ResponseEntity<?> getRunningRecords(
            @Valid @ModelAttribute RecordDateRequestDto requestDto) {

        List<RecordResponseDto> records = runningRecordService.getRecords(requestDto.getYear(), requestDto.getMonth(), requestDto.getDay());
        return ResponseEntity.status(200).body(records);
    }

    @Operation(summary = "러닝 기록 상세 조회", description = "러닝기록 상세 조회 시 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "러닝 기록 상세 조회 성공",
                    content = @Content(mediaType = "application/json")
            ),
    })
    @GetMapping("/detail/{recordId}")
    public ResponseEntity<?> getRunningRecord(@PathVariable("recordId") Long recordId){
        RecordDetailResponseDto record = runningRecordService.getRecord(recordId);

        return ResponseEntity.status(200).body(record);
    }

    @Operation(summary = "월별 러닝 기록 분석", description = "월별 러닝 기록 분석 조회 시 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "월별 러닝 기본 분석 조회 성공",
                    content = @Content(mediaType = "application/json")
            ),
    })
    @GetMapping("/analyze")
    public ResponseEntity<?> getAnalyzeRecord(
            @Valid @ModelAttribute RecordAnalyzeRequestDto requestDto){
        RecordMonthData recordMonthData = runningRecordService.getAnalysisRecord(requestDto.getYear(), requestDto.getMonth());
        return ResponseEntity.status(200).body(recordMonthData);
    }

    @Operation(summary = "러닝 기록 등록", description = "러닝 기록 등록 시 사용하는 API, 코스ID가 0일 시 나혼자 뛰기")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "201",
                    description = "러닝 기록 등록 성공, true시 랭킹 등록",
                    content = @Content(mediaType = "application/json")
            ),
            @ApiResponse(
                    responseCode = "500",
                    description = "Error Message 로 전달함",
                    content = @Content(mediaType = "application/json")
            ),
    })
    @PostMapping
    public ResponseEntity<?> registerRunningRecord(@Valid @RequestBody RecordRegistRequestDto requestDto){
        Map<String, Object> rankingCheck = runningRecordService.registRecord(requestDto);

        return ResponseEntity.status(201).body(rankingCheck);
    }

    @Operation(summary = "러닝 기록 사진 수정", description = "러닝 기록 사진 수정 시 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "러닝 기록 사진 수정",
                    content = @Content(mediaType = "application/json")
            ),
            @ApiResponse(
                    responseCode = "500",
                    description = "Error Message 로 전달함",
                    content = @Content(mediaType = "application/json")
            ),
    })
    @PatchMapping("/picture")
    public ResponseEntity<?> updatePersonalImage(@Valid @RequestBody RecordUpdatePictureRequestDto requestDto){
        runningRecordService.updateRecordPicture(requestDto);
        
        return ResponseEntity.status(200).body("사진 수정 완료!!");
    }

    @Operation(summary = "러닝 기록 한줄평 수정", description = "러닝 기록 한줄평 수정 시 사용하는 API")
    @ApiResponses(value = {
            @ApiResponse(
                    responseCode = "200",
                    description = "러닝 기록 한줄평 수정",
                    content = @Content(mediaType = "application/json")
            ),
            @ApiResponse(
                    responseCode = "500",
                    description = "Error Message 로 전달함",
                    content = @Content(mediaType = "application/json")
            ),
    })
    @PatchMapping("/comment")
    public ResponseEntity<?> updateRecordComment(@Valid @RequestBody RecordUpdateCommentRequestDto requestDto){
        runningRecordService.updateRecordComment(requestDto);

        return ResponseEntity.status(200).body("한줄평 수정 완료!!");
    }
}

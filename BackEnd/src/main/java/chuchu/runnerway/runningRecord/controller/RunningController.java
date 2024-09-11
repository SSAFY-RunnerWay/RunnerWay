package chuchu.runnerway.runningRecord.controller;

import chuchu.runnerway.runningRecord.dto.request.RecordAnalyzeRequestDto;
import chuchu.runnerway.runningRecord.dto.request.RecordDateRequestDto;
import chuchu.runnerway.runningRecord.dto.response.RecordDetailResponseDto;
import chuchu.runnerway.runningRecord.dto.response.RecordMonthData;
import chuchu.runnerway.runningRecord.dto.response.RecordResponseDto;
import chuchu.runnerway.runningRecord.model.service.RunningRecordService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/record")
@RequiredArgsConstructor
@Validated
@Slf4j
public class RunningController {

    private final RunningRecordService runningRecordService;

    @GetMapping
    public ResponseEntity<?> getRunningRecords(
            @Valid @ModelAttribute RecordDateRequestDto requestDto) {

        List<RecordResponseDto> records = runningRecordService.getRecords(requestDto.getYear(), requestDto.getMonth(), requestDto.getDay());
        return ResponseEntity.ok(records);
    }

    @GetMapping("/detail/{recordId}")
    public ResponseEntity<?> getRunningRecord(@PathVariable("recordId") Long recordId){
        RecordDetailResponseDto record = runningRecordService.getRecord(recordId);

        return ResponseEntity.ok(record);
    }

    @GetMapping("/analyze")
    public ResponseEntity<?> getAnalyzeRecord(
            @Valid @ModelAttribute RecordAnalyzeRequestDto requestDto){
        RecordMonthData recordMonthData = runningRecordService.getAnalysisRecord(requestDto.getYear(), requestDto.getMonth());
        return ResponseEntity.ok(recordMonthData);
    }
}

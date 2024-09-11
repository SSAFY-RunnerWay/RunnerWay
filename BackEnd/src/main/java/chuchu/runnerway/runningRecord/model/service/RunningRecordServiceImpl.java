package chuchu.runnerway.runningRecord.model.service;

import chuchu.runnerway.runningRecord.dto.response.RecordDetailResponseDto;
import chuchu.runnerway.runningRecord.dto.response.RecordMonthData;
import chuchu.runnerway.runningRecord.dto.response.RecordResponseDto;
import chuchu.runnerway.runningRecord.entity.RunningRecord;
import chuchu.runnerway.runningRecord.mapper.RunningRecordMapper;
import chuchu.runnerway.runningRecord.model.repository.RunningRecordRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Time;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Objects;

@Service
@RequiredArgsConstructor
@Slf4j
public class RunningRecordServiceImpl implements RunningRecordService{

    private final RunningRecordRepository runningRecordRepository;
    private final RunningRecordMapper runningRecordMapper;

    @Override
    public List<RecordResponseDto> getRecords(int year, int month, Integer day) {
        List<RunningRecord> runningRecords = runningRecordRepository.findByDate(year, month, day);
        if(runningRecords.isEmpty()) {
            throw new NoSuchElementException();
        }

        return runningRecordMapper.toRecordResponseDtoList(runningRecords);
    }

    @Transactional
    @Override
    public RecordDetailResponseDto getRecord(Long recordId) {
        RunningRecord runningRecord = runningRecordRepository.findById(recordId)
                .orElseThrow(NoSuchElementException::new);


        return runningRecordMapper.toRecordDetailResponseDto(runningRecord);
    }

    @Override
    public RecordMonthData getAnalysisRecord(int year, int month) {
        Map<String, Object> result = runningRecordRepository.getRecordMonthData(year, month)
                .orElseThrow(NoSuchElementException::new);
        return new RecordMonthData(
                ((Number) result.get("totalDistance")).doubleValue(),
                ((Number) result.get("averageFace")).doubleValue(),
                (Time) result.get("totalScore"),
                ((Number) result.get("totalCalorie")).doubleValue()
        );
    }
}

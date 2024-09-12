package chuchu.runnerway.runningRecord.model.service;

import chuchu.runnerway.common.util.MemberInfo;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.repository.MemberRepository;
import chuchu.runnerway.runningRecord.dto.request.RecordRegistRequestDto;
import chuchu.runnerway.runningRecord.dto.request.RecordUpdateCommentRequestDto;
import chuchu.runnerway.runningRecord.dto.request.RecordUpdatePictureRequestDto;
import chuchu.runnerway.runningRecord.dto.response.RecordDetailResponseDto;
import chuchu.runnerway.runningRecord.dto.response.RecordMonthData;
import chuchu.runnerway.runningRecord.dto.response.RecordResponseDto;
import chuchu.runnerway.runningRecord.entity.PersonalImage;
import chuchu.runnerway.runningRecord.entity.RunningRecord;
import chuchu.runnerway.runningRecord.mapper.RunningRecordMapper;
import chuchu.runnerway.runningRecord.model.repository.PersonalImageRepository;
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
    private final MemberRepository memberRepository;
    private final PersonalImageRepository personalImageRepository;

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

    @Transactional
    @Override
    public void registRecord(RecordRegistRequestDto requestDto) {
        Long memberId = MemberInfo.getId();
        Member member = memberRepository.findById(memberId)
                        .orElseThrow(NoSuchElementException::new);

        RunningRecord runningRecord = runningRecordMapper.toRegistRunningRecordDto(requestDto);
        runningRecord.registMember(member);
        runningRecord = runningRecordRepository.save(runningRecord);

        PersonalImage image = new PersonalImage();
        image.createPersonalImage(runningRecord, requestDto);
        personalImageRepository.save(image);
    }

    @Transactional
    @Override
    public void updateRecordPicture(RecordUpdatePictureRequestDto requestDto) {
        RunningRecord runningRecord = runningRecordRepository.findByRecordId(requestDto.getRecordId())
                .orElseThrow(NoSuchElementException::new);

        PersonalImage personalImage = personalImageRepository.findByRecordId(requestDto.getRecordId())
                .orElseThrow(NoSuchElementException::new);
        personalImage.updatePersonalImage(runningRecord, requestDto);

        personalImageRepository.save(personalImage);
    }

    @Override
    public void updateRecordComment(RecordUpdateCommentRequestDto requestDto) {
        RunningRecord runningRecord = runningRecordRepository.findByRecordId(requestDto.getRecordId())
                        .orElseThrow(NoSuchElementException::new);

        runningRecord.updateRunningRecord(requestDto);
        runningRecordRepository.save(runningRecord);
    }

}

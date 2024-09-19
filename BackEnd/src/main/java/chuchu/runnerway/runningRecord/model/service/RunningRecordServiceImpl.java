package chuchu.runnerway.runningRecord.model.service;

import chuchu.runnerway.common.util.MemberInfo;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.repository.MemberRepository;
import chuchu.runnerway.ranking.entity.Ranking;
import chuchu.runnerway.ranking.model.repository.RankingRepository;
import chuchu.runnerway.ranking.model.service.RankingService;
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
import org.springdoc.webmvc.ui.SwaggerConfigResource;
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

    private final RankingRepository rankingRepository;
    private final SwaggerConfigResource swaggerConfigResource;


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
    public boolean registRecord(RecordRegistRequestDto requestDto) {
        Long memberId = MemberInfo.getId();
        Member member = memberRepository.findById(memberId)
                        .orElseThrow(NoSuchElementException::new);

        RunningRecord runningRecord = runningRecordMapper.toRegistRunningRecordDto(requestDto);
        runningRecord.registMember(member);
        runningRecord = runningRecordRepository.save(runningRecord);

        PersonalImage image = new PersonalImage();
        image.createPersonalImage(runningRecord, requestDto);
        personalImageRepository.save(image);

        // 코스 랭킹 등록
        return registRanking(runningRecord.getCourse(), runningRecord, requestDto.getLogPath());
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

    @Transactional
    @Override
    public boolean registRanking(Course course, RunningRecord runningRecord, String logPath) {
        // 1. 코스에 대한 랭킹 조회
        List<Ranking> rankings = rankingRepository.findByCourse_CourseIdOrderByScore(course.getCourseId());

        // 현재 뛴 시간 조회
        Time score = runningRecord.getScore();

        // 예외처리 : 랭킹의 인원이 5명 이하일 시
        Long memberId = MemberInfo.getId();
        if(rankings.size() < 5){
            Member member = memberRepository.findById(memberId)
                    .orElseThrow(NoSuchElementException::new);

            // 만약 내 아이디가 존재한다면
            Ranking myRanking = rankingRepository.findByCourse_CourseIdAndMember_MemberId(course.getCourseId(), memberId);
            if(myRanking != null){
                if(score.before(myRanking.getScore())){
                    rankingRepository.deleteById(myRanking.getRankId());
                }
                else return false;
            }

            Ranking ranking = new Ranking();
            ranking.createRanking(course, member, score, logPath);
            rankingRepository.save(ranking);
            return true;
        }

        else {
            Ranking myRanking = rankingRepository.findByCourse_CourseIdAndMember_MemberId(course.getCourseId(), memberId);
            // 랭킹에 인원이 다 차지 않았는데 내 기록이 존재하고 기록 갱신이라면
            // 내 기록을 삭제하고 새로 갱신된 기록으로 대체
            if(myRanking != null){
                if(score.before(myRanking.getScore())){
                    rankingRepository.deleteById(myRanking.getRankId());
                    Member member = memberRepository.findById(memberId)
                            .orElseThrow(NoSuchElementException::new);
                    Ranking ranking = new Ranking();
                    ranking.createRanking(course, member, score, logPath);
                    rankingRepository.save(ranking);
                    return true;
                }
                else return false;
            }
            if(score.before(rankings.get(rankings.size()-1).getScore())){
                Member member = memberRepository.findById(memberId)
                                .orElseThrow(NoSuchElementException::new);
                rankingRepository.deleteById(rankings.get(rankings.size()-1).getRankId());
                Ranking ranking = new Ranking();
                ranking.createRanking(course, member, score, logPath);
                log.info("path: {}", ranking.getPath());
                rankingRepository.save(ranking);
                return true;
            }
            return false;
        }
    }
    
}

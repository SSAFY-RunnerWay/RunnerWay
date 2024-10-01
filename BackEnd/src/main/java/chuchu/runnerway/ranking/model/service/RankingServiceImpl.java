package chuchu.runnerway.ranking.model.service;

import chuchu.runnerway.common.util.MemberInfo;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.repository.MemberRepository;
import chuchu.runnerway.ranking.dto.request.RankingCheckRequestDto;
import chuchu.runnerway.ranking.dto.request.RankingRegisterRequestDto;
import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.entity.Ranking;
import chuchu.runnerway.ranking.mapper.RankingMapper;
import chuchu.runnerway.ranking.model.repository.RankingRepository;
import chuchu.runnerway.runningRecord.entity.RunningRecord;
import co.elastic.clients.elasticsearch._types.Rank;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class RankingServiceImpl implements RankingService{
    private final RankingRepository rankingRepository;
    private final RankingMapper rankingMapper;
    private final OfficialCourseRepository officialCourseRepository;
    private RunningRecord runningRecord;
    private final MemberRepository memberRepository;
    private final CacheManager cacheManager;

    @Override
    public String getRankerLog(Long rankId) {
        Ranking ranking = rankingRepository.findByRankId(rankId).orElse(null);
        if(ranking == null) return null;

        return ranking.getPath();

    }

    @Transactional
    @Override
    @Cacheable(value = "rankCache", key = "#courseId", unless = "#result == null")
    public List<RankingResponseDto> getRankingByCourse(Long courseId) {
        List<Ranking> rankings = rankingRepository.findByCourse_CourseIdOrderByScore(courseId);

        return rankingMapper.toRankingResponseDto(rankings);
    }

    @Override
    public void registRanking(RankingRegisterRequestDto rankingRegisterRequestDto) {
        Course course = officialCourseRepository.findByCourseId(rankingRegisterRequestDto.getCourseId())
                .orElseThrow(NoSuchElementException::new);
        Long memberId = MemberInfo.getId();
        Member member = memberRepository.findById(memberId)
                .orElseThrow(NoSuchElementException::new);

        Ranking ranking = new Ranking();
        ranking.createRanking(course, member, rankingRegisterRequestDto.getScore(), rankingRegisterRequestDto.getLogPath());
        rankingRepository.save(ranking);
        Objects.requireNonNull(cacheManager.getCache("rankCache")).evict(course.getCourseId());

    }

    @Override
    public boolean rankingRenewCheck(RankingCheckRequestDto rankingCheckRequestDto) {
        List<Ranking> rankings = rankingRepository.findByCourse_CourseIdOrderByScore(rankingCheckRequestDto.getCourseId());
        LocalTime score = LocalTime.parse(rankingCheckRequestDto.getScore(), DateTimeFormatter.ofPattern("HH:mm:ss"));

        Long memberId = MemberInfo.getId();
        if(rankings.size() < 5){
            Member member = memberRepository.findById(memberId)
                    .orElseThrow(NoSuchElementException::new);

            // 만약 내 아이디가 존재한다면
            Ranking myRanking = rankingRepository.findByCourse_CourseIdAndMember_MemberId(rankingCheckRequestDto.getCourseId(), memberId);
            if(myRanking != null){
                if(score.isBefore(myRanking.getScore())){
                    rankingRepository.deleteById(myRanking.getRankId());
                }
                else return false;
            }

            return true;
        }

        else {
            Ranking myRanking = rankingRepository.findByCourse_CourseIdAndMember_MemberId(rankingCheckRequestDto.getCourseId(), memberId);
            // 랭킹에 인원이 다 차지 않았는데 내 기록이 존재하고 기록 갱신이라면
            // 내 기록을 삭제하고 새로 갱신된 기록으로 대체
            if(myRanking != null){
                if(score.isBefore(myRanking.getScore())){
                    rankingRepository.deleteById(myRanking.getRankId());
                    return true;
                }
                else return false;
            }
            return score.isBefore(rankings.get(rankings.size() - 1).getScore());
        }
    }

}

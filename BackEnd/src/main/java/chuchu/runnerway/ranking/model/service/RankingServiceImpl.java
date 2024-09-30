package chuchu.runnerway.ranking.model.service;

import chuchu.runnerway.common.util.MemberInfo;
import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.course.model.repository.OfficialCourseRepository;
import chuchu.runnerway.member.domain.Member;
import chuchu.runnerway.member.repository.MemberRepository;
import chuchu.runnerway.ranking.dto.request.RankingRegisterRequestDto;
import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.entity.Ranking;
import chuchu.runnerway.ranking.mapper.RankingMapper;
import chuchu.runnerway.ranking.model.repository.RankingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;

@Service
@RequiredArgsConstructor
public class RankingServiceImpl implements RankingService{
    private final RankingRepository rankingRepository;
    private final RankingMapper rankingMapper;
    private final OfficialCourseRepository officialCourseRepository;
    private final MemberRepository memberRepository;
    private final CacheManager cacheManager;

    @Override
    public String getRankerLog(Long rankId) {
        Ranking ranking = rankingRepository.findByRankId(rankId)
                .orElseThrow(NoSuchElementException::new);

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
}

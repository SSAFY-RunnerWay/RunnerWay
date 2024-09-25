package chuchu.runnerway.ranking.model.service;

import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.entity.Ranking;
import chuchu.runnerway.ranking.mapper.RankingMapper;
import chuchu.runnerway.ranking.model.repository.RankingRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.NoSuchElementException;

@Service
@RequiredArgsConstructor
public class RankingServiceImpl implements RankingService{
    private final RankingRepository rankingRepository;
    private final RankingMapper rankingMapper;

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
        if(rankings.isEmpty())
            throw new NoSuchElementException();

        return rankingMapper.toRankingResponseDto(rankings);
    }
}

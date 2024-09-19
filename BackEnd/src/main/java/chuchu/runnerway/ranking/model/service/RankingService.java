package chuchu.runnerway.ranking.model.service;

import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.entity.Ranking;

import java.util.List;

public interface RankingService {

    String getRankerLog(Long rankId);

    List<RankingResponseDto> getRankingByCourse(Long courseId);

}

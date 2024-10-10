package chuchu.runnerway.ranking.model.service;

import chuchu.runnerway.course.entity.Course;
import chuchu.runnerway.ranking.dto.request.RankingCheckRequestDto;
import chuchu.runnerway.ranking.dto.request.RankingRegisterRequestDto;
import chuchu.runnerway.ranking.dto.response.RankingResponseDto;
import chuchu.runnerway.ranking.entity.Ranking;
import chuchu.runnerway.runningRecord.entity.RunningRecord;

import java.util.List;

public interface RankingService {

    String getRankerLog(Long rankId);

    List<RankingResponseDto> getRankingByCourse(Long courseId);

    void registRanking(RankingRegisterRequestDto rankingRegisterRequestDto);

    boolean rankingRenewCheck(RankingCheckRequestDto rankingCheckRequestDto);
}
